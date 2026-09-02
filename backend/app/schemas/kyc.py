from datetime import datetime
from typing import Optional
from pydantic import BaseModel, Field


class NomineeSubmitRequest(BaseModel):
    name: str = Field(..., min_length=2, max_length=128)
    relationship_to_investor: str
    nid_number: Optional[str] = None
    phone: Optional[str] = None
    share_percentage: int = Field(default=100, ge=1, le=100)


class NomineeOut(BaseModel):
    id: str
    name: str
    relationship_to_investor: str
    nid_number: Optional[str] = None
    phone: Optional[str] = None
    share_percentage: int

    class Config:
        from_attributes = True


class KycSubmitRequest(BaseModel):
    full_name: str
    nid_number: str
    father_name: str
    mother_name: str
    present_address: str
    permanent_address: Optional[str] = None
    bank_name: str
    bank_account_number: str
    routing_number: str
    branch_name: str
    nid_front_url: Optional[str] = None
    nid_back_url: Optional[str] = None
    nominee: Optional[NomineeSubmitRequest] = None


class KycProfileOut(BaseModel):
    id: str
    user_id: str
    full_name: str
    nid_number: str
    father_name: str
    mother_name: str
    present_address: str
    bank_name: str
    bank_account_number: str
    routing_number: str
    branch_name: str
    status: str
    face_liveness_score: Optional[float] = None
    verified_at: Optional[datetime] = None
    nominee: Optional[NomineeOut] = None

    class Config:
        from_attributes = True


class NotificationOut(BaseModel):
    id: str
    title: str
    title_bn: str
    body: str
    body_bn: str
    category: str
    is_read: bool
    created_at: datetime

    class Config:
        from_attributes = True


class PortfolioSummaryOut(BaseModel):
    total_invested: str
    active_shares: int
    total_profit_received: str
    active_projects_count: int
    kyc_verified: bool
