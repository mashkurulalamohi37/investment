from typing import List, Optional
from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from app.core.database import get_db
from app.schemas.common import StandardResponse
from app.schemas.investment import InvestmentOut
from app.schemas.expense import ExpenseCreate, ExpenseOut
from app.schemas.distribution import ProfitPeriodOut, CalculateProfitPeriodRequest
from app.models.investment import Investment, InvestmentStatus
from app.models.expense import Expense, ExpenseStatus
from app.models.audit_log import AuditLog
from app.services.investment_service import InvestmentService
from app.services.distribution_service import DistributionService
from app.core.permissions import require_admin, require_finance
from app.utils.id_generator import generate_transaction_ref

router = APIRouter(prefix="/admin", tags=["Admin Console"])


@router.get("/payments/pending", response_model=StandardResponse[List[InvestmentOut]], dependencies=[Depends(require_admin)])
async def get_pending_payments(db: AsyncSession = Depends(get_db)):
    stmt = (
        select(Investment)
        .where(Investment.status.in_([InvestmentStatus.UNDER_VERIFICATION, InvestmentStatus.PENDING_PAYMENT]))
        .order_by(Investment.created_at.desc())
    )
    res = await db.execute(stmt)
    items = list(res.scalars().all())
    return StandardResponse.ok([InvestmentOut.model_validate(i) for i in items])


@router.post("/payments/{investment_id}/verify", response_model=StandardResponse[InvestmentOut], dependencies=[Depends(require_finance)])
async def verify_payment_and_allocate_lots(
    investment_id: str,
    auth_payload: dict = Depends(require_finance),
    db: AsyncSession = Depends(get_db),
):
    admin_id = auth_payload["sub"]
    service = InvestmentService(db)
    inv = await service.admin_verify_and_allocate(investment_id=investment_id, admin_id=admin_id, admin_name="Finance Admin")
    return StandardResponse.ok(InvestmentOut.model_validate(inv))


@router.post("/expenses", response_model=StandardResponse[ExpenseOut], dependencies=[Depends(require_finance)])
async def create_expense_voucher(
    req: ExpenseCreate,
    auth_payload: dict = Depends(require_finance),
    db: AsyncSession = Depends(get_db),
):
    voucher_no = f"VCH-{generate_transaction_ref('EXP')}"
    expense = Expense(
        voucher_no=voucher_no,
        project_id=req.project_id,
        category=req.category,
        title=req.title,
        description=req.description,
        payee_name=req.payee_name,
        amount=req.amount,
        status=ExpenseStatus.APPROVED,
        receipt_url=req.receipt_url,
        expense_date=req.expense_date or req.expense_date.now(),
        audited_by="Finance Directorate",
        approved_by=auth_payload["sub"],
    )
    db.add(expense)
    await db.commit()
    await db.refresh(expense)
    return StandardResponse.ok(ExpenseOut.model_validate(expense))


@router.post("/distributions/calculate", response_model=StandardResponse[ProfitPeriodOut], dependencies=[Depends(require_finance)])
async def calculate_profit_distribution(
    req: CalculateProfitPeriodRequest,
    db: AsyncSession = Depends(get_db),
):
    service = DistributionService(db)
    period = await service.calculate_profit_period(
        project_id=req.project_id,
        period_title=req.period_title,
        period_title_bn=req.period_title_bn,
        period_start=req.period_start,
        period_end=req.period_end,
        realized_revenue=req.realized_revenue,
        realized_expenses=req.realized_expenses,
    )
    return StandardResponse.ok(ProfitPeriodOut.model_validate(period))
