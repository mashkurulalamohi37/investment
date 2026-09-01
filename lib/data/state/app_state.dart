import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/data/models/project_model.dart';
import 'package:swapnojatri/data/models/investment_model.dart';
import 'package:swapnojatri/data/models/transaction_model.dart';
import 'package:swapnojatri/data/models/expense_model.dart';
import 'package:swapnojatri/data/models/asset_model.dart';
import 'package:swapnojatri/data/models/profit_period_model.dart';
import 'package:swapnojatri/data/models/distribution_model.dart';
import 'package:swapnojatri/data/models/document_model.dart';
import 'package:swapnojatri/data/models/notification_model.dart';
import 'package:swapnojatri/data/models/kyc_model.dart';
import 'package:swapnojatri/data/models/audit_log_model.dart';
import 'package:swapnojatri/data/models/user_model.dart';
import 'package:swapnojatri/core/constants/project_seeds.dart';

/// Central reactive state store for Swapnojatri Investment Platform
class AppState extends ChangeNotifier {
  // App Configuration
  bool _isBangla = true; // Bangla-first by default
  ThemeMode _themeMode = ThemeMode.light;
  AppPaletteFlavor _paletteFlavor = AppPaletteFlavor.paddyField; // "Paddy Field" (Wise-inspired)
  UserRole _activeRole = UserRole.investor;

  // Active Users
  UserModel _currentUser = ProjectSeeds.defaultInvestor;
  final UserModel _adminUser = ProjectSeeds.defaultAdmin;

  // Domain Data
  late ProjectModel _landVest100;
  final List<ProjectModel> _projects = [];
  final List<InvestmentModel> _investments = [];
  final List<TransactionModel> _transactions = [];
  final List<ExpenseModel> _expenses = [];
  final List<AssetModel> _assets = [];
  final List<ProfitPeriodModel> _profitPeriods = [];
  final List<DistributionModel> _distributions = [];
  final List<DocumentModel> _documents = [];
  final List<NotificationModel> _notifications = [];
  final List<AuditLogModel> _auditLogs = [];
  late KycModel _kyc;

  AppState() {
    _initSeedData();
  }

  void _initSeedData() {
    _landVest100 = ProjectSeeds.landVest100;
    _projects.add(_landVest100);
    _projects.add(ProjectSeeds.agroVest1);
    _projects.add(ProjectSeeds.landVest90);
    _investments.addAll(ProjectSeeds.defaultInvestments);
    _transactions.addAll(ProjectSeeds.defaultTransactions);
    _expenses.addAll(ProjectSeeds.defaultExpenses);
    _assets.addAll(ProjectSeeds.defaultAssets);
    _profitPeriods.addAll(ProjectSeeds.defaultProfitPeriods);
    _distributions.addAll(ProjectSeeds.defaultDistributions);
    _documents.addAll(ProjectSeeds.defaultDocuments);
    _notifications.addAll(ProjectSeeds.defaultNotifications);
    _auditLogs.addAll(ProjectSeeds.defaultAuditLogs);
    _kyc = ProjectSeeds.defaultKyc;
  }

  // Getters
  bool get isBangla => _isBangla;
  ThemeMode get themeMode => _themeMode;
  AppPaletteFlavor get paletteFlavor => _paletteFlavor;
  UserRole get activeRole => _activeRole;
  UserModel get currentUser => _activeRole == UserRole.admin ? _adminUser : _currentUser;
  bool get isAdmin => _activeRole == UserRole.admin;

  ProjectModel get landVest100 => _landVest100;
  List<ProjectModel> get projects => List.unmodifiable(_projects);
  List<InvestmentModel> get investments => List.unmodifiable(_investments);
  List<TransactionModel> get transactions => List.unmodifiable(_transactions);
  List<ExpenseModel> get expenses => List.unmodifiable(_expenses);
  List<AssetModel> get assets => List.unmodifiable(_assets);
  List<ProfitPeriodModel> get profitPeriods => List.unmodifiable(_profitPeriods);
  List<DistributionModel> get distributions => List.unmodifiable(_distributions);
  List<DocumentModel> get documents => List.unmodifiable(_documents);
  List<NotificationModel> get notifications => List.unmodifiable(_notifications);
  List<AuditLogModel> get auditLogs => List.unmodifiable(_auditLogs);
  KycModel get kyc => _kyc;

