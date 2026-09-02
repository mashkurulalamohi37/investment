from datetime import datetime
from typing import Optional
from pydantic import BaseModel


class DocumentOut(BaseModel):
    id: str
    project_id: Optional[str] = None
    user_id: Optional[str] = None
    investment_id: Optional[str] = None
    title: str
    title_bn: str
    category: str
    visibility: str
    file_name: str
    file_size_human: str
    checksum_sha256: str
    version: str
    uploaded_by: str
    created_at: datetime

    class Config:
        from_attributes = True


class DocumentDownloadUrlResponse(BaseModel):
    download_url: str
    expires_in_seconds: int
    checksum_sha256: str
