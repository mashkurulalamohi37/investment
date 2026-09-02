from fastapi import APIRouter, Depends, status
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.database import get_db
from app.schemas.common import StandardResponse
from app.schemas.auth import (
    RegisterRequest,
    LoginRequest,
    OTPRequestSchema,
    OTPVerifySchema,
    TokenResponse,
    UserOut,
)
from app.services.auth_service import AuthService

router = APIRouter(prefix="/auth", tags=["Authentication"])


@router.post("/register", response_model=StandardResponse[TokenResponse])
async def register(req: RegisterRequest, db: AsyncSession = Depends(get_db)):
    service = AuthService(db)
    user = await service.register(phone=req.phone, full_name=req.full_name, email=req.email, password=req.password)
    access_token, refresh_token, expires_in = service.generate_token_pair(user)
    data = TokenResponse(
        access_token=access_token,
        refresh_token=refresh_token,
        expires_in=expires_in,
        user=UserOut.model_validate(user),
    )
    return StandardResponse.ok(data)


@router.post("/otp/request", response_model=StandardResponse[dict])
async def request_otp(req: OTPRequestSchema, db: AsyncSession = Depends(get_db)):
    service = AuthService(db)
    otp = await service.request_otp(phone=req.phone)
    return StandardResponse.ok({"message": "OTP sent successfully", "dev_otp_preview": otp})


@router.post("/otp/verify", response_model=StandardResponse[TokenResponse])
async def verify_otp(req: OTPVerifySchema, db: AsyncSession = Depends(get_db)):
    service = AuthService(db)
    user = await service.verify_otp(phone=req.phone, otp=req.otp)
    access_token, refresh_token, expires_in = service.generate_token_pair(user)
    data = TokenResponse(
        access_token=access_token,
        refresh_token=refresh_token,
        expires_in=expires_in,
        user=UserOut.model_validate(user),
    )
    return StandardResponse.ok(data)


@router.post("/login", response_model=StandardResponse[TokenResponse])
async def login(req: LoginRequest, db: AsyncSession = Depends(get_db)):
    service = AuthService(db)
    user = await service.login_with_password(phone=req.phone, password=req.password or "")
    access_token, refresh_token, expires_in = service.generate_token_pair(user)
    data = TokenResponse(
        access_token=access_token,
        refresh_token=refresh_token,
        expires_in=expires_in,
        user=UserOut.model_validate(user),
    )
    return StandardResponse.ok(data)
