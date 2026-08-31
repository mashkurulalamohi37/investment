import 'package:flutter_test/flutter_test.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/data/state/app_state.dart';
import 'package:swapnojatri/data/models/investment_model.dart';
import 'package:swapnojatri/data/models/transaction_model.dart';

void main() {
  group('Currency & Financial Formatting Tests', () {
    test('Formats BDT in South Asian Lakh/Crore grouping correctly', () {
      expect(CurrencyFormatter.format(2550000), '৳\u200925,50,000');
      expect(CurrencyFormatter.format(102000), '৳\u20091,02,000');
      expect(CurrencyFormatter.format(25500), '৳\u200925,500');
    });

    test('Formats Bengali numerals properly', () {
      expect(CurrencyFormatter.format(2550000, isBangla: true), '৳\u2009২৫,৫০,০০০');
      expect(CurrencyFormatter.format(51000, isBangla: true), '৳\u2009৫১,০০০');
    });

    test('Compact format works for Lakhs and Crores', () {
      expect(CurrencyFormatter.formatCompact(2550000), '৳\u200925.50 Lakh');
      expect(CurrencyFormatter.formatCompact(2550000, isBangla: true), '৳\u2009২৫.৫০ লাখ');
    });
  });

  group('LandVest 100 Financial Engine & State Store Tests', () {
    late AppState state;

    setUp(() {
      state = AppState();
    });

    test('LandVest 100 seed constants are mathematically correct', () {
      final project = state.landVest100;
      expect(project.totalShares, 100);
      expect(project.pricePerShare, 25500.0);
      expect(project.targetFund, 2550000.0);
      expect(project.allocatedShares, 74);
      expect(project.availableShares, 26);
      expect(project.collectedFund, 74 * 25500.0);
    });

    test('Investment submission creates pending record and ledger entry', () {
      final initialTxnCount = state.transactions.length;
      final initialInvCount = state.investments.length;

      final newInv = InvestmentModel(
        id: 'inv-test-01',
        projectId: 'lv-100',
        projectTitle: 'LandVest 100',
        projectTitleBn: 'ল্যান্ডভেস্ট ১০০',
        investorId: 'usr-001',
        investorName: 'Rahim Ahmed',
        sharesCount: 2,
        pricePerShare: 25500.0,
        totalAmount: 51000.0,
        assignedLots: [],
        status: InvestmentStatus.pendingPaymentVerification,
        paymentMethod: 'City Bank PLC',
        transactionRef: 'TXN-TEST-12345',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final newTxn = TransactionModel(
        id: 'txn-test-01',
        investmentId: newInv.id,
        userId: 'usr-001',
        type: TransactionType.sharePurchase,
        status: TransactionStatus.pending,
        amount: 51000.0,
        title: 'LandVest 100 Share Purchase (2 shares)',
        reference: 'TXN-TEST-12345',
        paymentMethod: 'City Bank PLC',
        createdAt: DateTime.now(),
      );

      state.submitInvestment(newInv, newTxn);

      expect(state.investments.length, initialInvCount + 1);
      expect(state.transactions.length, initialTxnCount + 1);
    });

    test('Admin verifies payment and atomically allocates share lots', () {
      final newInv = InvestmentModel(
        id: 'inv-test-alloc',
        projectId: 'lv-100',
        projectTitle: 'LandVest 100',
        projectTitleBn: 'ল্যান্ডভেস্ট ১০০',
        investorId: 'usr-001',
        investorName: 'Rahim Ahmed',
        sharesCount: 2,
        pricePerShare: 25500.0,
        totalAmount: 51000.0,
        assignedLots: [],
        status: InvestmentStatus.pendingPaymentVerification,
        paymentMethod: 'City Bank PLC',
        transactionRef: 'TXN-ALLOC-999',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      state.submitInvestment(newInv);
      final prevAllocated = state.landVest100.allocatedShares;

      state.adminVerifyAndAllocateShare('inv-test-alloc');

      final updatedInv = state.investments.firstWhere((i) => i.id == 'inv-test-alloc');
      expect(updatedInv.status, InvestmentStatus.allocated);
      expect(updatedInv.assignedLots.length, 2);
      expect(updatedInv.assignedLots, ['LOT-075', 'LOT-076']);
      expect(state.landVest100.allocatedShares, prevAllocated + 2);
    });
  });
}
