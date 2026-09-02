from datetime import datetime, timezone
from decimal import Decimal
from enum import Enum
from typing import Optional, List
from sqlalchemy import String, Integer, Numeric, Text, DateTime, Enum as SQLEnum, CheckConstraint, Index, ForeignKey
from sqlalchemy.orm import Mapped, mapped_column, relationship
from app.models.base import Base, UUIDPrimaryKeyMixin, TimestampMixin


class InvestmentStatus(str, Enum):
    DRAFT = "DRAFT"
    PENDING_PAYMENT = "PENDING_PAYMENT"
    PAYMENT_SUBMITTED = "PAYMENT_SUBMITTED"
    UNDER_VERIFICATION = "UNDER_VERIFICATION"
    APPROVED = "APPROVED"
    ALLOCATED = "ALLOCATED"
    CANCELLED = "CANCELLED"
    REJECTED = "REJECTED"
    REFUNDED = "REFUNDED"


class Investment(Base, UUIDPrimaryKeyMixin, TimestampMixin):
    __tablename__ = "investments"

    investment_no: Mapped[str] = mapped_column(String(64), unique=True, index=True, nullable=False)  # e.g. SJ-LV100-0042
    user_id: Mapped[str] = mapped_column(String(36), ForeignKey("users.id", ondelete="CASCADE"), index=True, nullable=False)
    project_id: Mapped[str] = mapped_column(String(36), ForeignKey("projects.id", ondelete="RESTRICT"), index=True, nullable=False)

    shares: Mapped[int] = mapped_column(Integer, nullable=False)
    unit_price: Mapped[Decimal] = mapped_column(Numeric(18, 2), nullable=False)
    gross_amount: Mapped[Decimal] = mapped_column(Numeric(18, 2), nullable=False)
    fees: Mapped[Decimal] = mapped_column(Numeric(18, 2), default=Decimal("0.00"), nullable=False)
    net_amount: Mapped[Decimal] = mapped_column(Numeric(18, 2), nullable=False)

    status: Mapped[InvestmentStatus] = mapped_column(
        SQLEnum(InvestmentStatus, native_enum=False),
        default=InvestmentStatus.PENDING_PAYMENT,
        index=True,
        nullable=False,
    )

    allocated_lot_numbers: Mapped[Optional[str]] = mapped_column(String(255), nullable=True)  # e.g. "LOT-041, LOT-042"
    payment_method: Mapped[Optional[str]] = mapped_column(String(100), nullable=True)
    payment_reference: Mapped[Optional[str]] = mapped_column(String(100), nullable=True)
    payment_gateway: Mapped[Optional[str]] = mapped_column(String(50), default="EPS", nullable=True)  # 'EPS', 'MANUAL_BANK'
    receipt_image_url: Mapped[Optional[str]] = mapped_column(String(500), nullable=True)
    deposit_bank_name: Mapped[Optional[str]] = mapped_column(String(100), nullable=True)
    depositor_name: Mapped[Optional[str]] = mapped_column(String(128), nullable=True)

    verified_at: Mapped[Optional[datetime]] = mapped_column(DateTime(timezone=True), nullable=True)
    verified_by: Mapped[Optional[str]] = mapped_column(String(36), nullable=True)

    __table_args__ = (
        CheckConstraint("shares > 0", name="check_shares_positive"),
        CheckConstraint("gross_amount > 0", name="check_gross_amount_positive"),
        Index("idx_investments_user_project", "user_id", "project_id"),
    )

    # Relationships
    user: Mapped["User"] = relationship("User", back_populates="investments")
    project: Mapped["Project"] = relationship("Project", back_populates="investments")
    payments: Mapped[List["Payment"]] = relationship("Payment", back_populates="investment", cascade="all, delete-orphan")
    status_history: Mapped[List["InvestmentStatusHistory"]] = relationship("InvestmentStatusHistory", back_populates="investment", cascade="all, delete-orphan")


class InvestmentStatusHistory(Base, UUIDPrimaryKeyMixin, TimestampMixin):
    __tablename__ = "investment_status_history"

    investment_id: Mapped[str] = mapped_column(String(36), ForeignKey("investments.id", ondelete="CASCADE"), index=True, nullable=False)
    from_status: Mapped[Optional[str]] = mapped_column(String(50), nullable=True)
    to_status: Mapped[str] = mapped_column(String(50), nullable=False)
    changed_by: Mapped[Optional[str]] = mapped_column(String(36), nullable=True)
    reason: Mapped[Optional[str]] = mapped_column(Text, nullable=True)

    investment: Mapped["Investment"] = relationship("Investment", back_populates="status_history")
