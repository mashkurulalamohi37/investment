from datetime import datetime
from decimal import Decimal
from typing import Optional
from pydantic import BaseModel, Field


class ExpenseCreate(BaseModel):
    project_id: str
    category: str
    title: str
    description: str
    payee_name: str
    amount: Decimal = Field(..., gt=0)
    receipt_url: Optional[str] = None
    expense_date: Optional[datetime] = None


class ExpenseOut(BaseModel):
    id: str
    voucher_no: str
    project_id: str
    category: str
    title: str
    description: str
    payee_name: str
    amount: Decimal
    status: str
    receipt_url: Optional[str] = None
    expense_date: datetime
    audited_by: Optional[str] = None

    class Config:
        from_attributes = True


class AssetOut(BaseModel):
    id: str
    project_id: str
    asset_type: str
    title: str
    title_bn: str
    mouza: str
    khatian_no: str
    dag_no: str
    area_decimals: Decimal
    purchase_value: Decimal
    current_valuation: Decimal
    deed_number: str
    sub_registry_office: str
    gps_coordinates: Optional[str] = None

    class Config:
        from_attributes = True
