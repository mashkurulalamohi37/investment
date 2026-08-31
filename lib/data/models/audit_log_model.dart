class AuditLogModel {
  final String id;
  final String actorName;
  final String actorRole;
  final String action;
  final String entityType;
  final String entityId;
  final String details;
  final String ipAddress;
  final DateTime timestamp;

  const AuditLogModel({
    required this.id,
    required this.actorName,
    required this.actorRole,
    required this.action,
    required this.entityType,
    required this.entityId,
    required this.details,
    required this.ipAddress,
    required this.timestamp,
  });
}
