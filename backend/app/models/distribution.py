from datetime import datetime, timezone
from decimal import Decimal
from enum import Enum
from typing import Optional, List
from sqlalchemy import String, Integer, Numeric, DateTime, Enum as SQLEnum, ForeignKey, CheckConstraint
from sqlalchemy.orm import Mapped, mapped_column, relationship
from app.models.base import Base, UUIDPrimaryKeyMixin, TimestampMixin


class ProfitPeriodStatus(str, Enum):
    DRAFT = "DRAFT"
    CALCULATED = "CALCULATED"
    APPROVED = "APPROVED"
    PAID = "PAID"
    CLOSED = "CLOSED"


class DistributionStatus(str, Enum):
    PENDING = "PENDING"
    PROCESSING = "PROCESSING"
    PAID = "PAID"
    FAILED = "FAILED"


class ProfitPeriod(Base, UUIDPrimaryKeyMixin, TimestampMixin):
    __tablename__ = "profit_periods"

    project_id: Mapped[str] = mapped_column(String(36), ForeignKey("projects.id", ondelete="RESTRICT"), index=True, nullable=False)
    period_title: Mapped[str] = mapped_column(String(100), nullable=False)  # e.g. "H1 2026 Distribution"
    period_title_bn: Mapped[str] = mapped_column(String(100), nullable=False)
    period_start: Mapped[datetime] = mapped_column(DateTime(timezone=True), nullable=False)
    period_end: Mapped[datetime] = mapped_column(DateTime(timezone=True), nullable=False)

    realized_revenue: Mapped[Decimal] = mapped_column(Numeric(18, 2), nullable=False)
    realized_expenses: Mapped[Decimal] = mapped_column(Numeric(18, 2), nullable=False)
    net_profit: Mapped[Decimal] = mapped_column(Numeric(18, 2), nullable=False)
    distributable_pool: Mapped[Decimal] = mapped_column(Numeric(18, 2), nullable=False)
    amount_per_share: Mapped[Decimal] = mapped_column(Numeric(18, 2), nullable=False)

    status: Mapped[ProfitPeriodStatus] = mapped_column(
        SQLEnum(ProfitPeriodStatus, native_enum=False),
        default=ProfitPeriodStatus.CALCULATED,
        index=True,
        nullable=False,
    )

    distributions: Mapped[List["Distribution"]] = relationship("Distribution", back_populates="profit_period", cascade="all, delete-orphan")


class Distribution(Base, UUIDPrimaryKeyMixin, TimestampMixin):
    __tablename__ = "distributions"

    profit_period_id: Mapped[str] = mapped_column(String(36), ForeignKey("profit_periods.id", ondelete="CASCADE"), index=True, nullable=False)
    user_id: Mapped[str] = mapped_column(String(36), ForeignKey("users.id", ondelete="RESTRICT"), index=True, nullable=False)
    investment_id: Mapped[str] = mapped_column(String(36), ForeignKey("investments.id", ondelete="RESTRICT"), index=True, nullable=False)

    eligible_shares: Mapped[int] = mapped_column(Integer, nullable=False)
    gross_payout: Mapped[Decimal] = mapped_column(Numeric(18, 2), nullable=False)
    tax_deduction: Mapped[Decimal] = mapped_column(Numeric(18, 2), default=Decimal("0.00"), nullable=False)
    net_payout: Mapped[Decimal] = mapped_column(Numeric(18, 2), nullable=False)

    status: Mapped[DistributionStatus] = mapped_column(
        SQLEnum(DistributionStatus, native_enum=False),
        default=DistributionStatus.PAID,
        index=True,
        nullable=False,
    )

    payment_method: Mapped[str] = mapped_column(String(100), default="bKash / Bank Payout", nullable=False)
    payment_reference: Mapped[Optional[str]] = mapped_column(String(100), nullable=True)
    paid_at: Mapped[Optional[datetime]] = mapped_column(DateTime(timezone=True), nullable=True)

    profit_period: Mapped["ProfitPeriod"] = relationship("ProfitPeriod", back_populates="distributions")
