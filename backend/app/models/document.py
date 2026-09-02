from datetime import datetime, timezone
from enum import Enum
from typing import Optional
from sqlalchemy import String, DateTime, Enum as SQLEnum, ForeignKey
from sqlalchemy.orm import Mapped, mapped_column
from app.models.base import Base, UUIDPrimaryKeyMixin, TimestampMixin


class DocumentCategory(str, Enum):
    LEGAL = "LEGAL"
    DEED = "DEED"
    MUTATION = "MUTATION"
    FINANCIAL = "FINANCIAL"
    REPORT = "REPORT"
    RECEIPT = "RECEIPT"
    CERTIFICATE = "CERTIFICATE"


class DocumentVisibility(str, Enum):
    PUBLIC = "PUBLIC"
    INVESTOR_ONLY = "INVESTOR_ONLY"
    ADMIN_ONLY = "ADMIN_ONLY"


class Document(Base, UUIDPrimaryKeyMixin, TimestampMixin):
    __tablename__ = "documents"

    project_id: Mapped[Optional[str]] = mapped_column(String(36), ForeignKey("projects.id", ondelete="SET NULL"), index=True, nullable=True)
    user_id: Mapped[Optional[str]] = mapped_column(String(36), ForeignKey("users.id", ondelete="SET NULL"), index=True, nullable=True)
    investment_id: Mapped[Optional[str]] = mapped_column(String(36), ForeignKey("investments.id", ondelete="SET NULL"), index=True, nullable=True)

    title: Mapped[str] = mapped_column(String(255), nullable=False)
    title_bn: Mapped[str] = mapped_column(String(255), nullable=False)
    category: Mapped[DocumentCategory] = mapped_column(
        SQLEnum(DocumentCategory, native_enum=False),
        default=DocumentCategory.LEGAL,
        nullable=False,
    )
    visibility: Mapped[DocumentVisibility] = mapped_column(
        SQLEnum(DocumentVisibility, native_enum=False),
        default=DocumentVisibility.PUBLIC,
        nullable=False,
    )

    file_name: Mapped[str] = mapped_column(String(255), nullable=False)
    file_size_human: Mapped[str] = mapped_column(String(50), nullable=False)  # e.g. "1.2 MB"
    s3_key: Mapped[str] = mapped_column(String(500), nullable=False)
    mime_type: Mapped[str] = mapped_column(String(100), default="application/pdf", nullable=False)
    checksum_sha256: Mapped[str] = mapped_column(String(64), nullable=False)  # Cryptographic verification
    version: Mapped[str] = mapped_column(String(50), default="v1.0", nullable=False)
    uploaded_by: Mapped[str] = mapped_column(String(128), default="Legal Registry Service", nullable=False)
