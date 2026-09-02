import os
from typing import List, Union
from pydantic import AnyHttpUrl, field_validator
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        case_sensitive=True,
        extra="allow",
    )

    # General
    ENVIRONMENT: str = "development"
    DEBUG: bool = True
    APP_NAME: str = "Swapnojatri Investment Platform API"
    API_V1_STR: str = "/api/v1"
    PROJECT_TIMEZONE: str = "Asia/Dhaka"

    # Server
    HOST: str = "0.0.0.0"
    PORT: int = 8000

    # Security & Tokens
    SECRET_KEY: str = "swapnojatri_dev_secret_key_change_in_production_9821"
    JWT_ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 60
    REFRESH_TOKEN_EXPIRE_DAYS: int = 30
    OTP_EXPIRE_MINUTES: int = 5
    OTP_MAX_ATTEMPTS: int = 5

    # Database
    DATABASE_URL: str = "postgresql+asyncpg://swapnojatri_user:swapnojatri_secure_pass_2026@localhost:5432/swapnojatri_db"
    SYNC_DATABASE_URL: str = "postgresql+psycopg2://swapnojatri_user:swapnojatri_secure_pass_2026@localhost:5432/swapnojatri_db"
    DB_POOL_SIZE: int = 20
    DB_MAX_OVERFLOW: int = 10
    DB_POOL_TIMEOUT: int = 30
    DB_POOL_RECYCLE: int = 1800

    # Redis
    REDIS_URL: str = "redis://localhost:6379/0"
    REDIS_CACHE_TTL_SECONDS: int = 300

    # Celery
    CELERY_BROKER_URL: str = "redis://localhost:6379/1"
    CELERY_RESULT_BACKEND: str = "redis://localhost:6379/2"

    # S3 / MinIO Object Storage
    S3_ENDPOINT_URL: str = "http://localhost:9000"
    S3_ACCESS_KEY: str = "minioadmin"
    S3_SECRET_KEY: str = "minioadmin123"
    S3_BUCKET_PUBLIC: str = "swapnojatri-public-assets"
    S3_BUCKET_PRIVATE: str = "swapnojatri-private-vault"
    S3_BUCKET_REPORTS: str = "swapnojatri-reports"
    S3_REGION: str = "ap-southeast-1"

    # EPS Payment Gateway
    EPS_MERCHANT_ID: str = "EPS_MERCHANT_SWAPNOJATRI_01"
    EPS_STORE_ID: str = "STORE_SWAPNOJATRI_MAIN"
    EPS_APP_SECRET: str = "eps_sec_k98a21f7e02b8429910d"
    EPS_IS_SANDBOX: bool = True
    EPS_SANDBOX_URL: str = "https://sandbox.epay.com.bd/api/v1"
    EPS_LIVE_URL: str = "https://api.epay.com.bd/api/v1"

    # CORS
    CORS_ORIGINS: List[str] = [
        "http://localhost:3000",
        "http://localhost:8080",
        "http://127.0.0.1:8080",
        "http://localhost:8000",
        "https://swapnojatri.com",
    ]

    # Sentry
    SENTRY_DSN: str = ""

    @property
    def eps_active_base_url(self) -> str:
        return self.EPS_SANDBOX_URL if self.EPS_IS_SANDBOX else self.EPS_LIVE_URL


settings = Settings()
