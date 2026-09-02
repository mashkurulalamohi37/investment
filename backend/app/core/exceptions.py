from typing import Any, Dict, Optional
from fastapi import status


class AppException(Exception):
    """Base Domain Exception for all Swapnojatri application errors."""

    def __init__(
        self,
        code: str,
        message: str,
        status_code: int = status.HTTP_400_BAD_REQUEST,
        details: Optional[Dict[str, Any]] = None,
    ):
        self.code = code
        self.message = message
        self.status_code = status_code
        self.details = details or {}
        super().__init__(message)


class NotFoundException(AppException):
    def __init__(self, message: str = "Resource not found", code: str = "RESOURCE_NOT_FOUND"):
        super().__init__(code=code, message=message, status_code=status.HTTP_404_NOT_FOUND)


class AuthenticationException(AppException):
    def __init__(self, message: str = "Authentication failed", code: str = "AUTH_FAILED"):
        super().__init__(code=code, message=message, status_code=status.HTTP_401_UNAUTHORIZED)


class PermissionDeniedException(AppException):
    def __init__(self, message: str = "Permission denied", code: str = "PERMISSION_DENIED"):
        super().__init__(code=code, message=message, status_code=status.HTTP_403_FORBIDDEN)


class ConflictException(AppException):
    def __init__(self, message: str = "Resource conflict", code: str = "CONFLICT"):
        super().__init__(code=code, message=message, status_code=status.HTTP_409_CONFLICT)


class SharesUnavailableException(AppException):
    def __init__(self, message: str = "Requested shares are no longer available", code: str = "SHARES_UNAVAILABLE"):
        super().__init__(code=code, message=message, status_code=status.HTTP_409_CONFLICT)


class InvalidStateTransitionException(AppException):
    def __init__(self, message: str = "Invalid status transition", code: str = "INVALID_STATUS_TRANSITION"):
        super().__init__(code=code, message=message, status_code=status.HTTP_422_UNPROCESSABLE_ENTITY)


class RateLimitExceededException(AppException):
    def __init__(self, message: str = "Too many requests. Please try again later.", code: str = "RATE_LIMIT_EXCEEDED"):
        super().__init__(code=code, message=message, status_code=status.HTTP_429_TOO_MANY_REQUESTS)
