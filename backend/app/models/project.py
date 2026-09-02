from datetime import datetime
from decimal import Decimal
from enum import Enum
from typing import Optional, List
from sqlalchemy import String, Integer, Numeric, Text, DateTime, Boolean, Enum as SQLEnum, CheckConstraint, Index
from sqlalchemy.orm import Mapped, mapped_column, relationship
from app.models.base import Base, UUIDPrimaryKeyMixin, TimestampMixin


class ProjectStatus(str, Enum):
    DRAFT = "DRAFT"
    UPCOMING = "UPCOMING"
    OPEN = "OPEN"
    FUNDING = "FUNDING"
    FUNDED = "FUNDED"
    IN_PROGRESS = "IN_PROGRESS"
    COMPLETED = "COMPLETED"
    CLOSED = "CLOSED"
    CANCELLED = "CANCELLED"


class ProjectCategory(str, Enum):
    REAL_ESTATE = "REAL_ESTATE"
    AGRICULTURAL = "AGRICULTURAL"
    COMMERCIAL = "COMMERCIAL"


class Project(Base, UUIDPrimaryKeyMixin, TimestampMixin):
    __tablename__ = "projects"

    code: Mapped[str] = mapped_column(String(32), unique=True, index=True, nullable=False)  # e.g. LV100
    name: Mapped[str] = mapped_column(String(255), nullable=False)
    name_bn: Mapped[str] = mapped_column(String(255), nullable=False)
    category: Mapped[ProjectCategory] = mapped_column(
        SQLEnum(ProjectCategory, native_enum=False),
        default=ProjectCategory.REAL_ESTATE,
        nullable=False,
    )
    location: Mapped[str] = mapped_column(String(255), nullable=False)
    location_bn: Mapped[str] = mapped_column(String(255), nullable=False)
    description: Mapped[str] = mapped_column(Text, nullable=False)
    description_bn: Mapped[str] = mapped_column(Text, nullable=False)

    # Financial Configuration (Decimal strictly enforced)
    target_fund: Mapped[Decimal] = mapped_column(Numeric(18, 2), nullable=False)  # 25,50,000.00
    price_per_share: Mapped[Decimal] = mapped_column(Numeric(18, 2), nullable=False)  # 25,500.00
    total_shares: Mapped[int] = mapped_column(Integer, nullable=False)  # 100
    allocated_shares: Mapped[int] = mapped_column(Integer, default=0, nullable=False)
    reserved_shares: Mapped[int] = mapped_column(Integer, default=0, nullable=False)
    min_shares: Mapped[int] = mapped_column(Integer, default=1, nullable=False)
    max_shares: Mapped[int] = mapped_column(Integer, default=4, nullable=False)

    status: Mapped[ProjectStatus] = mapped_column(
        SQLEnum(ProjectStatus, native_enum=False),
        default=ProjectStatus.OPEN,
        index=True,
        nullable=False,
    )

    image_url: Mapped[Optional[str]] = mapped_column(String(500), nullable=True)
    projected_roi_min: Mapped[Decimal] = mapped_column(Numeric(5, 2), default=Decimal("18.50"), nullable=False)
    projected_roi_max: Mapped[Decimal] = mapped_column(Numeric(5, 2), default=Decimal("22.00"), nullable=False)
    start_date: Mapped[Optional[datetime]] = mapped_column(DateTime(timezone=True), nullable=True)
    target_end_date: Mapped[Optional[datetime]] = mapped_column(DateTime(timezone=True), nullable=True)

    __table_args__ = (
        CheckConstraint("allocated_shares <= total_shares", name="check_allocated_within_total"),
        CheckConstraint("target_fund >= 0", name="check_target_fund_positive"),
        CheckConstraint("price_per_share > 0", name="check_price_per_share_positive"),
        Index("idx_projects_status_category", "status", "category"),
    )

    # Relationships
    milestones: Mapped[List["ProjectMilestone"]] = relationship("ProjectMilestone", back_populates="project", cascade="all, delete-orphan")
    investments: Mapped[List["Investment"]] = relationship("Investment", back_populates="project")
    expenses: Mapped[List["Expense"]] = relationship("Expense", back_populates="project")
    assets: Mapped[List["Asset"]] = relationship("Asset", back_populates="project")

    @property
    def available_shares(self) -> int:
        return max(0, self.total_shares - self.allocated_shares - self.reserved_shares)

    @property
    def collected_fund(self) -> Decimal:
        return Decimal(self.allocated_shares) * self.price_per_share


class ProjectMilestone(Base, UUIDPrimaryKeyMixin, TimestampMixin):
    __tablename__ = "project_milestones"

    project_id: Mapped[str] = mapped_column(String(36), index=True, nullable=False)
    title: Mapped[str] = mapped_column(String(255), nullable=False)
    title_bn: Mapped[str] = mapped_column(String(255), nullable=False)
    description: Mapped[str] = mapped_column(Text, nullable=False)
    milestone_date: Mapped[datetime] = mapped_column(DateTime(timezone=True), nullable=False)
    is_completed: Mapped[bool] = mapped_column(Boolean, default=False, nullable=False)
    sequence: Mapped[int] = mapped_column(Integer, default=1, nullable=False)

    project: Mapped["Project"] = relationship("Project", back_populates="milestones")
