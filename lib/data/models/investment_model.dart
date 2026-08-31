enum InvestmentStatus { pending, pendingPaymentVerification, verified, allocated, cancelled, refunded }

class InvestmentModel {
  final String id;
  final String investmentNo;
  final String userId;
  final String projectId;
  final String projectName;
  final int shares;
  final double unitPrice;
  final double grossAmount;
  final double fees;
  final double netAmount;
  final InvestmentStatus status;
  final List<String> allocatedLotNumbers;
  final String? paymentMethod;
  final String? paymentReference;
  final DateTime createdAt;
  final DateTime? verifiedAt;

  const InvestmentModel({
    required this.id,
    this.investmentNo = 'INV-2026-001',
    String? userId,
    String? investorId,
    String? projectId,
    String? projectName,
    String? projectTitle,
    String? projectTitleBn,
    String? investorName,
    int? shares,
    int? sharesCount,
    double? unitPrice,
    double? pricePerShare,
    double? grossAmount,
    double? totalAmount,
    this.fees = 0.0,
    double? netAmount,
    this.status = InvestmentStatus.pending,
    List<String>? allocatedLotNumbers,
    List<String>? assignedLots,
    this.paymentMethod,
    String? paymentReference,
    String? transactionRef,
    required this.createdAt,
    this.verifiedAt,
    DateTime? updatedAt,
  })  : userId = userId ?? investorId ?? 'usr-001',
        projectId = projectId ?? 'lv-100',
        projectName = projectName ?? projectTitle ?? 'LandVest 100',
        shares = sharesCount ?? shares ?? 1,
        unitPrice = pricePerShare ?? unitPrice ?? 25500.0,
        grossAmount = totalAmount ?? grossAmount ?? 25500.0,
        netAmount = netAmount ?? totalAmount ?? grossAmount ?? 25500.0,
        allocatedLotNumbers = assignedLots ?? allocatedLotNumbers ?? const [],
        paymentReference = transactionRef ?? paymentReference;

  // Convenience getters
  String get projectTitle => projectName;
  String get projectTitleBn => projectName;
  String get investorId => userId;
  int get sharesCount => shares;
  double get pricePerShare => unitPrice;
  double get totalAmount => grossAmount;
  List<String> get assignedLots => allocatedLotNumbers;
  String? get transactionRef => paymentReference;

  InvestmentModel copyWith({
    InvestmentStatus? status,
    List<String>? allocatedLotNumbers,
    DateTime? verifiedAt,
    String? paymentReference,
  }) {
    return InvestmentModel(
      id: id,
      investmentNo: investmentNo,
      userId: userId,
      projectId: projectId,
      projectName: projectName,
      shares: shares,
      unitPrice: unitPrice,
      grossAmount: grossAmount,
      fees: fees,
      netAmount: netAmount,
      status: status ?? this.status,
      allocatedLotNumbers: allocatedLotNumbers ?? this.allocatedLotNumbers,
      paymentMethod: paymentMethod,
      paymentReference: paymentReference ?? this.paymentReference,
      createdAt: createdAt,
      verifiedAt: verifiedAt ?? this.verifiedAt,
    );
  }
}
