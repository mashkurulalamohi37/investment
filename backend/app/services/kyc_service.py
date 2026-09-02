from datetime import datetime, timezone
from typing import Optional
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from app.models.kyc import KycProfile, KycStatus, Nominee
from app.models.user import User
from app.core.exceptions import NotFoundException


class KycService:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def submit_kyc(self, user_id: str, kyc_data: dict) -> KycProfile:
        nominee_data = kyc_data.pop("nominee", None)

        stmt = select(KycProfile).where(KycProfile.user_id == user_id)
        res = await self.db.execute(stmt)
        profile = res.scalar_one_or_none()

        if not profile:
            profile = KycProfile(user_id=user_id, **kyc_data)
            self.db.add(profile)
        else:
            for k, v in kyc_data.items():
                setattr(profile, k, v)
            profile.status = KycStatus.UNDER_REVIEW

        if nominee_data:
            nom_stmt = select(Nominee).where(Nominee.user_id == user_id)
            nom_res = await self.db.execute(nom_stmt)
            nominee = nom_res.scalar_one_or_none()
            if not nominee:
                nominee = Nominee(user_id=user_id, **nominee_data)
                self.db.add(nominee)
            else:
                for k, v in nominee_data.items():
                    setattr(nominee, k, v)

        await self.db.commit()
        await self.db.refresh(profile)
        return profile

    async def get_kyc_by_user(self, user_id: str) -> Optional[KycProfile]:
        stmt = select(KycProfile).where(KycProfile.user_id == user_id)
        res = await self.db.execute(stmt)
        return res.scalar_one_or_none()