  int get unreadNotificationCount => _notifications.where((n) => !n.isRead).length;

  // Financial Computations for Active Investor
  double get totalInvested => _investments
      .where((i) => i.status == InvestmentStatus.allocated || i.status == InvestmentStatus.verified)
      .fold(0.0, (sum, i) => sum + i.grossAmount);

  int get totalSharesOwned => _investments
      .where((i) => i.status == InvestmentStatus.allocated)
      .fold(0, (sum, i) => sum + i.shares);

  double get totalRealizedProfit => _distributions
      .where((d) => d.status == DistributionStatus.paid)
      .fold(0.0, (sum, d) => sum + d.amount);

  double get pendingDistributionAmount => _distributions
      .where((d) => d.status == DistributionStatus.approved || d.status == DistributionStatus.processing)
      .fold(0.0, (sum, d) => sum + d.amount);

  // Fund Transparency Computations
  double get totalProjectCollected => _landVest100.collectedFund;
  double get totalProjectExpenses => _expenses
      .where((e) => e.status == ExpenseStatus.approved)
      .fold(0.0, (sum, e) => sum + e.amount);
  double get projectRemainingBalance => (_landVest100.targetFund - totalProjectExpenses).clamp(0.0, double.infinity);

  // Admin Operational KPIs
  int get adminTotalInvestors => 28;
  double get adminTotalCollection => _landVest100.collectedFund;
  double get adminFundUtilizationPercentage => totalProjectCollected > 0
      ? (totalProjectExpenses / totalProjectCollected).clamp(0.0, 1.0)
      : 0.0;
  int get adminPendingPaymentsCount => _investments.where((i) => i.status == InvestmentStatus.pending).length;
  int get adminPendingKycCount => _kyc.status == KycStatus.underReview || _kyc.status == KycStatus.pending ? 1 : 0;

  // State Modifiers
  void toggleLanguage() {
    _isBangla = !_isBangla;
    notifyListeners();
  }

  void setLanguage(bool isBangla) {
    if (_isBangla != isBangla) {
      _isBangla = isBangla;
      notifyListeners();
    }
  }

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  void togglePaletteFlavor() {
    switch (_paletteFlavor) {
      case AppPaletteFlavor.royalBlue:
      case AppPaletteFlavor.paddyField:
        _paletteFlavor = AppPaletteFlavor.ledgerRed;
        break;
      case AppPaletteFlavor.ledgerRed:
        _paletteFlavor = AppPaletteFlavor.pineTreasury;
        break;
      case AppPaletteFlavor.pineTreasury:
        _paletteFlavor = AppPaletteFlavor.royalBlue;
        break;
    }
    notifyListeners();
  }

  void addProject(ProjectModel project) {
    _projects.add(project);
    notifyListeners();
  }

  void setPaletteFlavor(AppPaletteFlavor flavor) {
    _paletteFlavor = flavor;
    notifyListeners();
  }

  void switchRole(UserRole role) {
    _activeRole = role;
    notifyListeners();
  }

  void switchUser(String userId) {
    if (userId == 'usr-002') {
      _activeRole = UserRole.admin;
    } else {
      _activeRole = UserRole.investor;
    }
    notifyListeners();
  }

  // Investment Actions
  bool investInProject(String projectId, int shares, String paymentMethod, [String paymentReference = 'TXN-ONLINE-DIRECT']) {
    return submitInvestmentRequest(
      shares: shares,
      paymentMethod: paymentMethod,
      paymentReference: paymentReference,
    );
  }

