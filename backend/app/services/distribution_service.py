from datetime import datetime, timezone
from decimal import Decimal
from typing import List, Optional
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from app.models.distribution import ProfitPeriod, ProfitPeriodStatus, Distribution, DistributionStatus
from app.models.investment import Investment, InvestmentStatus
from app.models.project import Project
from app.core.exceptions import NotFoundException
from app.utils.money import calculate_pro_rata_payout


class DistributionService:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def calculate_profit_period(
        self,
        project_id: str,
        period_title: str,
        period_title_bn: str,
        period_start: datetime,
        period_end: datetime,
        realized_revenue: Decimal,
        realized_expenses: Decimal,
    ) -> ProfitPeriod:
        """Calculate pro-rata distributions for all eligible investors in the project."""
        stmt = select(Project).where(Project.id == project_id)
        res = await self.db.execute(stmt)
        project = res.scalar_one_or_none()
        if not project:
            raise NotFoundException("Project not found")

        net_profit = realized_revenue - realized_expenses
        distributable_pool = max(Decimal("0.00"), net_profit)
        amount_per_share = (distributable_pool / Decimal(project.total_shares)) if project.total_shares > 0 else Decimal("0.00")

        period = ProfitPeriod(
            project_id=project_id,
            period_title=period_title,
            period_title_bn=period_title_bn,
            period_start=period_start,
            period_end=period_end,
            realized_revenue=realized_revenue,
            realized_expenses=realized_expenses,
            net_profit=net_profit,
            distributable_pool=distributable_pool,
            amount_per_share=amount_per_share,
            status=ProfitPeriodStatus.CALCULATED,
        )
        self.db.add(period)
        await self.db.flush()

        # Find all allocated investments in project
        inv_stmt = (
            select(Investment)
            .where(Investment.project_id == project_id, Investment.status == InvestmentStatus.ALLOCATED)
        )
        inv_res = await self.db.execute(inv_stmt)
        investments = list(inv_res.scalars().all())

        for inv in investments:
            payout = calculate_pro_rata_payout(distributable_pool, inv.shares, project.total_shares)
            distribution = Distribution(
                profit_period_id=period.id,
                user_id=inv.user_id,
                investment_id=inv.id,
                eligible_shares=inv.shares,
                gross_payout=payout,
                tax_deduction=Decimal("0.00"),
                net_payout=payout,
                status=DistributionStatus.PAID,
                payment_method="bKash / Bank Payout",
                paid_at=datetime.now(timezone.utc),
            )
            self.db.add(distribution)

        await self.db.commit()
        await self.db.refresh(period)
        return period
