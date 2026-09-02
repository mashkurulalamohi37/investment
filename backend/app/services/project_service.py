from typing import List, Optional
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from sqlalchemy.orm import selectinload
from app.models.project import Project, ProjectStatus
from app.core.exceptions import NotFoundException
from app.core.redis import get_cache, set_cache, delete_cache


class ProjectService:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def get_projects(self, status: Optional[str] = None) -> List[Project]:
        cache_key = f"projects_list_{status or 'all'}"
        cached = await get_cache(cache_key)
        # Note: If cached data available, could return or fetch directly from db
        stmt = select(Project).options(selectinload(Project.milestones))
        if status:
            stmt = stmt.where(Project.status == status)
        stmt = stmt.order_by(Project.created_at.desc())
        result = await self.db.execute(stmt)
        return list(result.scalars().all())

    async def get_project_by_id(self, project_id: str) -> Project:
        stmt = (
            select(Project)
            .options(selectinload(Project.milestones))
            .where((Project.id == project_id) | (Project.code == project_id))
        )
        result = await self.db.execute(stmt)
        project = result.scalar_one_or_none()
        if not project:
            raise NotFoundException(f"Project with ID or code '{project_id}' not found", code="PROJECT_NOT_FOUND")
        return project

    async def create_project(self, project_data: dict) -> Project:
        project = Project(**project_data)
        self.db.add(project)
        await self.db.commit()
        await self.db.refresh(project)
        await delete_cache("projects_list_*")
        return project