  bool submitInvestmentRequest({
    required int shares,
    required String paymentMethod,
    required String paymentReference,
  }) {
    if (shares < 1 || shares > _landVest100.maxShares) return false;
    if (shares > _landVest100.availableShares) return false;

    final unitPrice = _landVest100.pricePerShare;
    final totalAmount = shares * unitPrice;
    final newInvId = 'inv-${DateTime.now().millisecondsSinceEpoch}';
    final invNo = 'SJ-LV100-00${_investments.length + 43}';

    final investment = InvestmentModel(
      id: newInvId,
      investmentNo: invNo,
      userId: _currentUser.id,
      projectId: _landVest100.id,
      projectName: _landVest100.name,
      shares: shares,
      unitPrice: unitPrice,
      grossAmount: totalAmount,
      fees: 0.0,
      netAmount: totalAmount,
      status: InvestmentStatus.pending,
      paymentMethod: paymentMethod,
      paymentReference: paymentReference,
      createdAt: DateTime.now(),
    );

    _investments.insert(0, investment);

    // Add transaction ledger entry
    final transaction = TransactionModel(
      id: 'txn-${DateTime.now().millisecondsSinceEpoch}',
      investmentId: newInvId,
      projectId: _landVest100.id,
      projectName: _landVest100.name,
      userId: _currentUser.id,
      type: TransactionType.investment,
      direction: TransactionDirection.debit,
      amount: totalAmount,
      balanceAfter: totalInvested + totalAmount,
      reference: paymentReference,
      paymentMethod: paymentMethod,
      status: TransactionStatus.pending,
      createdAt: DateTime.now(),
      description: 'Subscription for $shares Shares in LandVest 100 (Pending Verification)',
    );
    _transactions.insert(0, transaction);

    // Add notification
    _notifications.insert(
      0,
      NotificationModel(
        id: 'notif-${DateTime.now().millisecondsSinceEpoch}',
        title: 'Investment Request Submitted',
        titleBn: 'বিনিয়োগের আবেদন জমা হয়েছে',
        body: 'Your subscription for $shares shares in LandVest 100 is submitted. Finance team is verifying payment.',
        bodyBn: 'ল্যান্ডভেস্ট ১০০ প্রকল্পে আপনার $shares টি শেয়ারের আবেদন গৃহীত হয়েছে। পেমেন্ট যাচাই প্রক্রিয়াধীন।',
        category: NotificationCategory.investment,
        createdAt: DateTime.now(),
      ),
    );

    // Add audit log
    _auditLogs.insert(
      0,
      AuditLogModel(
        id: 'aud-${DateTime.now().millisecondsSinceEpoch}',
        actorName: _currentUser.name,
        actorRole: 'Investor',
        action: 'SUBMIT_INVESTMENT',
        actionBn: 'বিনিয়োগ আবেদন দাখিল',
        entityType: 'Investment',
        entityId: invNo,
        details: 'Submitted investment for $shares shares ($totalAmount BDT) via $paymentMethod',
        detailsBn: '$paymentMethod মাধ্যমে $sharesটি শেয়ারের (৳$totalAmount) বিনিয়োগ আবেদন দাখিলকৃত',
        ipAddress: '103.145.118.99',
        timestamp: DateTime.now(),
      ),
    );

    notifyListeners();
    return true;
  }

