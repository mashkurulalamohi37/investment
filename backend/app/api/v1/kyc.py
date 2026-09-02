from typing import Optional
from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.database import get_db
from app.schemas.common import StandardResponse
from app.schemas.kyc import KycSubmitRequest, KycProfileOut
from app.services.kyc_service import KycService
from app.core.permissions import require_authenticated

router = APIRouter(prefix="/kyc", tags=["KYC Compliance"])


@router.post("/submit", response_model=StandardResponse[KycProfileOut])
async def submit_kyc(
    req: KycSubmitRequest,
    auth_payload: dict = Depends(require_authenticated),
    db: AsyncSession = Depends(get_db),
):
    user_id = auth_payload["sub"]
    service = KycService(db)
    profile = await service.submit_kyc(user_id=user_id, kyc_data=req.model_dump())
    return StandardResponse.ok(KycProfileOut.model_validate(profile))


@router.get("/me", response_model=StandardResponse[Optional[KycProfileOut]])
async def get_my_kyc(
    auth_payload: dict = Depends(require_authenticated),
    db: AsyncSession = Depends(get_db),
):
    user_id = auth_payload["sub"]
    service = KycService(db)
    profile = await service.get_kyc_by_user(user_id=user_id)
    data = KycProfileOut.model_validate(profile) if profile else None
    return StandardResponse.ok(data)
