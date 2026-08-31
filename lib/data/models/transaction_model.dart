enum TransactionType { investment, profitDistribution, refund, fee, withdrawal }
enum TransactionDirection { debit, credit }
enum TransactionStatus { pending, completed, failed, reversed }

class TransactionModel {
  final String id;
  final String? investmentId;
  final String? projectId;
  final String projectName;
  final String userId;
  final TransactionType type;
  final TransactionDirection direction;
  final double amount;
  final double balanceAfter;
  final String reference;
  final String paymentMethod;
  final TransactionStatus status;
  final DateTime createdAt;
  final String description;

  const TransactionModel({
    required this.id,
    this.investmentId,
    this.projectId,
    required this.projectName,
    required this.userId,
    required this.type,
    required this.direction,
    required this.amount,
    required this.balanceAfter,
    required this.reference,
    required this.paymentMethod,
    required this.status,
    required this.createdAt,
    required this.description,
  });
}
