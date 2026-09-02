enum TransactionType { investment, sharePurchase, profitDistribution, dividend, refund, fee, withdrawal }
enum TransactionDirection { debit, credit }
enum TransactionStatus { pending, completed, failed, reversed, refunded }

class TransactionModel {
  final String id;
  final String? investmentId;
  final String? projectId;
  final String projectName;
  final String projectNameBn;
  final String userId;
  final TransactionType type;
  final TransactionDirection direction;
  final double amount;
  final double balanceAfter;
  final String reference;
  final String? paymentMethod;
  final TransactionStatus status;
  final DateTime createdAt;
  final String description;
  final String? descriptionBn;
  final String? receiptImageUrl;
  final String? depositBankName;
  final String? depositorName;

  const TransactionModel({
    required this.id,
    this.investmentId,
    this.projectId,
    this.projectName = 'LandVest 100',
    this.projectNameBn = 'স্বপ্নযাত্রী ১০০',
    this.userId = 'usr-001',
    required this.type,
    this.direction = TransactionDirection.debit,
    required this.amount,
    this.balanceAfter = 0.0,
    this.reference = 'TRX-DEFAULT',
    this.paymentMethod = 'City Bank PLC',
    this.receiptImageUrl,
    this.depositBankName,
    this.depositorName,
    required this.status,
    required this.createdAt,
    this.description = 'LandVest 100 Transaction',
    this.descriptionBn,
    String? title,
    String? referenceId,
    DateTime? timestamp,
  });

  // Convenience getters
  String get title => description.isNotEmpty ? description : projectName;
  String get titleBn => (descriptionBn != null && descriptionBn!.isNotEmpty)
      ? descriptionBn!
      : (description.isNotEmpty ? description : projectNameBn);
  String get referenceId => reference;
  DateTime get timestamp => createdAt;
}
