from datetime import datetime
from decimal import Decimal
from typing import Optional, List
from pydantic import BaseModel, Field


class DistributionOut(BaseModel):
    id: str
    user_id: str
    investment_id: str
    eligible_shares: int
    gross_payout: Decimal
    tax_deduction: Decimal
    net_payout: Decimal
    status: str
    payment_method: str
    payment_reference: Optional[str] = None
    paid_at: Optional[datetime] = None

    class Config:
        from_attributes = True


class ProfitPeriodOut(BaseModel):
    id: str
    project_id: str
    period_title: str
    period_title_bn: str
    period_start: datetime
    period_end: datetime
    realized_revenue: Decimal
    realized_expenses: Decimal
    net_profit: Decimal
    distributable_pool: Decimal
    amount_per_share: Decimal
    status: str
    distributions: List[DistributionOut] = []

    class Config:
        from_attributes = True


class CalculateProfitPeriodRequest(BaseModel):
    project_id: str
    period_title: str
    period_title_bn: str
    period_start: datetime
    period_end: datetime
    realized_revenue: Decimal = Field(..., ge=0)
    realized_expenses: Decimal = Field(..., ge=0)
