import 'package:flutter_test/flutter_test.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/data/state/app_state.dart';
import 'package:swapnojatri/data/models/investment_model.dart';
import 'package:swapnojatri/data/models/kyc_model.dart';

void main() {
  group('Currency & Financial Formatting Tests', () {
    test('Formats BDT in South Asian Lakh/Crore grouping correctly', () {
      expect(CurrencyFormatter.format(2550000), '৳ 25,50,000');
      expect(CurrencyFormatter.format(102000), '৳ 1,02,000');
      expect(CurrencyFormatter.format(25500), '৳ 25,500');
    });

    test('Formats Bengali numerals properly', () {
      expect(CurrencyFormatter.format(2550000, isBangla: true), '৳ ২৫,৫০,০০০');
      expect(CurrencyFormatter.format(51000, isBangla: true), '৳ ৫১,০০০');
    });

    test('Compact format works for Lakhs and Crores', () {
      expect(CurrencyFormatter.formatCompact(2550000), '৳ 25.50 Lakh');
      expect(CurrencyFormatter.formatCompact(2550000, isBangla: true), '৳ ২৫.৫০ লাখ');
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
      expect(project.remainingFund, 2550000.0 - (74 * 25500.0));
    });

    test('Investor cannot submit more shares than limit (1-4)', () {
      final successTooMany = state.submitInvestmentRequest(
        shares: 5,
        paymentMethod: 'City Bank',
        paymentReference: 'TXN-FAIL-01',
      );
      expect(successTooMany, isFalse);

      final successZero = state.submitInvestmentRequest(
        shares: 0,
        paymentMethod: 'City Bank',
        paymentReference: 'TXN-FAIL-02',
      );
      expect(successZero, isFalse);
    });

    test('Investment submission creates pending record and ledger entry', () {
      final initialTxnCount = state.transactions.length;
      final initialInvCount = state.investments.length;

      final success = state.submitInvestmentRequest(
        shares: 2,
        paymentMethod: 'City Bank PLC',
        paymentReference: 'TXN-TEST-12345',
      );

      expect(success, isTrue);
      expect(state.investments.length, initialInvCount + 1);
      expect(state.transactions.length, initialTxnCount + 1);

      final newInv = state.investments.first;
      expect(newInv.shares, 2);
      expect(newInv.grossAmount, 51000.0);
      expect(newInv.status, InvestmentStatus.pending);
    });

    test('Admin verifies payment and atomically allocates share lots', () {
      state.submitInvestmentRequest(
        shares: 2,
        paymentMethod: 'City Bank PLC',
        paymentReference: 'TXN-ALLOC-999',
      );

      final newInvId = state.investments.first.id;
      final prevAllocated = state.landVest100.allocatedShares;

      state.adminVerifyAndAllocateShare(newInvId);

      final updatedInv = state.investments.first;
      expect(updatedInv.status, InvestmentStatus.allocated);
      expect(updatedInv.allocatedLotNumbers.length, 2);
      expect(updatedInv.allocatedLotNumbers, ['LOT-075', 'LOT-076']);
      expect(state.landVest100.allocatedShares, prevAllocated + 2);
    });

    test('Fund transparency expense addition updates live project balance', () {
      final prevBalance = state.projectRemainingBalance;
      state.adminAddExpense(
        category: 'Legal Search',
        description: 'Advocate Search Fees',
        payee: 'Hossain Legal',
        amount: 20000.0,
      );

      expect(state.projectRemainingBalance, prevBalance - 20000.0);
    });

    test('KYC submission changes status to underReview and Admin can verify', () {
      state.submitKyc(
        fullName: 'Test Investor',
        fatherName: 'Father',
        motherName: 'Mother',
        nidNumber: '1234567890',
        dateOfBirth: '01 Jan 1990',
        presentAddress: 'Dhaka',
        permanentAddress: 'Dhaka',
        bankName: 'City Bank',
        bankAccountNumber: '123456',
        routingNumber: '987654',
        nominee: const NomineeModel(
          name: 'Nominee',
          relationship: 'Spouse',
          phone: '01800000000',
          nidNumber: '9999999999',
        ),
      );

      expect(state.kyc.status, KycStatus.underReview);

      state.adminApproveKyc();
      expect(state.kyc.status, KycStatus.verified);
      expect(state.currentUser.isKycVerified, isTrue);
    });
  });
}
