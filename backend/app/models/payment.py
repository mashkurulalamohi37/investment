from datetime import datetime, timezone
from decimal import Decimal
from enum import Enum
from typing import Optional, Dict, Any
from sqlalchemy import String, Numeric, DateTime, Text, Enum as SQLEnum, JSON, ForeignKey, CheckConstraint
from sqlalchemy.orm import Mapped, mapped_column, relationship
from app.models.base import Base, UUIDPrimaryKeyMixin, TimestampMixin


class PaymentStatus(str, Enum):
    PENDING = "PENDING"
    SUBMITTED = "SUBMITTED"
    UNDER_REVIEW = "UNDER_REVIEW"
    VERIFIED = "VERIFIED"
    REJECTED = "REJECTED"
    FAILED = "FAILED"
    REFUNDED = "REFUNDED"


class PaymentGatewayType(str, Enum):
    EPS = "EPS"
    MANUAL_BANK = "MANUAL_BANK"
    DIRECT = "DIRECT"


class Payment(Base, UUIDPrimaryKeyMixin, TimestampMixin):
    __tablename__ = "payments"

    investment_id: Mapped[str] = mapped_column(String(36), ForeignKey("investments.id", ondelete="CASCADE"), index=True, nullable=False)
    user_id: Mapped[str] = mapped_column(String(36), ForeignKey("users.id", ondelete="CASCADE"), index=True, nullable=False)

    amount: Mapped[Decimal] = mapped_column(Numeric(18, 2), nullable=False)
    currency: Mapped[str] = mapped_column(String(10), default="BDT", nullable=False)
    payment_gateway: Mapped[PaymentGatewayType] = mapped_column(
        SQLEnum(PaymentGatewayType, native_enum=False),
        default=PaymentGatewayType.EPS,
        nullable=False,
    )
    payment_method: Mapped[str] = mapped_column(String(100), nullable=False)  # e.g. bKash, Nagad, Visa, City Bank
    reference: Mapped[str] = mapped_column(String(100), unique=True, index=True, nullable=False)

    status: Mapped[PaymentStatus] = mapped_column(
        SQLEnum(PaymentStatus, native_enum=False),
        default=PaymentStatus.PENDING,
        index=True,
        nullable=False,
    )

    receipt_image_url: Mapped[Optional[str]] = mapped_column(String(500), nullable=True)
    gateway_txn_id: Mapped[Optional[str]] = mapped_column(String(100), nullable=True)
    gateway_response_raw: Mapped[Optional[Dict[str, Any]]] = mapped_column(JSON, nullable=True)

    verified_at: Mapped[Optional[datetime]] = mapped_column(DateTime(timezone=True), nullable=True)
    verified_by: Mapped[Optional[str]] = mapped_column(String(36), nullable=True)
    rejection_reason: Mapped[Optional[str]] = mapped_column(Text, nullable=True)

    __table_args__ = (
        CheckConstraint("amount > 0", name="check_payment_amount_positive"),
    )

    investment: Mapped["Investment"] = relationship("Investment", back_populates="payments")
