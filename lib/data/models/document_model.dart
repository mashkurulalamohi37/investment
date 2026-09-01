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
  final String? downloadUrl;
  final String? _description;
  final String? _descriptionBn;

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
    this.downloadUrl,
    String? description,
    String? descriptionBn,
  })  : _description = description,
        _descriptionBn = descriptionBn;

  String get description => _description ?? title;
  String get descriptionBn => _descriptionBn ?? titleBn;
  String get sha256Hash => checksumSha256;
  String get verifiedBy => uploadedBy;
  String get fileType => fileName.contains('.') ? fileName.split('.').last.toUpperCase() : 'PDF';

  String get categoryName {
    switch (category) {
      case DocumentCategory.legal:
        return 'Legal Vetting';
      case DocumentCategory.projectDeed:
        return 'Title Deed';
      case DocumentCategory.govtApproval:
        return 'Govt Approval';
      case DocumentCategory.receipt:
        return 'Voucher Receipt';
      case DocumentCategory.taxCertificate:
        return 'Tax Certificate';
      case DocumentCategory.financialAudit:
        return 'Financial Audit';
      case DocumentCategory.distributionStatement:
        return 'Distribution Statement';
    }
  }

  String get categoryNameBn {
    switch (category) {
      case DocumentCategory.legal:
        return 'আইনি মতামত';
      case DocumentCategory.projectDeed:
        return 'প্রকল্প নিবন্ধন ও চুক্তিপত্র';
      case DocumentCategory.govtApproval:
        return 'সরকারি লাইসেন্স ও অনুমোদন';
      case DocumentCategory.receipt:
        return 'ব্যয় ভাউচার রসিদ';
      case DocumentCategory.taxCertificate:
        return 'প্রকল্প কর ও ক্লিয়ারেন্স সনদ';
      case DocumentCategory.financialAudit:
        return 'চার্টার্ড অ্যাকাউন্ট্যান্ট অডিট';
      case DocumentCategory.distributionStatement:
        return 'মুনাফা বিতরণ বিবরণী';
    }
  }
}
