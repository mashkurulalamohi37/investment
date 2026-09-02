from enum import Enum
from typing import List, Callable
from fastapi import Depends, HTTPException, status
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
import jwt

from app.core.config import settings
from app.core.database import get_db
from app.core.exceptions import AuthenticationException, PermissionDeniedException


class UserRole(str, Enum):
    SUPER_ADMIN = "SUPER_ADMIN"
    PROJECT_MANAGER = "PROJECT_MANAGER"
    FINANCE_MANAGER = "FINANCE_MANAGER"
    COMPLIANCE = "COMPLIANCE"
    SUPPORT = "SUPPORT"
    INVESTOR = "INVESTOR"


security_scheme = HTTPBearer(auto_error=False)


async def get_current_user_payload(
    credentials: HTTPAuthorizationCredentials = Depends(security_scheme),
) -> dict:
    if not credentials or not credentials.credentials:
        raise AuthenticationException("Authorization bearer token is required", code="AUTH_TOKEN_MISSING")

    token = credentials.credentials
    try:
        payload = jwt.decode(token, settings.SECRET_KEY, algorithms=[settings.JWT_ALGORITHM])
        if payload.get("type") != "access":
            raise AuthenticationException("Invalid token type. Access token required.", code="AUTH_INVALID_TOKEN_TYPE")
        return payload
    except jwt.ExpiredSignatureError:
        raise AuthenticationException("Token has expired. Please refresh your session.", code="AUTH_TOKEN_EXPIRED")
    except jwt.PyJWTError:
        raise AuthenticationException("Could not validate credentials", code="AUTH_INVALID_TOKEN")


def require_roles(allowed_roles: List[UserRole]) -> Callable:
    """FastAPI Dependency enforcing role-based access control."""
    def role_checker(payload: dict = Depends(get_current_user_payload)) -> dict:
        user_role = payload.get("role")
        if not user_role or user_role not in [r.value for r in allowed_roles]:
            raise PermissionDeniedException(
                f"Action requires one of the following roles: {[r.value for r in allowed_roles]}"
            )
        return payload
    return role_checker


# Convenience dependency shortcuts
require_admin = require_roles([UserRole.SUPER_ADMIN, UserRole.PROJECT_MANAGER, UserRole.FINANCE_MANAGER])
require_finance = require_roles([UserRole.SUPER_ADMIN, UserRole.FINANCE_MANAGER])
require_compliance = require_roles([UserRole.SUPER_ADMIN, UserRole.COMPLIANCE])
require_super_admin = require_roles([UserRole.SUPER_ADMIN])
require_authenticated = get_current_user_payload
