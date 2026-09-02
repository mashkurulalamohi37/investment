from datetime import datetime, timezone
from typing import Generic, Optional, TypeVar, Any, Dict
from pydantic import BaseModel, Field

DataT = TypeVar("DataT")


class ErrorDetail(BaseModel):
    code: str
    message: str
    details: Optional[Dict[str, Any]] = None


class ResponseMeta(BaseModel):
    timestamp: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))
    request_id: Optional[str] = None
    process_time_ms: Optional[float] = None


class StandardResponse(BaseModel, Generic[DataT]):
    success: bool = True
    data: Optional[DataT] = None
    error: Optional[ErrorDetail] = None
    meta: ResponseMeta = Field(default_factory=ResponseMeta)

    @classmethod
    def ok(cls, data: DataT, request_id: Optional[str] = None) -> "StandardResponse[DataT]":
        meta = ResponseMeta(request_id=request_id)
        return cls(success=True, data=data, meta=meta)

    @classmethod
    def fail(cls, code: str, message: str, details: Optional[Dict[str, Any]] = None, request_id: Optional[str] = None) -> "StandardResponse[Any]":
        meta = ResponseMeta(request_id=request_id)
        error = ErrorDetail(code=code, message=message, details=details)
        return cls(success=False, data=None, error=error, meta=meta)
