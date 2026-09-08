from datetime import datetime, timezone
from decimal import Decimal
from enum import Enum
from typing import Optional
from sqlalchemy import String, Numeric, DateTime, Text, Enum as SQLEnum, ForeignKey, CheckConstraint, Index
from sqlalchemy.orm import Mapped, mapped_column, relationship
from app.models.base import Base, UUIDPrimaryKeyMixin, TimestampMixin


class WithdrawalType(str, Enum):
    DIVIDEND = "DIVIDEND"
    CAPITAL_EXIT = "CAPITAL_EXIT"


class WithdrawalStatus(str, Enum):
    PENDING = "PENDING"
    UNDER_REVIEW = "UNDER_REVIEW"
    PROCESSING = "PROCESSING"
    COMPLETED = "COMPLETED"
    REJECTED = "REJECTED"
    CANCELLED = "CANCELLED"


class PayoutChannel(str, Enum):
    BANK_TRANSFER = "BANK_TRANSFER"
    BKASH = "BKASH"
    NAGAD = "NAGAD"
    ROCKET = "ROCKET"


class WithdrawalRequest(Base, UUIDPrimaryKeyMixin, TimestampMixin):
    __tablename__ = "withdrawal_requests"

    user_id: Mapped[str] = mapped_column(String(36), ForeignKey("users.id", ondelete="RESTRICT"), index=True, nullable=False)
    project_id: Mapped[Optional[str]] = mapped_column(String(36), ForeignKey("projects.id", ondelete="SET NULL"), nullable=True)
    investment_id: Mapped[Optional[str]] = mapped_column(String(36), ForeignKey("investments.id", ondelete="SET NULL"), nullable=True)

    type: Mapped[WithdrawalType] = mapped_column(
        SQLEnum(WithdrawalType, native_enum=False),
        default=WithdrawalType.DIVIDEND,
        nullable=False,
    )
    status: Mapped[WithdrawalStatus] = mapped_column(
        SQLEnum(WithdrawalStatus, native_enum=False),
        default=WithdrawalStatus.PENDING,
        index=True,
        nullable=False,
    )
    payout_channel: Mapped[PayoutChannel] = mapped_column(
        SQLEnum(PayoutChannel, native_enum=False),
        default=PayoutChannel.BANK_TRANSFER,
        nullable=False,
    )

    amount: Mapped[Decimal] = mapped_column(Numeric(18, 2), nullable=False)
    fee: Mapped[Decimal] = mapped_column(Numeric(18, 2), default=Decimal("0.00"), nullable=False)
    net_amount: Mapped[Decimal] = mapped_column(Numeric(18, 2), nullable=False)

    bank_name: Mapped[Optional[str]] = mapped_column(String(100), nullable=True)
    account_holder_name: Mapped[Optional[str]] = mapped_column(String(128), nullable=True)
    account_number: Mapped[Optional[str]] = mapped_column(String(64), nullable=True)
    branch_name: Mapped[Optional[str]] = mapped_column(String(100), nullable=True)
    routing_number: Mapped[Optional[str]] = mapped_column(String(32), nullable=True)
    mfs_number: Mapped[Optional[str]] = mapped_column(String(32), nullable=True)

    user_note: Mapped[Optional[str]] = mapped_column(Text, nullable=True)
    admin_feedback: Mapped[Optional[str]] = mapped_column(Text, nullable=True)
    transaction_ref: Mapped[Optional[str]] = mapped_column(String(100), nullable=True)
    processed_at: Mapped[Optional[datetime]] = mapped_column(DateTime(timezone=True), nullable=True)
    processed_by: Mapped[Optional[str]] = mapped_column(String(36), nullable=True)

    __table_args__ = (
        CheckConstraint("amount > 0", name="check_withdrawal_amount_positive"),
        Index("idx_withdrawals_user_status", "user_id", "status"),
    )
