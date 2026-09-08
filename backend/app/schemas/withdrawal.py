from datetime import datetime
from decimal import Decimal
from typing import Optional
from pydantic import BaseModel, Field
from app.models.withdrawal import WithdrawalType, WithdrawalStatus, PayoutChannel


class WithdrawalCreateRequest(BaseModel):
    project_id: Optional[str] = None
    investment_id: Optional[str] = None
    type: WithdrawalType = Field(default=WithdrawalType.DIVIDEND)
    amount: Decimal = Field(..., gt=0, description="Amount in BDT")
    payout_channel: PayoutChannel = Field(default=PayoutChannel.BANK_TRANSFER)
    bank_name: Optional[str] = None
    account_holder_name: Optional[str] = None
    account_number: Optional[str] = None
    branch_name: Optional[str] = None
    routing_number: Optional[str] = None
    mfs_number: Optional[str] = None
    user_note: Optional[str] = None


class WithdrawalActionRequest(BaseModel):
    action: str = Field(..., description="'APPROVE' or 'REJECT'")
    transaction_ref: Optional[str] = None
    admin_feedback: Optional[str] = None


class WithdrawalOut(BaseModel):
    id: str
    user_id: str
    project_id: Optional[str] = None
    investment_id: Optional[str] = None
    type: WithdrawalType
    status: WithdrawalStatus
    payout_channel: PayoutChannel
    amount: Decimal
    fee: Decimal
    net_amount: Decimal
    bank_name: Optional[str] = None
    account_holder_name: Optional[str] = None
    account_number: Optional[str] = None
    branch_name: Optional[str] = None
    routing_number: Optional[str] = None
    mfs_number: Optional[str] = None
    user_note: Optional[str] = None
    admin_feedback: Optional[str] = None
    transaction_ref: Optional[str] = None
    created_at: datetime
    processed_at: Optional[datetime] = None

    class Config:
        from_attributes = True
