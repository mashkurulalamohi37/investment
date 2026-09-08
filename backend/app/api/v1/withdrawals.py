from typing import List, Optional
from datetime import datetime, timezone
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from app.core.database import get_db
from app.core.permissions import require_authenticated, require_admin
from app.schemas.common import StandardResponse
from app.models.withdrawal import WithdrawalRequest, WithdrawalStatus
from app.schemas.withdrawal import WithdrawalCreateRequest, WithdrawalActionRequest, WithdrawalOut

router = APIRouter(prefix="/withdrawals", tags=["Withdrawals"])


@router.post("", response_model=StandardResponse[WithdrawalOut])
async def create_withdrawal(
    req: WithdrawalCreateRequest,
    auth_payload: dict = Depends(require_authenticated),
    db: AsyncSession = Depends(get_db),
):
    user_id = auth_payload["sub"]
    withdrawal = WithdrawalRequest(
        user_id=user_id,
        project_id=req.project_id,
        investment_id=req.investment_id,
        type=req.type,
        amount=req.amount,
        fee=0,
        net_amount=req.amount,
        payout_channel=req.payout_channel,
        bank_name=req.bank_name,
        account_holder_name=req.account_holder_name,
        account_number=req.account_number,
        branch_name=req.branch_name,
        routing_number=req.routing_number,
        mfs_number=req.mfs_number,
        status=WithdrawalStatus.PENDING,
        user_note=req.user_note,
    )
    db.add(withdrawal)
    await db.commit()
    await db.refresh(withdrawal)
    return StandardResponse.ok(WithdrawalOut.model_validate(withdrawal))


@router.get("/me", response_model=StandardResponse[List[WithdrawalOut]])
async def get_my_withdrawals(
    auth_payload: dict = Depends(require_authenticated),
    db: AsyncSession = Depends(get_db),
):
    user_id = auth_payload["sub"]
    stmt = select(WithdrawalRequest).where(WithdrawalRequest.user_id == user_id).order_by(WithdrawalRequest.created_at.desc())
    res = await db.execute(stmt)
    records = res.scalars().all()
    return StandardResponse.ok([WithdrawalOut.model_validate(w) for w in records])


@router.get("", response_model=StandardResponse[List[WithdrawalOut]])
async def list_all_withdrawals(
    status_filter: Optional[str] = None,
    auth_payload: dict = Depends(require_admin),
    db: AsyncSession = Depends(get_db),
):
    stmt = select(WithdrawalRequest).order_by(WithdrawalRequest.created_at.desc())
    if status_filter:
        stmt = stmt.where(WithdrawalRequest.status == status_filter)
    res = await db.execute(stmt)
    records = res.scalars().all()
    return StandardResponse.ok([WithdrawalOut.model_validate(w) for w in records])


@router.post("/{withdrawal_id}/action", response_model=StandardResponse[WithdrawalOut])
async def process_withdrawal_action(
    withdrawal_id: str,
    req: WithdrawalActionRequest,
    auth_payload: dict = Depends(require_admin),
    db: AsyncSession = Depends(get_db),
):
    admin_id = auth_payload["sub"]
    stmt = select(WithdrawalRequest).where(WithdrawalRequest.id == withdrawal_id)
    res = await db.execute(stmt)
    item = res.scalar_one_or_none()
    if not item:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Withdrawal request not found")

    now = datetime.now(timezone.utc)
    if req.action.upper() == "APPROVE":
        item.status = WithdrawalStatus.COMPLETED
        item.transaction_ref = req.transaction_ref or f"CBL-EFT-{int(now.timestamp())}"
        item.admin_feedback = req.admin_feedback or "Disbursed successfully"
        item.processed_at = now
        item.processed_by = admin_id
    elif req.action.upper() == "REJECT":
        item.status = WithdrawalStatus.REJECTED
        item.admin_feedback = req.admin_feedback or "Declined by compliance"
        item.processed_at = now
        item.processed_by = admin_id
    else:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Invalid action: use APPROVE or REJECT")

    await db.commit()
    await db.refresh(item)
    return StandardResponse.ok(WithdrawalOut.model_validate(item))
