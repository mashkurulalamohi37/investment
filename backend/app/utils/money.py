from decimal import Decimal, ROUND_HALF_UP
from typing import Union

# Currency rounding precision (2 decimal places)
TWO_PLACES = Decimal("0.01")


def to_decimal(value: Union[str, int, float, Decimal]) -> Decimal:
    """Safely convert any numeric input into exact Decimal."""
    if isinstance(value, float):
        return Decimal(str(value)).quantize(TWO_PLACES, rounding=ROUND_HALF_UP)
    return Decimal(value).quantize(TWO_PLACES, rounding=ROUND_HALF_UP)


def calculate_investment_amount(shares: int, unit_price: Union[str, Decimal]) -> Decimal:
    """Authoritative calculation: Total = Shares * Unit Price."""
    price = to_decimal(unit_price)
    return (Decimal(shares) * price).quantize(TWO_PLACES, rounding=ROUND_HALF_UP)


def calculate_pro_rata_payout(
    distribution_pool: Union[str, Decimal],
    investor_shares: int,
    total_eligible_shares: int = 100,
) -> Decimal:
    """Authoritative pro-rata dividend payout calculation."""
    if total_eligible_shares <= 0 or investor_shares <= 0:
        return Decimal("0.00")
    pool = to_decimal(distribution_pool)
    share_fraction = Decimal(investor_shares) / Decimal(total_eligible_shares)
    return (pool * share_fraction).quantize(TWO_PLACES, rounding=ROUND_HALF_UP)


def format_bdt(amount: Decimal, is_bangla: bool = False) -> str:
    """Format decimal amount with currency symbol."""
    formatted = f"৳ {amount:,.2f}"
    if is_bangla:
        # Replace latin digits with Bengali digits
        bengali_digits = {"0": "০", "1": "১", "2": "২", "3": "৩", "4": "৪", "5": "৫", "6": "৬", "7": "৭", "8": "৮", "9": "৯"}
        for k, v in bengali_digits.items():
            formatted = formatted.replace(k, v)
    return formatted
