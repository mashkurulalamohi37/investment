from datetime import datetime, timezone
from decimal import Decimal
from typing import List, Optional
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, func
from app.models.project import Project, ProjectStatus
from app.models.investment import Investment, InvestmentStatus, InvestmentStatusHistory
from app.models.payment import Payment, PaymentStatus, PaymentGatewayType
from app.models.transaction import Transaction, TransactionType, TransactionDirection, TransactionStatus, LedgerEntry
from app.models.audit_log import AuditLog, OutboxEvent
from app.core.exceptions import (
    NotFoundException,
    ConflictException,
    SharesUnavailableException,
    PermissionDeniedException,
)
from app.utils.money import calculate_investment_amount
from app.utils.id_generator import generate_investment_number, generate_transaction_ref
from app.core.redis import delete_cache


class InvestmentService:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def create_investment(
        self,
        user_id: str,
        user_name: str,
        project_id: str,
        shares: int,
        payment_method: str = "EPS (bKash)",
        payment_gateway: str = "EPS",
        deposit_bank_name: Optional[str] = None,
        depositor_name: Optional[str] = None,
        payment_reference: Optional[str] = None,
        receipt_image_url: Optional[str] = None,
        ip_address: Optional[str] = None,
    ) -> Investment:
        """
        Concurrency-safe Investment Creator with Row-level Lock (SELECT FOR UPDATE).
        Guarantees zero over-allocations and sequential lot number assignment.
        """
        # 1. Lock project row
        stmt = select(Project).where((Project.id == project_id) | (Project.code == project_id)).with_for_update()
        result = await self.db.execute(stmt)
        project = result.scalar_one_or_none()

        if not project:
            raise NotFoundException("Project not found", code="PROJECT_NOT_FOUND")

        if project.status != ProjectStatus.OPEN and project.status != ProjectStatus.FUNDING:
            raise ConflictException(f"Project is not open for subscription (Status: {project.status.value})", code="PROJECT_NOT_OPEN")

        # 2. Check investor total shares in this project (Limit 1 to 4)
        user_shares_stmt = (
            select(func.coalesce(func.sum(Investment.shares), 0))
            .where(
                Investment.user_id == user_id,
                Investment.project_id == project.id,
                Investment.status.in_([InvestmentStatus.APPROVED, InvestmentStatus.ALLOCATED, InvestmentStatus.UNDER_VERIFICATION, InvestmentStatus.PENDING_PAYMENT]),
            )
        )
        user_shares_res = await self.db.execute(user_shares_stmt)
        existing_shares = user_shares_res.scalar_one()

        if existing_shares + shares > project.max_shares:
            raise ConflictException(
                f"Investor maximum limit exceeded. Allowed: {project.max_shares}, currently held/pending: {existing_shares}",
                code="SHARE_LIMIT_EXCEEDED",
            )

        # 3. Check project available shares
        available = project.total_shares - project.allocated_shares - project.reserved_shares
        if shares > available:
            raise SharesUnavailableException(
                f"Only {available} shares remain available in {project.name}. Requested: {shares}"
            )

        # 4. Authoritative amount calculation
        unit_price = project.price_per_share
        gross_amount = calculate_investment_amount(shares, unit_price)

        # 5. Determine status & lot numbers
        count_stmt = select(func.count(Investment.id)).where(Investment.project_id == project.id)
        count_res = await self.db.execute(count_stmt)
        total_inv_count = count_res.scalar_one()

        inv_no = generate_investment_number(project.code, total_inv_count + 1)
        ref_code = payment_reference or generate_transaction_ref("TXN-EPS")

        # For instant EPS gateway: auto allocate; for manual bank: set UNDER_VERIFICATION
        if payment_gateway == "EPS":
            inv_status = InvestmentStatus.ALLOCATED
            current_allocated = project.allocated_shares
            lot_numbers = [f"LOT-{str(current_allocated + i).zfill(3)}" for i in range(1, shares + 1)]
            lot_str = ", ".join(lot_numbers)
            project.allocated_shares += shares
            verified_at = datetime.now(timezone.utc)
        else:
            inv_status = InvestmentStatus.UNDER_VERIFICATION
            lot_str = None
            verified_at = None

        investment = Investment(
            investment_no=inv_no,
            user_id=user_id,
            project_id=project.id,
            shares=shares,
            unit_price=unit_price,
            gross_amount=gross_amount,
            fees=Decimal("0.00"),
            net_amount=gross_amount,
            status=inv_status,
            allocated_lot_numbers=lot_str,
            payment_method=payment_method,
            payment_reference=ref_code,
            payment_gateway=payment_gateway,
            receipt_image_url=receipt_image_url,
            deposit_bank_name=deposit_bank_name,
            depositor_name=depositor_name or user_name,
            verified_at=verified_at,
        )
        self.db.add(investment)
        await self.db.flush()

        # 6. Create double-entry transaction record
        txn_status = TransactionStatus.COMPLETED if inv_status == InvestmentStatus.ALLOCATED else TransactionStatus.PENDING
        transaction = Transaction(
            reference=ref_code,
            user_id=user_id,
            project_id=project.id,
            investment_id=investment.id,
            type=TransactionType.INVESTMENT,
            direction=TransactionDirection.DEBIT,
            amount=gross_amount,
            balance_after=gross_amount,
            currency="BDT",
            payment_method=payment_method,
            receipt_image_url=receipt_image_url,
            deposit_bank_name=deposit_bank_name,
            depositor_name=depositor_name or user_name,
            status=txn_status,
            description=f"Subscription for {shares} Shares in {project.name} ({lot_str or 'Pending Verification'})",
            description_bn=f"{project.name_bn} প্রকল্পে {shares}টি শেয়ার সাবস্ক্রিপশন ({lot_str or 'যাচাইাধীন'})",
        )
        self.db.add(transaction)
        await self.db.flush()

        # Ledger entries
        ledger_debit = LedgerEntry(
            transaction_id=transaction.id,
            account_code="1010-CASH-SETTLEMENT",
            account_name="Cash & Bank Clearing Account",
            debit=gross_amount,
            credit=Decimal("0.00"),
            narration=f"Payment received for {inv_no}",
        )
        ledger_credit = LedgerEntry(
            transaction_id=transaction.id,
            account_code="2010-INVESTOR-EQUITY",
            account_name=f"Investor Equity ({project.code})",
            debit=Decimal("0.00"),
            credit=gross_amount,
            narration=f"Equity issuance for {inv_no}",
        )
        self.db.add_all([ledger_debit, ledger_credit])

        # 7. Audit Log
        audit = AuditLog(
            actor_id=user_id,
            actor_name=user_name,
            actor_role="Investor",
            action="INVESTMENT_CREATED",
            action_bn="বিনিয়োগ আবেদন সৃষ্টি",
            entity_type="Investment",
            entity_id=inv_no,
            details=f"Purchased {shares} shares in {project.name} for BDT {gross_amount} via {payment_method}",
            details_bn=f"{payment_method} মাধ্যমে {project.name_bn} প্রকল্পে {shares}টি শেয়ার (৳{gross_amount}) বিনিয়োগ আবেদন",
            ip_address=ip_address,
        )
        self.db.add(audit)

        # 8. Outbox Event for async notifications & PDF certificate generation
        outbox = OutboxEvent(
            event_type="INVESTMENT_CREATED",
            payload={
                "investment_id": investment.id,
                "investment_no": inv_no,
                "user_id": user_id,
                "project_id": project.id,
                "shares": shares,
                "amount": str(gross_amount),
                "is_allocated": inv_status == InvestmentStatus.ALLOCATED,
            },
        )
        self.db.add(outbox)

        # Commit entire atomic unit of work
        await self.db.commit()
        await self.db.refresh(investment)
        await delete_cache(f"projects_list_*")
        return investment

    async def get_user_investments(self, user_id: str) -> List[Investment]:
        stmt = (
            select(Investment)
            .where(Investment.user_id == user_id)
            .order_by(Investment.created_at.desc())
        )
        result = await self.db.execute(stmt)
        return list(result.scalars().all())

    async def admin_verify_and_allocate(self, investment_id: str, admin_id: str, admin_name: str) -> Investment:
        """Admin Payment Verification and Lot Number Allocation."""
        inv_stmt = select(Investment).where(Investment.id == investment_id).with_for_update()
        inv_res = await self.db.execute(inv_stmt)
        inv = inv_res.scalar_one_or_none()

        if not inv:
            raise NotFoundException("Investment not found", code="INVESTMENT_NOT_FOUND")

        if inv.status == InvestmentStatus.ALLOCATED:
            return inv  # Idempotent return

        proj_stmt = select(Project).where(Project.id == inv.project_id).with_for_update()
        proj_res = await self.db.execute(proj_stmt)
        project = proj_res.scalar_one()

        current_allocated = project.allocated_shares
        lot_numbers = [f"LOT-{str(current_allocated + i).zfill(3)}" for i in range(1, inv.shares + 1)]
        lot_str = ", ".join(lot_numbers)

        project.allocated_shares += inv.shares
        inv.status = InvestmentStatus.ALLOCATED
        inv.allocated_lot_numbers = lot_str
        inv.verified_at = datetime.now(timezone.utc)
        inv.verified_by = admin_id

        # Update matching transaction
        txn_stmt = select(Transaction).where(Transaction.investment_id == investment_id)
        txn_res = await self.db.execute(txn_stmt)
        txn = txn_res.scalar_one_or_none()
        if txn:
            txn.status = TransactionStatus.COMPLETED
            txn.description = f"Verified & Allocated: {lot_str}"

        # Audit Log
        audit = AuditLog(
            actor_id=admin_id,
            actor_name=admin_name,
            actor_role="Admin",
            action="ALLOCATE_SHARES",
            action_bn="শেয়ার লট বরাদ্দ ও অনুমোদন",
            entity_type="Investment",
            entity_id=inv.investment_no,
            details=f"Verified payment and allocated lots: {lot_str}",
            details_bn=f"পেমেন্ট যাচাই সম্পন্ন ও লট {lot_str} সফলভাবে বরাদ্দকৃত",
        )
        self.db.add(audit)

        # Outbox event
        outbox = OutboxEvent(
            event_type="PAYMENT_VERIFIED",
            payload={"investment_id": inv.id, "lots": lot_numbers, "user_id": inv.user_id},
        )
        self.db.add(outbox)

        await self.db.commit()
        await self.db.refresh(inv)
        await delete_cache("projects_list_*")
        return inv
