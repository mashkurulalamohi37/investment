enum ProfitPeriodStatus { open, reconciling, approved, closed }

class ProfitPeriodModel {
  final String id;
  final String projectId;
  final String projectName;
  final String periodName;
  final DateTime periodStart;
  final DateTime periodEnd;
  final double grossRevenue;
  final double realizedExpense;
  final double realizedProfit;
  final double distributionPool;
  final int eligibleShares;
  final ProfitPeriodStatus status;
  final DateTime createdAt;

  const ProfitPeriodModel({
    required this.id,
    required this.projectId,
    required this.projectName,
    required this.periodName,
    required this.periodStart,
    required this.periodEnd,
    required this.grossRevenue,
    required this.realizedExpense,
    required this.realizedProfit,
    required this.distributionPool,
    required this.eligibleShares,
    required this.status,
    required this.createdAt,
  });

  double get profitPerShare => eligibleShares > 0 ? distributionPool / eligibleShares : 0.0;
}
