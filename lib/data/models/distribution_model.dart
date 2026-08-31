enum DistributionStatus { draft, approved, processing, paid, failed }

class DistributionModel {
  final String id;
  final String profitPeriodId;
  final String periodName;
  final String projectId;
  final String projectName;
  final String userId;
  final String investmentId;
  final int eligibleShares;
  final double amount;
  final DistributionStatus status;
  final DateTime? paidAt;
  final String? paymentReference;
  final String? bankMfsAccount;

  const DistributionModel({
    required this.id,
    required this.profitPeriodId,
    required this.periodName,
    required this.projectId,
    required this.projectName,
    required this.userId,
    required this.investmentId,
    required this.eligibleShares,
    required this.amount,
    required this.status,
    this.paidAt,
    this.paymentReference,
    this.bankMfsAccount,
  });

  String get periodNameBn => periodName;
  double get investorAmount => amount;

  DistributionModel copyWith({
    DistributionStatus? status,
    DateTime? paidAt,
    String? paymentReference,
  }) {
    return DistributionModel(
      id: id,
      profitPeriodId: profitPeriodId,
      periodName: periodName,
      projectId: projectId,
      projectName: projectName,
      userId: userId,
      investmentId: investmentId,
      eligibleShares: eligibleShares,
      amount: amount,
      status: status ?? this.status,
      paidAt: paidAt ?? this.paidAt,
      paymentReference: paymentReference ?? this.paymentReference,
      bankMfsAccount: bankMfsAccount,
    );
  }
}
