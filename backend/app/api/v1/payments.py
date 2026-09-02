from typing import Dict, Any
from fastapi import APIRouter, Depends, Request
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.database import get_db
from app.schemas.common import StandardResponse
from app.schemas.payment import (
    EpsSessionInitiateRequest,
    EpsSessionResponse,
    BankTransferSubmitRequest,
    PaymentOut,
)
from app.services.payment_service import PaymentService
from app.core.permissions import require_authenticated

router = APIRouter(prefix="/payments", tags=["Payments"])


@router.post("/eps/initiate", response_model=StandardResponse[EpsSessionResponse])
async def initiate_eps_payment(
    req: EpsSessionInitiateRequest,
    auth_payload: dict = Depends(require_authenticated),
    db: AsyncSession = Depends(get_db),
):
    user_id = auth_payload["sub"]
    service = PaymentService(db)
    session_res = await service.initiate_eps_session(
        investment_id=req.investment_id,
        user_id=user_id,
        channel=req.channel,
        customer_phone=req.customer_phone,
    )
    return StandardResponse.ok(EpsSessionResponse(**session_res))


@router.post("/eps/callback", response_model=StandardResponse[dict])
async def eps_ipn_callback(
    payload: Dict[str, Any],
    db: AsyncSession = Depends(get_db),
):
    service = PaymentService(db)
    success = await service.handle_eps_callback(payload)
    return StandardResponse.ok({"received": True, "processed": success})
