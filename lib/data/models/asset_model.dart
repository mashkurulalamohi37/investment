enum AssetStatus { acquired, developing, active, liquidated }

class AssetModel {
  final String id;
  final String projectId;
  final String projectName;
  final String assetType;
  final String title;
  final String titleBn;
  final String description;
  final String location;
  final double purchaseValue;
  final double currentValue;
  final String ownershipReference;
  final String deedNumber;
  final String mutationKhatian;
  final double landAreaDecimals;
  final AssetStatus status;
  final DateTime acquisitionDate;
  final List<String> photos;
  final String? legalVerificationOfficer;

  const AssetModel({
    required this.id,
    required this.projectId,
    required this.projectName,
    required this.assetType,
    required this.title,
    required this.titleBn,
    required this.description,
    required this.location,
    required this.purchaseValue,
    required this.currentValue,
    required this.ownershipReference,
    required this.deedNumber,
    required this.mutationKhatian,
    required this.landAreaDecimals,
    required this.status,
    required this.acquisitionDate,
    required this.photos,
    this.legalVerificationOfficer,
  });
}
