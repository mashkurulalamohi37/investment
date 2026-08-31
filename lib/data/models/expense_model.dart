enum ExpenseStatus { pending, approved, rejected, reversed }

class ExpenseModel {
  final String id;
  final String projectId;
  final String projectName;
  final String category;
  final String description;
  final String? _descriptionBn;
  final String payee;
  final double amount;
  final DateTime expenseDate;
  final ExpenseStatus status;
  final String approvedBy;
  final String? documentRef;
  final String voucherNo;

  const ExpenseModel({
    required this.id,
    required this.projectId,
    required this.projectName,
    required this.category,
    required this.description,
    String? descriptionBn,
    required this.payee,
    required this.amount,
    required this.expenseDate,
    required this.status,
    required this.approvedBy,
    this.documentRef,
    required this.voucherNo,
  }) : _descriptionBn = descriptionBn;

  String get descriptionBn => _descriptionBn ?? description;
  DateTime get incurredAt => expenseDate;

  ExpenseModel copyWith({
    ExpenseStatus? status,
    String? approvedBy,
  }) {
    return ExpenseModel(
      id: id,
      projectId: projectId,
      projectName: projectName,
      category: category,
      description: description,
      descriptionBn: _descriptionBn,
      payee: payee,
      amount: amount,
      expenseDate: expenseDate,
      status: status ?? this.status,
      approvedBy: approvedBy ?? this.approvedBy,
      documentRef: documentRef,
      voucherNo: voucherNo,
    );
  }
}
