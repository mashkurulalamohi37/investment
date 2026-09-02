from typing import List
from fastapi import APIRouter, Depends, Request
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.database import get_db
from app.schemas.common import StandardResponse
from app.schemas.investment import InvestmentCreateRequest, InvestmentOut
from app.services.investment_service import InvestmentService
from app.core.permissions import require_authenticated

router = APIRouter(prefix="/investments", tags=["Investments"])


@router.post("", response_model=StandardResponse[InvestmentOut])
async def create_investment(
    req: InvestmentCreateRequest,
    request: Request,
    auth_payload: dict = Depends(require_authenticated),
    db: AsyncSession = Depends(get_db),
):
    user_id = auth_payload["sub"]
    ip_addr = request.client.host if request.client else None

    service = InvestmentService(db)
    investment = await service.create_investment(
        user_id=user_id,
        user_name="Investor",
        project_id=req.project_id,
        shares=req.shares,
        payment_method=req.payment_method,
        payment_gateway=req.payment_gateway,
        deposit_bank_name=req.deposit_bank_name,
        depositor_name=req.depositor_name,
        payment_reference=req.payment_reference,
        receipt_image_url=req.receipt_image_url,
        ip_address=ip_addr,
    )
    return StandardResponse.ok(InvestmentOut.model_validate(investment))


@router.get("/me", response_model=StandardResponse[List[InvestmentOut]])
async def get_my_investments(
    auth_payload: dict = Depends(require_authenticated),
    db: AsyncSession = Depends(get_db),
):
    user_id = auth_payload["sub"]
    service = InvestmentService(db)
    investments = await service.get_user_investments(user_id=user_id)
    return StandardResponse.ok([InvestmentOut.model_validate(i) for i in investments])
