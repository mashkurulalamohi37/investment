from celery import Celery
from app.core.config import settings

celery_app = Celery(
    "swapnojatri_tasks",
    broker=settings.CELERY_BROKER_URL,
    backend=settings.CELERY_RESULT_BACKEND,
)

celery_app.conf.update(
    task_serializer="json",
    accept_content=["json"],
    result_serializer="json",
    timezone=settings.PROJECT_TIMEZONE,
    enable_utc=True,
    task_track_started=True,
    task_time_limit=300,  # 5 minutes
    worker_prefetch_multiplier=1,
)

# Scheduled Periodic Beat Tasks
celery_app.conf.beat_schedule = {
    "clean-expired-reservations-every-minute": {
        "task": "app.workers.tasks.reconciliation.clean_expired_reservations",
        "schedule": 60.0,
    },
    "reconcile-pending-payments-hourly": {
        "task": "app.workers.tasks.reconciliation.reconcile_pending_payments",
        "schedule": 3600.0,
    },
}
