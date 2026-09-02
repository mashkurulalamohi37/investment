from datetime import datetime, timezone
from typing import Optional, Dict, Any
from sqlalchemy import String, Text, JSON, DateTime, Index
from sqlalchemy.orm import Mapped, mapped_column
from app.models.base import Base, UUIDPrimaryKeyMixin, TimestampMixin


class AuditLog(Base, UUIDPrimaryKeyMixin, TimestampMixin):
    __tablename__ = "audit_logs"

    actor_id: Mapped[Optional[str]] = mapped_column(String(36), index=True, nullable=True)
    actor_name: Mapped[str] = mapped_column(String(128), nullable=False)
    actor_role: Mapped[str] = mapped_column(String(50), nullable=False)  # "Investor", "Super Admin", "Finance Manager"

    action: Mapped[str] = mapped_column(String(100), index=True, nullable=False)  # e.g. "ALLOCATE_SHARES", "EPS_GATEWAY_PAYMENT"
    action_bn: Mapped[str] = mapped_column(String(100), nullable=False)
    entity_type: Mapped[str] = mapped_column(String(50), index=True, nullable=False)  # "Investment", "Payment", "KYC"
    entity_id: Mapped[str] = mapped_column(String(64), index=True, nullable=False)

    details: Mapped[str] = mapped_column(Text, nullable=False)
    details_bn: Mapped[Optional[str]] = mapped_column(Text, nullable=True)
    before_state: Mapped[Optional[Dict[str, Any]]] = mapped_column(JSON, nullable=True)
    after_state: Mapped[Optional[Dict[str, Any]]] = mapped_column(JSON, nullable=True)

    ip_address: Mapped[Optional[str]] = mapped_column(String(45), nullable=True)
    user_agent: Mapped[Optional[str]] = mapped_column(String(255), nullable=True)
    request_id: Mapped[Optional[str]] = mapped_column(String(64), nullable=True)

    __table_args__ = (
        Index("idx_audit_logs_actor_action", "actor_id", "action"),
        Index("idx_audit_logs_entity", "entity_type", "entity_id"),
    )


class OutboxEvent(Base, UUIDPrimaryKeyMixin, TimestampMixin):
    __tablename__ = "outbox_events"

    event_type: Mapped[str] = mapped_column(String(100), index=True, nullable=False)  # e.g. "INVESTMENT_ALLOCATED", "PAYMENT_VERIFIED"
    payload: Mapped[Dict[str, Any]] = mapped_column(JSON, nullable=False)
    status: Mapped[str] = mapped_column(String(30), default="PENDING", index=True, nullable=False)  # PENDING, PROCESSED, FAILED
    retry_count: Mapped[int] = mapped_column(default=0, nullable=False)
    processed_at: Mapped[Optional[datetime]] = mapped_column(DateTime(timezone=True), nullable=True)
    error_message: Mapped[Optional[str]] = mapped_column(Text, nullable=True)


class IdempotencyKeyRecord(Base, UUIDPrimaryKeyMixin, TimestampMixin):
    __tablename__ = "idempotency_keys"

    idempotency_key: Mapped[str] = mapped_column(String(128), unique=True, index=True, nullable=False)
    user_id: Mapped[str] = mapped_column(String(36), index=True, nullable=False)
    endpoint: Mapped[str] = mapped_column(String(255), nullable=False)
    request_hash: Mapped[str] = mapped_column(String(64), nullable=False)
    response_status: Mapped[int] = mapped_column(nullable=False)
    response_body: Mapped[Dict[str, Any]] = mapped_column(JSON, nullable=False)
    expires_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), nullable=False)
