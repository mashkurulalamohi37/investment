from datetime import datetime, timezone
from decimal import Decimal
from enum import Enum
from typing import Optional
from sqlalchemy import String, Numeric, DateTime, Text, Enum as SQLEnum, ForeignKey, CheckConstraint
from sqlalchemy.orm import Mapped, mapped_column, relationship
from app.models.base import Base, UUIDPrimaryKeyMixin, TimestampMixin


class ExpenseCategory(str, Enum):
    LAND_PURCHASE = "LAND_PURCHASE"
    LEGAL_REGISTRATION = "LEGAL_REGISTRATION"
    DEVELOPMENT_FENCING = "DEVELOPMENT_FENCING"
    MANAGEMENT_FEES = "MANAGEMENT_FEES"
    TAX_GOVT_DUTY = "TAX_GOVT_DUTY"
    SURVEY_DEMARCATION = "SURVEY_DEMARCATION"
    OPERATIONAL = "OPERATIONAL"


class ExpenseStatus(str, Enum):
    DRAFT = "DRAFT"
    SUBMITTED = "SUBMITTED"
    UNDER_REVIEW = "UNDER_REVIEW"
    APPROVED = "APPROVED"
    PAID = "PAID"
    REJECTED = "REJECTED"
    REVERSED = "REVERSED"


class Expense(Base, UUIDPrimaryKeyMixin, TimestampMixin):
    __tablename__ = "expenses"

    voucher_no: Mapped[str] = mapped_column(String(64), unique=True, index=True, nullable=False)  # e.g. VCH-LV100-001
    project_id: Mapped[str] = mapped_column(String(36), ForeignKey("projects.id", ondelete="RESTRICT"), index=True, nullable=False)

    category: Mapped[ExpenseCategory] = mapped_column(
        SQLEnum(ExpenseCategory, native_enum=False),
        nullable=False,
    )
    title: Mapped[str] = mapped_column(String(255), nullable=False)
    description: Mapped[str] = mapped_column(Text, nullable=False)
    payee_name: Mapped[str] = mapped_column(String(128), nullable=False)
    amount: Mapped[Decimal] = mapped_column(Numeric(18, 2), nullable=False)

    status: Mapped[ExpenseStatus] = mapped_column(
        SQLEnum(ExpenseStatus, native_enum=False),
        default=ExpenseStatus.APPROVED,
        index=True,
        nullable=False,
    )

    receipt_url: Mapped[Optional[str]] = mapped_column(String(500), nullable=True)
    expense_date: Mapped[datetime] = mapped_column(DateTime(timezone=True), nullable=False)
    audited_by: Mapped[Optional[str]] = mapped_column(String(128), nullable=True)
    approved_by: Mapped[Optional[str]] = mapped_column(String(36), nullable=True)
    approved_at: Mapped[Optional[datetime]] = mapped_column(DateTime(timezone=True), nullable=True)

    __table_args__ = (
        CheckConstraint("amount > 0", name="check_expense_amount_positive"),
    )

    project: Mapped["Project"] = relationship("Project", back_populates="expenses")


class Asset(Base, UUIDPrimaryKeyMixin, TimestampMixin):
    __tablename__ = "assets"

    project_id: Mapped[str] = mapped_column(String(36), ForeignKey("projects.id", ondelete="RESTRICT"), index=True, nullable=False)
    asset_type: Mapped[str] = mapped_column(String(100), nullable=False)  # e.g. "Freehold Land", "Agricultural Plot"
    title: Mapped[str] = mapped_column(String(255), nullable=False)
    title_bn: Mapped[str] = mapped_column(String(255), nullable=False)
    mouza: Mapped[str] = mapped_column(String(100), nullable=False)
    khatian_no: Mapped[str] = mapped_column(String(50), nullable=False)
    dag_no: Mapped[str] = mapped_column(String(50), nullable=False)
    area_decimals: Mapped[Decimal] = mapped_column(Numeric(10, 2), nullable=False)  # e.g. 22.50 decimals

    purchase_value: Mapped[Decimal] = mapped_column(Numeric(18, 2), nullable=False)
    current_valuation: Mapped[Decimal] = mapped_column(Numeric(18, 2), nullable=False)
    valuation_date: Mapped[datetime] = mapped_column(DateTime(timezone=True), nullable=False)

    deed_number: Mapped[str] = mapped_column(String(100), nullable=False)
    sub_registry_office: Mapped[str] = mapped_column(String(150), nullable=False)
    gps_coordinates: Mapped[Optional[str]] = mapped_column(String(100), nullable=True)  # e.g. "23.7745° N, 90.3128° E"

    project: Mapped["Project"] = relationship("Project", back_populates="assets")
