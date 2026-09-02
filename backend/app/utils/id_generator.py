import time
import random
import string


def generate_public_id(prefix: str) -> str:
    """Generate human-readable public entity identifier (e.g. inv-2026-98124)."""
    ts = int(time.time() * 1000)
    suffix = "".join(random.choices(string.digits, k=4))
    return f"{prefix}-{ts}-{suffix}"


def generate_investment_number(project_code: str, sequence_no: int) -> str:
    """Generate formatted investment certificate/ledger number (e.g. SJ-LV100-0042)."""
    return f"SJ-{project_code}-{str(sequence_no).zfill(4)}"


def generate_transaction_ref(prefix: str = "TXN") -> str:
    """Generate unique financial transaction reference code."""
    ts = int(time.time())
    suffix = "".join(random.choices(string.ascii_uppercase + string.digits, k=6))
    return f"{prefix}-{ts}-{suffix}"
