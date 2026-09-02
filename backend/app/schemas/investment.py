from datetime import datetime
from decimal import Decimal
from typing import Optional, List
from pydantic import BaseModel, Field


class InvestmentCreateRequest(BaseModel):
    project_id: str
    shares: int = Field(..., ge=1, le=4, description="Number of shares (1 to 4 limit)")
    payment_method: str = Field(default="EPS (bKash)", description="Selected channel")
    payment_gateway: str = Field(default="EPS", description="'EPS' or 'MANUAL_BANK'")
    payment_reference: Optional[str] = None
    deposit_bank_name: Optional[str] = None
    depositor_name: Optional[str] = None
    receipt_image_url: Optional[str] = None


class InvestmentOut(BaseModel):
    id: str
    investment_no: str
    user_id: str
    project_id: str
    shares: int
    unit_price: Decimal
    gross_amount: Decimal
    fees: Decimal
    net_amount: Decimal
    status: str
    allocated_lot_numbers: Optional[str] = None
    payment_method: Optional[str] = None
    payment_reference: Optional[str] = None
    payment_gateway: Optional[str] = None
    receipt_image_url: Optional[str] = None
    deposit_bank_name: Optional[str] = None
    depositor_name: Optional[str] = None
    created_at: datetime
    verified_at: Optional[datetime] = None

    class Config:
        from_attributes = True
