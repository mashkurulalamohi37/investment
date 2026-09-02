from typing import List, Optional
from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.database import get_db
from app.schemas.common import StandardResponse
from app.schemas.project import ProjectOut, ProjectCreate
from app.services.project_service import ProjectService
from app.core.permissions import require_admin

router = APIRouter(prefix="/projects", tags=["Projects"])


@router.get("", response_model=StandardResponse[List[ProjectOut]])
async def list_projects(status: Optional[str] = None, db: AsyncSession = Depends(get_db)):
    service = ProjectService(db)
    projects = await service.get_projects(status=status)
    data = [ProjectOut.model_validate(p) for p in projects]
    return StandardResponse.ok(data)


@router.get("/{project_id}", response_model=StandardResponse[ProjectOut])
async def get_project(project_id: str, db: AsyncSession = Depends(get_db)):
    service = ProjectService(db)
    project = await service.get_project_by_id(project_id)
    return StandardResponse.ok(ProjectOut.model_validate(project))


@router.post("", response_model=StandardResponse[ProjectOut], dependencies=[Depends(require_admin)])
async def create_project(req: ProjectCreate, db: AsyncSession = Depends(get_db)):
    service = ProjectService(db)
    project = await service.create_project(req.model_dump())
    return StandardResponse.ok(ProjectOut.model_validate(project))
