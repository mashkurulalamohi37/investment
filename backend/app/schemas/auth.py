from typing import Optional
from pydantic import BaseModel, EmailStr, Field


class RegisterRequest(BaseModel):
    phone: str = Field(..., description="Bangladesh mobile number, e.g. +8801712345678 or 01712345678")
    full_name: str = Field(..., min_length=2, max_length=128)
    email: Optional[EmailStr] = None
    password: Optional[str] = Field(None, min_length=6)


class LoginRequest(BaseModel):
    phone: str
    password: Optional[str] = None
    otp: Optional[str] = None


class OTPRequestSchema(BaseModel):
    phone: str = Field(..., description="Mobile number to receive 6-digit OTP")


class OTPVerifySchema(BaseModel):
    phone: str
    otp: str = Field(..., min_length=6, max_length=6)


class RefreshTokenRequest(BaseModel):
    refresh_token: str


class TokenResponse(BaseModel):
    access_token: str
    refresh_token: str
    token_type: str = "bearer"
    expires_in: int
    user: "UserOut"


# User Schemas
class UserOut(BaseModel):
    id: str
    public_id: str
    full_name: str
    phone: str
    email: Optional[str] = None
    role: str
    is_active: bool
    is_kyc_verified: bool
    avatar_url: Optional[str] = None
    preferred_language: str

    class Config:
        from_attributes = True


TokenResponse.model_rebuild()
