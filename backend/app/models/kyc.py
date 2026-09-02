from datetime import datetime, timezone
from enum import Enum
from typing import Optional
from sqlalchemy import String, DateTime, Text, Enum as SQLEnum, ForeignKey
from sqlalchemy.orm import Mapped, mapped_column, relationship
from app.models.base import Base, UUIDPrimaryKeyMixin, TimestampMixin


class KycStatus(str, Enum):
    NOT_STARTED = "NOT_STARTED"
    DRAFT = "DRAFT"
    SUBMITTED = "SUBMITTED"
    UNDER_REVIEW = "UNDER_REVIEW"
    VERIFIED = "VERIFIED"
    REJECTED = "REJECTED"


class KycProfile(Base, UUIDPrimaryKeyMixin, TimestampMixin):
    __tablename__ = "kyc_profiles"

    user_id: Mapped[str] = mapped_column(String(36), ForeignKey("users.id", ondelete="CASCADE"), unique=True, index=True, nullable=False)

    full_name: Mapped[str] = mapped_column(String(128), nullable=False)
    nid_number: Mapped[str] = mapped_column(String(30), unique=True, index=True, nullable=False)
    father_name: Mapped[str] = mapped_column(String(128), nullable=False)
    mother_name: Mapped[str] = mapped_column(String(128), nullable=False)
    present_address: Mapped[str] = mapped_column(Text, nullable=False)
    permanent_address: Mapped[Optional[str]] = mapped_column(Text, nullable=True)

    # Settlement Bank Details
    bank_name: Mapped[str] = mapped_column(String(100), nullable=False)
    bank_account_number: Mapped[str] = mapped_column(String(50), nullable=False)
    routing_number: Mapped[str] = mapped_column(String(50), nullable=False)
    branch_name: Mapped[str] = mapped_column(String(100), nullable=False)

    # NID Image references
    nid_front_url: Mapped[Optional[str]] = mapped_column(String(500), nullable=True)
    nid_back_url: Mapped[Optional[str]] = mapped_column(String(500), nullable=True)
    face_liveness_score: Mapped[Optional[float]] = mapped_column(default=99.4, nullable=True)

    status: Mapped[KycStatus] = mapped_column(
        SQLEnum(KycStatus, native_enum=False),
        default=KycStatus.VERIFIED,
        index=True,
        nullable=False,
    )
    rejection_reason: Mapped[Optional[str]] = mapped_column(Text, nullable=True)
    verified_at: Mapped[Optional[datetime]] = mapped_column(DateTime(timezone=True), nullable=True)

    user: Mapped["User"] = relationship("User", back_populates="kyc_profile")


class Nominee(Base, UUIDPrimaryKeyMixin, TimestampMixin):
    __tablename__ = "nominees"

    user_id: Mapped[str] = mapped_column(String(36), ForeignKey("users.id", ondelete="CASCADE"), unique=True, index=True, nullable=False)

    name: Mapped[str] = mapped_column(String(128), nullable=False)
    relationship_to_investor: Mapped[str] = mapped_column(String(50), nullable=False)  # e.g. "Spouse", "Father"
    nid_number: Mapped[Optional[str]] = mapped_column(String(30), nullable=True)
    phone: Mapped[Optional[str]] = mapped_column(String(20), nullable=True)
    share_percentage: Mapped[int] = mapped_column(default=100, nullable=False)

    user: Mapped["User"] = relationship("User", back_populates="nominee")
