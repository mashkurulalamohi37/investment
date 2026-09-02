from datetime import datetime, timezone
from enum import Enum
from typing import Optional, List
from sqlalchemy import String, Boolean, Text, Enum as SQLEnum, ForeignKey
from sqlalchemy.orm import Mapped, mapped_column, relationship
from app.models.base import Base, UUIDPrimaryKeyMixin, TimestampMixin


class NotificationCategory(str, Enum):
    INVESTMENT = "INVESTMENT"
    PAYMENT = "PAYMENT"
    KYC = "KYC"
    DISTRIBUTION = "DISTRIBUTION"
    PROJECT = "PROJECT"
    SYSTEM = "SYSTEM"


class Notification(Base, UUIDPrimaryKeyMixin, TimestampMixin):
    __tablename__ = "notifications"

    user_id: Mapped[str] = mapped_column(String(36), ForeignKey("users.id", ondelete="CASCADE"), index=True, nullable=False)
    title: Mapped[str] = mapped_column(String(255), nullable=False)
    title_bn: Mapped[str] = mapped_column(String(255), nullable=False)
    body: Mapped[str] = mapped_column(Text, nullable=False)
    body_bn: Mapped[str] = mapped_column(Text, nullable=False)

    category: Mapped[NotificationCategory] = mapped_column(
        SQLEnum(NotificationCategory, native_enum=False),
        default=NotificationCategory.INVESTMENT,
        nullable=False,
    )
    is_read: Mapped[bool] = mapped_column(Boolean, default=False, nullable=False)
    action_url: Mapped[Optional[str]] = mapped_column(String(255), nullable=True)


class SupportTicket(Base, UUIDPrimaryKeyMixin, TimestampMixin):
    __tablename__ = "support_tickets"

    user_id: Mapped[str] = mapped_column(String(36), ForeignKey("users.id", ondelete="CASCADE"), index=True, nullable=False)
    subject: Mapped[str] = mapped_column(String(255), nullable=False)
    status: Mapped[str] = mapped_column(String(50), default="OPEN", index=True, nullable=False)  # OPEN, IN_PROGRESS, RESOLVED, CLOSED
    priority: Mapped[str] = mapped_column(String(20), default="MEDIUM", nullable=False)

    messages: Mapped[List["SupportMessage"]] = relationship("SupportMessage", back_populates="ticket", cascade="all, delete-orphan")


class SupportMessage(Base, UUIDPrimaryKeyMixin, TimestampMixin):
    __tablename__ = "support_messages"

    ticket_id: Mapped[str] = mapped_column(String(36), ForeignKey("support_tickets.id", ondelete="CASCADE"), index=True, nullable=False)
    sender_id: Mapped[str] = mapped_column(String(36), nullable=False)
    sender_name: Mapped[str] = mapped_column(String(128), nullable=False)
    sender_role: Mapped[str] = mapped_column(String(50), nullable=False)  # "Investor", "Admin"
    message: Mapped[str] = mapped_column(Text, nullable=False)

    ticket: Mapped["SupportTicket"] = relationship("SupportTicket", back_populates="messages")
