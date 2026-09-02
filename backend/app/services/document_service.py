from typing import List, Optional
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from app.models.document import Document, DocumentVisibility
from app.core.exceptions import NotFoundException


class DocumentService:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def get_project_documents(self, project_id: str) -> List[Document]:
        stmt = select(Document).where(Document.project_id == project_id)
        res = await self.db.execute(stmt)
        return list(res.scalars().all())

    async def generate_download_url(self, document_id: str) -> dict:
        stmt = select(Document).where(Document.id == document_id)
        res = await self.db.execute(stmt)
        doc = res.scalar_one_or_none()
        if not doc:
            raise NotFoundException("Document not found", code="DOCUMENT_NOT_FOUND")

        # In production with S3/MinIO:
        # s3_client.generate_presigned_url('get_object', Params={'Bucket': settings.S3_BUCKET_PRIVATE, 'Key': doc.s3_key}, ExpiresIn=300)
        return {
            "download_url": f"https://vault.swapnojatri.com/files/{doc.s3_key}?token=signed_exp_300s",
            "expires_in_seconds": 300,
            "checksum_sha256": doc.checksum_sha256,
        }