  // Admin: Verify Payment & Allocate Shares Atomically
  void adminVerifyAndAllocateShare(String investmentId) {
    final index = _investments.indexWhere((i) => i.id == investmentId);
    if (index == -1) return;

    final inv = _investments[index];
    if (inv.status != InvestmentStatus.pending &&
        inv.status != InvestmentStatus.pendingPaymentVerification) {
      return;
    }

    final currentAllocated = _landVest100.allocatedShares;
    final newAllocated = currentAllocated + inv.shares;
    final List<String> lotNumbers = [];
    for (int i = 1; i <= inv.shares; i++) {
      lotNumbers.add('LOT-${(currentAllocated + i).toString().padLeft(3, '0')}');
    }

    _landVest100 = _landVest100.copyWith(allocatedShares: newAllocated);
    _investments[index] = inv.copyWith(
      status: InvestmentStatus.allocated,
      allocatedLotNumbers: lotNumbers,
      verifiedAt: DateTime.now(),
    );

    // Update matching transaction
    final txnIndex = _transactions.indexWhere((t) => t.investmentId == investmentId);
    if (txnIndex != -1) {
      final oldTxn = _transactions[txnIndex];
      _transactions[txnIndex] = TransactionModel(
        id: oldTxn.id,
        investmentId: oldTxn.investmentId,
        projectId: oldTxn.projectId,
        projectName: oldTxn.projectName,
        userId: oldTxn.userId,
        type: oldTxn.type,
        direction: oldTxn.direction,
        amount: oldTxn.amount,
        balanceAfter: oldTxn.balanceAfter,
        reference: oldTxn.reference,
        paymentMethod: oldTxn.paymentMethod,
        status: TransactionStatus.completed,
        createdAt: oldTxn.createdAt,
        description: 'Verified & Allocated: ${lotNumbers.join(', ')}',
      );
    }

    // Add Share certificate to documents
    _documents.insert(
      0,
      DocumentModel(
        id: 'doc-${DateTime.now().millisecondsSinceEpoch}',
        projectId: _landVest100.id,
        projectName: _landVest100.name,
        userId: inv.userId,
        category: DocumentCategory.receipt,
        title: 'Share Allocation Certificate (${inv.shares} Shares)',
        titleBn: 'শেয়ার বরাদ্দ সনদপত্র (${inv.shares}টি শেয়ার)',
        fileName: 'Share_Certificate_${inv.investmentNo}.pdf',
        fileSize: '1.2 MB',
        version: 'v1.0 (Digitally Signed)',
        visibility: DocumentVisibility.investorOnly,
        checksumSha256: '7c8d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d',
        uploadedAt: DateTime.now(),
        uploadedBy: 'Automated Registry Service',
      ),
    );

    // Add notification
    _notifications.insert(
      0,
      NotificationModel(
        id: 'notif-${DateTime.now().millisecondsSinceEpoch}',
        title: 'Share Allocation Confirmed!',
        titleBn: 'শেয়ার বরাদ্দ নিশ্চিত হয়েছে!',
        body: 'Your payment was verified. Allocated lots: ${lotNumbers.join(', ')} in LandVest 100.',
        bodyBn: 'আপনার পেমেন্ট সফলভাবে যাচাই হয়েছে। ল্যান্ডভেস্ট ১০০ প্রকল্পে বরাদ্দকৃত লট: ${lotNumbers.join(', ')}।',
        category: NotificationCategory.investment,
        createdAt: DateTime.now(),
      ),
    );

    // Add Audit
    _auditLogs.insert(
      0,
      AuditLogModel(
        id: 'aud-${DateTime.now().millisecondsSinceEpoch}',
        actorName: _adminUser.name,
        actorRole: 'Admin',
        action: 'ALLOCATE_SHARES',
        actionBn: 'শেয়ার লট বরাদ্দ',
        entityType: 'Investment',
        entityId: inv.investmentNo,
        details: 'Verified payment and allocated lots ${lotNumbers.join(', ')}',
        detailsBn: 'পেমেন্ট যাচাই সম্পন্ন ও লট ${lotNumbers.join(', ')} সফলভাবে বরাদ্দকৃত',
        ipAddress: '103.145.118.22',
        timestamp: DateTime.now(),
      ),
    );

    notifyListeners();
  }

  // Admin: Add Expense Voucher
  void adminAddExpense({
    required String category,
    required String description,
    required String payee,
    required double amount,
  }) {
    final expId = 'exp-${DateTime.now().millisecondsSinceEpoch}';
    final voucherNo = 'VCH-LV100-0${_expenses.length + 1}';
    final expense = ExpenseModel(
      id: expId,
      projectId: _landVest100.id,
      projectName: _landVest100.name,
      category: category,
      description: description,
      payee: payee,
      amount: amount,
      expenseDate: DateTime.now(),
      status: ExpenseStatus.approved,
      approvedBy: '${_adminUser.name} (Finance Manager)',
      voucherNo: voucherNo,
      documentRef: 'VOUCHER-$voucherNo.pdf',
    );
    _expenses.insert(0, expense);

    // Add Audit
    _auditLogs.insert(
      0,
      AuditLogModel(
        id: 'aud-${DateTime.now().millisecondsSinceEpoch}',
        actorName: _adminUser.name,
        actorRole: 'Finance Manager',
        action: 'ADD_EXPENSE_VOUCHER',
        actionBn: 'ব্যয় ভাউচার এন্ট্রি',
        entityType: 'Expense',
        entityId: voucherNo,
        details: 'Approved expense ৳$amount for $payee ($category)',
        detailsBn: '$payee ($category) এর অনুকূলে ৳$amount অনুমোদিত ব্যয় ভাউচার দাখিল',
        ipAddress: '103.145.118.22',
        timestamp: DateTime.now(),
      ),
    );

    notifyListeners();
  }

