class AuditLogModel {
  final String id;
  final String actorName;
  final String actorRole;
  final String action;
  final String? actionBn;
  final String entityType;
  final String entityId;
  final String details;
  final String? detailsBn;
  final String ipAddress;
  final DateTime timestamp;

  const AuditLogModel({
    required this.id,
    required this.actorName,
    required this.actorRole,
    required this.action,
    this.actionBn,
    required this.entityType,
    required this.entityId,
    required this.details,
    this.detailsBn,
    required this.ipAddress,
    required this.timestamp,
  });

  String getAction(bool isBangla) => (isBangla && actionBn != null) ? actionBn! : action;
  String getDetails(bool isBangla) => (isBangla && detailsBn != null) ? detailsBn! : details;
}
