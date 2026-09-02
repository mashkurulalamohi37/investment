from typing import List
from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.database import get_db
from app.schemas.common import StandardResponse
from app.schemas.document import DocumentOut, DocumentDownloadUrlResponse
from app.services.document_service import DocumentService
from app.core.permissions import require_authenticated

router = APIRouter(prefix="/documents", tags=["Document Vault"])


@router.get("/project/{project_id}", response_model=StandardResponse[List[DocumentOut]])
async def get_project_documents(
    project_id: str,
    db: AsyncSession = Depends(get_db),
):
    service = DocumentService(db)
    docs = await service.get_project_documents(project_id)
    return StandardResponse.ok([DocumentOut.model_validate(d) for d in docs])


@router.get("/{document_id}/download-url", response_model=StandardResponse[DocumentDownloadUrlResponse])
async def get_document_download_url(
    document_id: str,
    auth_payload: dict = Depends(require_authenticated),
    db: AsyncSession = Depends(get_db),
):
    service = DocumentService(db)
    res = await service.generate_download_url(document_id)
    return StandardResponse.ok(DocumentDownloadUrlResponse(**res))