  // Admin: Process Distribution Payout
  void adminMarkDistributionPaid(String distributionId) {
    final index = _distributions.indexWhere((d) => d.id == distributionId);
    if (index == -1) return;

    final dist = _distributions[index];
    _distributions[index] = dist.copyWith(
      status: DistributionStatus.paid,
      paidAt: DateTime.now(),
      paymentReference: 'PAYOUT-NPSB-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
    );

    // Add credit transaction
    _transactions.insert(
      0,
      TransactionModel(
        id: 'txn-${DateTime.now().millisecondsSinceEpoch}',
        investmentId: dist.investmentId,
        projectId: dist.projectId,
        projectName: dist.projectName,
        userId: dist.userId,
        type: TransactionType.profitDistribution,
        direction: TransactionDirection.credit,
        amount: dist.amount,
        balanceAfter: totalInvested + totalRealizedProfit + dist.amount,
        reference: 'PAYOUT-NPSB-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
        paymentMethod: dist.bankMfsAccount ?? 'Direct Bank Transfer',
        status: TransactionStatus.completed,
        createdAt: DateTime.now(),
        description: 'Profit payout for ${dist.periodName} (${dist.eligibleShares} shares)',
      ),
    );

    notifyListeners();
  }

  // KYC Submission
  void submitKyc({
    required String fullName,
    required String fatherName,
    required String motherName,
    required String nidNumber,
    required String dateOfBirth,
    required String presentAddress,
    required String permanentAddress,
    required String bankName,
    required String bankAccountNumber,
    required String routingNumber,
    required NomineeModel nominee,
  }) {
    _kyc = KycModel(
      id: _kyc.id,
      userId: _currentUser.id,
      fullName: fullName,
      fatherName: fatherName,
      motherName: motherName,
      nidNumber: nidNumber,
      dateOfBirth: dateOfBirth,
      presentAddress: presentAddress,
      permanentAddress: permanentAddress,
      bankName: bankName,
      bankAccountNumber: bankAccountNumber,
      routingNumber: routingNumber,
      nidFrontUrl: 'https://images.unsplash.com/photo-1589829545856-d10d557cf95f?w=600&auto=format&fit=crop&q=80',
      nidBackUrl: 'https://images.unsplash.com/photo-1589829545856-d10d557cf95f?w=600&auto=format&fit=crop&q=80',
      status: KycStatus.underReview,
      submittedAt: DateTime.now(),
      nominee: nominee,
    );

    _notifications.insert(
      0,
      NotificationModel(
        id: 'notif-${DateTime.now().millisecondsSinceEpoch}',
        title: 'KYC Submitted for Review',
        titleBn: 'কেওয়াইসি পর্যালোচনার জন্য জমা হয়েছে',
        body: 'Your identity documents and nominee details are submitted for compliance review.',
        bodyBn: 'আপনার পরিচয়পত্র ও নমিনির তথ্য কমপ্লায়েন্স যাচাইয়ের জন্য জমা হয়েছে।',
        category: NotificationCategory.security,
        createdAt: DateTime.now(),
      ),
    );

    notifyListeners();
  }

  // Admin: Approve KYC
  void adminApproveKyc() {
    _kyc = _kyc.copyWith(
      status: KycStatus.verified,
      verifiedAt: DateTime.now(),
      verifiedBy: '${_adminUser.name} (Compliance Officer)',
    );
    _currentUser = _currentUser.copyWith(isKycVerified: true);

    _notifications.insert(
      0,
      NotificationModel(
        id: 'notif-${DateTime.now().millisecondsSinceEpoch}',
        title: 'KYC Verified Successfully',
        titleBn: 'কেওয়াইসি সফলভাবে অনুমোদিত হয়েছে',
        body: 'Your investor account is fully verified for all LandVest investments and payouts.',
        bodyBn: 'আপনার বিনিয়োগকারী অ্যাকাউন্ট সকল ল্যান্ডভেস্ট প্রকল্পের জন্য সম্পূর্ণ অনুমোদিত।',
        category: NotificationCategory.security,
        createdAt: DateTime.now(),
      ),
    );

    notifyListeners();
  }

  void markNotificationAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
      notifyListeners();
    }
  }

  void markAllNotificationsAsRead() {
    for (int i = 0; i < _notifications.length; i++) {
      _notifications[i] = _notifications[i].copyWith(isRead: true);
    }
    notifyListeners();
  }

  // Direct investment submission helper
  void submitInvestment(InvestmentModel investment, [TransactionModel? txn]) {
    _investments.insert(0, investment);
    if (txn != null) {
      _transactions.insert(0, txn);
    }
    notifyListeners();
  }
}

class AppStateScope extends InheritedNotifier<AppState> {
  const AppStateScope({
    super.key,
    required AppState super.notifier,
    required super.child,
  });

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppStateScope>();
    return scope?.notifier ?? AppState();
  }
}
