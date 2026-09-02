import sys
import os
from decimal import Decimal

# Ensure backend root is in python path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "../..")))

from app.utils.money import (
    to_decimal,
    calculate_investment_amount,
    calculate_pro_rata_payout,
    format_bdt,
)



import unittest


class TestMoneyCalculations(unittest.TestCase):
    def test_to_decimal_precision(self):
        self.assertEqual(to_decimal(25500), Decimal("25500.00"))
        self.assertEqual(to_decimal("25500.50"), Decimal("25500.50"))
        self.assertEqual(to_decimal(25500.499), Decimal("25500.50"))

    def test_calculate_investment_amount(self):
        unit_price = Decimal("25500.00")
        self.assertEqual(calculate_investment_amount(1, unit_price), Decimal("25500.00"))
        self.assertEqual(calculate_investment_amount(2, unit_price), Decimal("51000.00"))
        self.assertEqual(calculate_investment_amount(3, unit_price), Decimal("76500.00"))
        self.assertEqual(calculate_investment_amount(4, unit_price), Decimal("102000.00"))

    def test_calculate_pro_rata_payout(self):
        # 100 shares total, pool = 2,50,000 BDT
        pool = Decimal("250000.00")
        self.assertEqual(calculate_pro_rata_payout(pool, 4, 100), Decimal("10000.00"))
        self.assertEqual(calculate_pro_rata_payout(pool, 1, 100), Decimal("2500.00"))
        self.assertEqual(calculate_pro_rata_payout(pool, 0, 100), Decimal("0.00"))

    def test_format_bdt(self):
        amt = Decimal("2550000.00")
        self.assertEqual(format_bdt(amt, is_bangla=False), "৳ 2,550,000.00")
        self.assertIn("৳", format_bdt(amt, is_bangla=True))


if __name__ == "__main__":
    unittest.main()

