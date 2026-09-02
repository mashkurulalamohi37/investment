from datetime import datetime, timezone
from decimal import Decimal
from enum import Enum
from typing import Optional, List
from sqlalchemy import String, Numeric, DateTime, Text, Enum as SQLEnum, ForeignKey, CheckConstraint, Index
from sqlalchemy.orm import Mapped, mapped_column, relationship
from app.models.base import Base, UUIDPrimaryKeyMixin, TimestampMixin


class TransactionType(str, Enum):
    INVESTMENT = "INVESTMENT"
    SHARE_PURCHASE = "SHARE_PURCHASE"
    PROFIT_DISTRIBUTION = "PROFIT_DISTRIBUTION"
    EXPENSE = "EXPENSE"
    REFUND = "REFUND"
    FEE = "FEE"
    WITHDRAWAL = "WITHDRAWAL"
    ADJUSTMENT = "ADJUSTMENT"


class TransactionDirection(str, Enum):
    DEBIT = "DEBIT"
    CREDIT = "CREDIT"


class TransactionStatus(str, Enum):
    PENDING = "PENDING"
    COMPLETED = "COMPLETED"
    FAILED = "FAILED"
    REVERSED = "REVERSED"
    REFUNDED = "REFUNDED"


class Transaction(Base, UUIDPrimaryKeyMixin, TimestampMixin):
    __tablename__ = "transactions"

    reference: Mapped[str] = mapped_column(String(64), unique=True, index=True, nullable=False)
    user_id: Mapped[str] = mapped_column(String(36), ForeignKey("users.id", ondelete="RESTRICT"), index=True, nullable=False)
    project_id: Mapped[Optional[str]] = mapped_column(String(36), ForeignKey("projects.id", ondelete="SET NULL"), index=True, nullable=True)
    investment_id: Mapped[Optional[str]] = mapped_column(String(36), ForeignKey("investments.id", ondelete="SET NULL"), index=True, nullable=True)

    type: Mapped[TransactionType] = mapped_column(
        SQLEnum(TransactionType, native_enum=False),
        nullable=False,
    )
    direction: Mapped[TransactionDirection] = mapped_column(
        SQLEnum(TransactionDirection, native_enum=False),
        nullable=False,
    )
    amount: Mapped[Decimal] = mapped_column(Numeric(18, 2), nullable=False)
    balance_after: Mapped[Decimal] = mapped_column(Numeric(18, 2), default=Decimal("0.00"), nullable=False)
    currency: Mapped[str] = mapped_column(String(10), default="BDT", nullable=False)

    payment_method: Mapped[Optional[str]] = mapped_column(String(100), nullable=True)
    receipt_image_url: Mapped[Optional[str]] = mapped_column(String(500), nullable=True)
    deposit_bank_name: Mapped[Optional[str]] = mapped_column(String(100), nullable=True)
    depositor_name: Mapped[Optional[str]] = mapped_column(String(128), nullable=True)

    status: Mapped[TransactionStatus] = mapped_column(
        SQLEnum(TransactionStatus, native_enum=False),
        default=TransactionStatus.PENDING,
        index=True,
        nullable=False,
    )

    description: Mapped[str] = mapped_column(String(255), nullable=False)
    description_bn: Mapped[Optional[str]] = mapped_column(String(255), nullable=True)

    __table_args__ = (
        CheckConstraint("amount > 0", name="check_transaction_amount_positive"),
        Index("idx_transactions_user_created", "user_id", "created_at"),
    )

    user: Mapped["User"] = relationship("User", back_populates="transactions")
    ledger_entries: Mapped[List["LedgerEntry"]] = relationship("LedgerEntry", back_populates="transaction", cascade="all, delete-orphan")


class LedgerEntry(Base, UUIDPrimaryKeyMixin, TimestampMixin):
    __tablename__ = "ledger_entries"

    transaction_id: Mapped[str] = mapped_column(String(36), ForeignKey("transactions.id", ondelete="CASCADE"), index=True, nullable=False)
    account_code: Mapped[str] = mapped_column(String(64), index=True, nullable=False)  # e.g. "1010-CASH", "2010-INVESTOR-EQUITY"
    account_name: Mapped[str] = mapped_column(String(128), nullable=False)
    debit: Mapped[Decimal] = mapped_column(Numeric(18, 2), default=Decimal("0.00"), nullable=False)
    credit: Mapped[Decimal] = mapped_column(Numeric(18, 2), default=Decimal("0.00"), nullable=False)
    currency: Mapped[str] = mapped_column(String(10), default="BDT", nullable=False)
    narration: Mapped[str] = mapped_column(String(255), nullable=False)

    transaction: Mapped["Transaction"] = relationship("Transaction", back_populates="ledger_entries")
