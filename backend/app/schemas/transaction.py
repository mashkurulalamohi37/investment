from datetime import datetime
from decimal import Decimal
from typing import Optional, List
from pydantic import BaseModel


class LedgerEntryOut(BaseModel):
    id: str
    account_code: str
    account_name: str
    debit: Decimal
    credit: Decimal
    currency: str
    narration: str

    class Config:
        from_attributes = True


class TransactionOut(BaseModel):
    id: str
    reference: str
    user_id: str
    project_id: Optional[str] = None
    investment_id: Optional[str] = None
    type: str
    direction: str
    amount: Decimal
    balance_after: Decimal
    currency: str
    payment_method: Optional[str] = None
    status: str
    description: str
    description_bn: Optional[str] = None
    created_at: datetime
    ledger_entries: List[LedgerEntryOut] = []

    class Config:
        from_attributes = True
