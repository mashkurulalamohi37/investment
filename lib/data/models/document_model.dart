enum DocumentCategory {
  legal,
  projectDeed,
  govtApproval,
  receipt,
  taxCertificate,
  financialAudit,
  distributionStatement,
}

enum DocumentVisibility {
  publicDoc,
  investorOnly,
  adminOnly,
}

class DocumentModel {
  final String id;
  final String? projectId;
  final String? projectName;
  final String? userId;
  final DocumentCategory category;
  final String title;
  final String titleBn;
  final String fileName;
  final String fileSize;
  final String version;
  final DocumentVisibility visibility;
  final String checksumSha256;
  final DateTime uploadedAt;
  final String uploadedBy;

  const DocumentModel({
    required this.id,
    this.projectId,
    this.projectName,
    this.userId,
    required this.category,
    required this.title,
    required this.titleBn,
    required this.fileName,
    required this.fileSize,
    required this.version,
    required this.visibility,
    required this.checksumSha256,
    required this.uploadedAt,
    required this.uploadedBy,
  });
}
