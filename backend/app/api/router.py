from fastapi import APIRouter
from app.api.v1 import auth, projects, investments, payments, admin, kyc, documents

api_router = APIRouter(prefix="/api/v1")

api_router.include_router(auth.router)
api_router.include_router(projects.router)
api_router.include_router(investments.router)
api_router.include_router(payments.router)
api_router.include_router(admin.router)
api_router.include_router(kyc.router)
api_router.include_router(documents.router)
