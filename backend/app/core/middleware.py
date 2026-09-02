import time
import uuid
from typing import Callable
from fastapi import FastAPI, Request, Response, status
from fastapi.responses import JSONResponse
from starlette.middleware.base import BaseHTTPMiddleware
from app.core.exceptions import AppException
import logging

logger = logging.getLogger(__name__)


class SecurityAndCorrelationMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request: Request, call_next: Callable) -> Response:
        start_time = time.time()
        request_id = request.headers.get("X-Request-ID", f"req-{uuid.uuid4().hex[:12]}")
        request.state.request_id = request_id

        try:
            response = await call_next(request)
        except AppException as app_ex:
            process_time = time.time() - start_time
            logger.warning(f"[{request_id}] App error: {app_ex.code} - {app_ex.message}")
            return JSONResponse(
                status_code=app_ex.status_code,
                content={
                    "success": False,
                    "data": None,
                    "error": {
                        "code": app_ex.code,
                        "message": app_ex.message,
                        "details": app_ex.details,
                    },
                    "meta": {
                        "request_id": request_id,
                        "process_time_ms": round(process_time * 1000, 2),
                    },
                },
                headers={
                    "X-Request-ID": request_id,
                    "X-Process-Time": f"{process_time:.4f}",
                    "X-Content-Type-Options": "nosniff",
                    "X-Frame-Options": "DENY",
                },
            )
        except Exception as exc:
            process_time = time.time() - start_time
            logger.error(f"[{request_id}] Unhandled error: {str(exc)}", exc_info=True)
            return JSONResponse(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                content={
                    "success": False,
                    "data": None,
                    "error": {
                        "code": "INTERNAL_SERVER_ERROR",
                        "message": "An unexpected error occurred. Please try again later.",
                        "details": {},
                    },
                    "meta": {
                        "request_id": request_id,
                        "process_time_ms": round(process_time * 1000, 2),
                    },
                },
                headers={
                    "X-Request-ID": request_id,
                    "X-Process-Time": f"{process_time:.4f}",
                    "X-Content-Type-Options": "nosniff",
                    "X-Frame-Options": "DENY",
                },
            )

        process_time = time.time() - start_time
        response.headers["X-Request-ID"] = request_id
        response.headers["X-Process-Time"] = f"{process_time:.4f}"
        response.headers["X-Content-Type-Options"] = "nosniff"
        response.headers["X-Frame-Options"] = "DENY"
        response.headers["Referrer-Policy"] = "strict-origin-when-cross-origin"
        return response
