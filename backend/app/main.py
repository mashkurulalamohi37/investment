from contextlib import asynccontextmanager
from fastapi import FastAPI, status
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy import text
from app.core.config import settings
from app.core.database import async_engine, Base
from app.core.redis import init_redis, close_redis, redis_client
from app.core.logging import setup_logging
from app.core.middleware import SecurityAndCorrelationMiddleware
from app.api.router import api_router
from app.schemas.common import StandardResponse

# Initialize structured logging
setup_logging(debug=settings.DEBUG)


@asynccontextmanager
async def lifespan(app: FastAPI):
    # Startup
    await init_redis()
    async with async_engine.begin() as conn:
        # Create tables automatically in development if they don't exist
        await conn.run_sync(Base.metadata.create_all)
    yield
    # Shutdown
    await close_redis()
    await async_engine.dispose()


app = FastAPI(
    title=settings.APP_NAME,
    description="Swapnojatri Institutional Land & Agro Investment Crowdfunding Backend API (LandVest 100)",
    version="1.0.0",
    docs_url="/docs",
    redoc_url="/redoc",
    openapi_url="/api/v1/openapi.json",
    lifespan=lifespan,
)

# 1. CORS Middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.CORS_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# 2. Security and Correlation Middleware
app.add_middleware(SecurityAndCorrelationMiddleware)

# 3. Mount V1 API Routers
app.include_router(api_router)


# 4. Health Check Endpoints
@app.get("/health", tags=["Health"])
@app.get("/health/live", tags=["Health"])
async def health_check():
    return StandardResponse.ok({"status": "healthy", "service": settings.APP_NAME, "environment": settings.ENVIRONMENT})


@app.get("/health/ready", tags=["Health"])
async def readiness_check():
    db_ok = False
    redis_ok = False
    try:
        async with async_engine.connect() as conn:
            await conn.execute(text("SELECT 1"))
            db_ok = True
    except Exception:
        db_ok = False

    try:
        if redis_client:
            pong = await redis_client.ping()
            redis_ok = bool(pong)
    except Exception:
        redis_ok = False

    is_ready = db_ok and redis_ok
    status_code = status.HTTP_200_OK if is_ready else status.HTTP_503_SERVICE_UNAVAILABLE

    return StandardResponse.ok({
        "status": "ready" if is_ready else "degraded",
        "database": "connected" if db_ok else "disconnected",
        "redis": "connected" if redis_ok else "disconnected",
    })
