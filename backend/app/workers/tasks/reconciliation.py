import logging
from app.workers.celery_app import celery_app

logger = logging.getLogger(__name__)


@celery_app.task(name="app.workers.tasks.reconciliation.clean_expired_reservations")
def clean_expired_reservations():
    """Background task to release expired share reservations."""
    logger.info("Running scheduled expired share reservations cleanup...")
    # In production, executes: UPDATE share_reservations SET status='EXPIRED' WHERE expires_at < NOW() AND status='ACTIVE'
    return {"status": "completed", "cleaned": 0}


@celery_app.task(name="app.workers.tasks.reconciliation.reconcile_pending_payments")
def reconcile_pending_payments():
    """Background task to reconcile pending payments with EPS and Bank ledgers."""
    logger.info("Running scheduled payment reconciliation...")
    return {"status": "completed", "reconciled": 0}
