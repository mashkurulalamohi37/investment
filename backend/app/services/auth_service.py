from datetime import datetime, timezone, timedelta
from typing import Optional, Tuple
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, update
from app.models.user import User, OTPRequest, UserSession
from app.core.permissions import UserRole
from app.core.security import (
    verify_password,
    get_password_hash,
    create_access_token,
    create_refresh_token,
    generate_numeric_otp,
    hash_otp,
)
from app.core.exceptions import AuthenticationException, ConflictException, NotFoundException
from app.utils.id_generator import generate_public_id


class AuthService:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def register(self, phone: str, full_name: str, email: Optional[str] = None, password: Optional[str] = None) -> User:
        stmt = select(User).where((User.phone == phone) | (User.email == email if email else False))
        result = await self.db.execute(stmt)
        if result.scalar_one_or_none():
            raise ConflictException("A user with this phone or email already exists", code="USER_ALREADY_EXISTS")

        pwd_hash = get_password_hash(password) if password else None
        public_id = generate_public_id("usr")

        user = User(
            public_id=public_id,
            full_name=full_name,
            phone=phone,
            email=email,
            password_hash=pwd_hash,
            role=UserRole.INVESTOR,
            is_active=True,
            is_kyc_verified=False,
            is_phone_verified=True,  # Verified via OTP in registration flow
        )
        self.db.add(user)
        await self.db.commit()
        await self.db.refresh(user)
        return user

    async def request_otp(self, phone: str) -> str:
        """Generate and save hashed OTP. Returns plain OTP for development/SMS dispatch."""
        plain_otp = generate_numeric_otp(6)
        hashed = hash_otp(plain_otp, phone)
        expires = datetime.now(timezone.utc) + timedelta(minutes=5)

        otp_record = OTPRequest(
            phone=phone,
            otp_hash=hashed,
            expires_at=expires,
            is_used=False,
        )
        self.db.add(otp_record)
        await self.db.commit()
        return plain_otp

    async def verify_otp(self, phone: str, otp: str) -> User:
        hashed = hash_otp(otp, phone)
        stmt = (
            select(OTPRequest)
            .where(
                OTPRequest.phone == phone,
                OTPRequest.otp_hash == hashed,
                OTPRequest.is_used == False,
                OTPRequest.expires_at > datetime.now(timezone.utc),
            )
            .order_by(OTPRequest.created_at.desc())
        )
        result = await self.db.execute(stmt)
        otp_entry = result.scalar_one_or_none()

        if not otp_entry:
            raise AuthenticationException("Invalid or expired OTP", code="AUTH_INVALID_OTP")

        otp_entry.is_used = True

        # Check if user exists or create guest investor
        user_stmt = select(User).where(User.phone == phone)
        user_res = await self.db.execute(user_stmt)
        user = user_res.scalar_one_or_none()

        if not user:
            user = User(
                public_id=generate_public_id("usr"),
                full_name="Swapnojatri Investor",
                phone=phone,
                role=UserRole.INVESTOR,
                is_active=True,
                is_phone_verified=True,
            )
            self.db.add(user)

        user.last_login_at = datetime.now(timezone.utc)
        await self.db.commit()
        await self.db.refresh(user)
        return user

    async def login_with_password(self, phone: str, password: str) -> User:
        stmt = select(User).where(User.phone == phone)
        result = await self.db.execute(stmt)
        user = result.scalar_one_or_none()

        if not user or not user.password_hash or not verify_password(password, user.password_hash):
            raise AuthenticationException("Invalid phone number or password", code="AUTH_INVALID_CREDENTIALS")

        if not user.is_active:
            raise AuthenticationException("Account is disabled. Please contact support.", code="AUTH_ACCOUNT_DISABLED")

        user.last_login_at = datetime.now(timezone.utc)
        await self.db.commit()
        await self.db.refresh(user)
        return user

    def generate_token_pair(self, user: User) -> Tuple[str, str, int]:
        access_token = create_access_token(subject=user.id, role=user.role.value)
        refresh_token = create_refresh_token(subject=user.id, role=user.role.value)
        return access_token, refresh_token, 3600
