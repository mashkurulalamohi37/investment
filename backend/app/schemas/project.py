from datetime import datetime
from decimal import Decimal
from typing import Optional, List
from pydantic import BaseModel, Field


class MilestoneOut(BaseModel):
    id: str
    title: str
    title_bn: str
    description: str
    milestone_date: datetime
    is_completed: bool
    sequence: int

    class Config:
        from_attributes = True


class ProjectOut(BaseModel):
    id: str
    code: str
    name: str
    name_bn: str
    category: str
    location: str
    location_bn: str
    description: str
    description_bn: str
    target_fund: Decimal
    price_per_share: Decimal
    total_shares: int
    allocated_shares: int
    available_shares: int
    min_shares: int
    max_shares: int
    status: str
    image_url: Optional[str] = None
    projected_roi_min: Decimal
    projected_roi_max: Decimal
    milestones: List[MilestoneOut] = []

    class Config:
        from_attributes = True


class ProjectCreate(BaseModel):
    code: str = Field(..., max_length=32)
    name: str = Field(..., max_length=255)
    name_bn: str = Field(..., max_length=255)
    category: str = "REAL_ESTATE"
    location: str
    location_bn: str
    description: str
    description_bn: str
    target_fund: Decimal = Field(..., gt=0)
    price_per_share: Decimal = Field(..., gt=0)
    total_shares: int = Field(..., gt=0)
    min_shares: int = 1
    max_shares: int = 4
    image_url: Optional[str] = None
    projected_roi_min: Decimal = Decimal("18.50")
    projected_roi_max: Decimal = Decimal("22.00")
