from datetime import datetime
from decimal import Decimal
from typing import Optional, Dict, Any
from pydantic import BaseModel, Field


class EpsSessionInitiateRequest(BaseModel):
    investment_id: str
    channel: str = Field(default="bKash", description="MFS channel or Card")
    customer_phone: Optional[str] = None


class EpsSessionResponse(BaseModel):
    is_success: bool
    eps_transaction_id: str
    merchant_transaction_id: str
    amount: Decimal
    redirect_url: Optional[str] = None
    message: str


class BankTransferSubmitRequest(BaseModel):
    investment_id: str
    deposit_bank_name: str
    depositor_name: str
    slip_reference: str
    receipt_image_url: Optional[str] = None


class PaymentVerifyRequest(BaseModel):
    rejection_reason: Optional[str] = None


class PaymentOut(BaseModel):
    id: str
    investment_id: str
    user_id: str
    amount: Decimal
    currency: str
    payment_gateway: str
    payment_method: str
    reference: str
    status: str
    receipt_image_url: Optional[str] = None
    gateway_txn_id: Optional[str] = None
    created_at: datetime
    verified_at: Optional[datetime] = None
    rejection_reason: Optional[str] = None

    class Config:
        from_attributes = True
