from datetime import datetime, timezone
from decimal import Decimal
from typing import Optional, Dict, Any
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
import httpx

from app.models.payment import Payment, PaymentStatus, PaymentGatewayType
from app.models.investment import Investment
from app.core.config import settings
from app.core.exceptions import NotFoundException, ConflictException
from app.utils.id_generator import generate_transaction_ref


class PaymentService:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def initiate_eps_session(
        self,
        investment_id: str,
        user_id: str,
        channel: str = "bKash",
        customer_phone: Optional[str] = None,
    ) -> Dict[str, Any]:
        """Initiate an EPS (Easy Payment System) Gateway payment session."""
        stmt = select(Investment).where(Investment.id == investment_id)
        result = await self.db.execute(stmt)
        inv = result.scalar_one_or_none()

        if not inv:
            raise NotFoundException("Investment not found", code="INVESTMENT_NOT_FOUND")

        txn_ref = generate_transaction_ref("EPS-TXN")

        # Create pending payment record
        payment = Payment(
            investment_id=inv.id,
            user_id=user_id,
            amount=inv.gross_amount,
            currency="BDT",
            payment_gateway=PaymentGatewayType.EPS,
            payment_method=f"EPS ({channel})",
            reference=txn_ref,
            status=PaymentStatus.PENDING,
        )
        self.db.add(payment)
        await self.db.commit()

        # In a live production deployment, we make an HTTP request to EPS API:
        # payload = {
        #     "merchant_id": settings.EPS_MERCHANT_ID,
        #     "store_id": settings.EPS_STORE_ID,
        #     "amount": str(inv.gross_amount),
        #     "currency": "BDT",
        #     "reference": txn_ref,
        #     "channel": channel,
        # }
        # async with httpx.AsyncClient() as client:
        #     resp = await client.post(f"{settings.eps_active_base_url}/checkout/initiate", json=payload)
        #     gateway_res = resp.json()

        return {
            "is_success": True,
            "eps_transaction_id": f"EPS-{txn_ref}",
            "merchant_transaction_id": txn_ref,
            "amount": inv.gross_amount,
            "redirect_url": f"https://gateway.epay.com.bd/pay/{txn_ref}",
            "message": "EPS Checkout session initialized successfully.",
        }

    async def handle_eps_callback(self, callback_data: Dict[str, Any]) -> bool:
        """Process instant IPN callback webhook from EPS Payment Gateway."""
        merchant_ref = callback_data.get("merchant_transaction_id")
        eps_status = callback_data.get("status")

        stmt = select(Payment).where(Payment.reference == merchant_ref)
        res = await self.db.execute(stmt)
        payment = res.scalar_one_or_none()

        if not payment:
            return False

        if eps_status == "SUCCESS":
            payment.status = PaymentStatus.VERIFIED
            payment.verified_at = datetime.now(timezone.utc)
            payment.gateway_txn_id = callback_data.get("eps_transaction_id")
            payment.gateway_response_raw = callback_data
            await self.db.commit()
            return True
        else:
            payment.status = PaymentStatus.FAILED
            payment.rejection_reason = callback_data.get("error_message", "Payment failed at gateway")
            await self.db.commit()
            return False
