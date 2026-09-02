import json
from typing import Any, Optional
import redis.asyncio as aioredis
from app.core.config import settings

# Global async Redis client
redis_client: Optional[aioredis.Redis] = None


async def init_redis() -> aioredis.Redis:
    global redis_client
    if redis_client is None:
        redis_client = aioredis.from_url(
            settings.REDIS_URL,
            encoding="utf-8",
            decode_responses=True,
            max_connections=50,
        )
    return redis_client


async def close_redis() -> None:
    global redis_client
    if redis_client is not None:
        await redis_client.close()
        redis_client = None


async def get_cache(key: str) -> Optional[Any]:
    """Retrieve JSON-deserialized object from Redis cache."""
    if redis_client is None:
        return None
    try:
        val = await redis_client.get(key)
        if val:
            return json.loads(val)
    except Exception:
        pass
    return None


async def set_cache(key: str, value: Any, ttl_seconds: int = 300) -> None:
    """Store JSON-serialized object in Redis cache."""
    if redis_client is None:
        return
    try:
        await redis_client.set(key, json.dumps(value, default=str), ex=ttl_seconds)
    except Exception:
        pass


async def delete_cache(key_pattern: str) -> None:
    """Delete keys matching pattern or exact string."""
    if redis_client is None:
        return
    try:
        if "*" in key_pattern:
            keys = await redis_client.keys(key_pattern)
            if keys:
                await redis_client.delete(*keys)
        else:
            await redis_client.delete(key_pattern)
    except Exception:
        pass
