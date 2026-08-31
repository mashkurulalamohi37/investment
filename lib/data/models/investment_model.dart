enum InvestmentStatus { pending, verified, allocated, cancelled, refunded }

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
    required this.investmentNo,
    required this.userId,
    required this.projectId,
    required this.projectName,
    required this.shares,
    required this.unitPrice,
    required this.grossAmount,
    this.fees = 0.0,
    required this.netAmount,
    required this.status,
    this.allocatedLotNumbers = const [],
    this.paymentMethod,
    this.paymentReference,
    required this.createdAt,
    this.verifiedAt,
  });

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
