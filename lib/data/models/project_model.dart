enum ProjectStatus { draft, active, funded, completed, closed }

class Milestone {
  final String id;
  final String title;
  final String titleBn;
  final String description;
  final DateTime date;
  final bool isCompleted;
  final String? documentRef;

  const Milestone({
    required this.id,
    required this.title,
    required this.titleBn,
    required this.description,
    required this.date,
    required this.isCompleted,
    this.documentRef,
  });
}

class ProjectModel {
  final String id;
  final String code;
  final String name;
  final String nameBn;
  final String category;
  final String location;
  final String description;
  final String descriptionBn;
  final double targetFund;
  final int totalShares;
  final double pricePerShare;
  final int minShares;
  final int maxShares;
  final int allocatedShares;
  final ProjectStatus status;
  final DateTime startDate;
  final DateTime? targetEndDate;
  final List<Milestone> milestones;
  final List<String> highlights;
  final String imageUrl;

  const ProjectModel({
    required this.id,
    required this.code,
    required this.name,
    required this.nameBn,
    required this.category,
    required this.location,
    required this.description,
    required this.descriptionBn,
    required this.targetFund,
    required this.totalShares,
    required this.pricePerShare,
    this.minShares = 1,
    this.maxShares = 4,
    required this.allocatedShares,
    required this.status,
    required this.startDate,
    this.targetEndDate,
    this.milestones = const [],
    this.highlights = const [],
    required this.imageUrl,
  });

  // Convenience getters
  String get title => name;
  String get titleBn => nameBn;
  String get locationBn => location;
  double get fundingProgress => totalShares > 0 ? allocatedShares / totalShares : 0.0;
  double get collectedFund => allocatedShares * pricePerShare;
  double get remainingFund => targetFund - collectedFund;
  int get availableShares => totalShares - allocatedShares;

  ProjectModel copyWith({
    int? allocatedShares,
    ProjectStatus? status,
    DateTime? targetEndDate,
  }) {
    return ProjectModel(
      id: id,
      code: code,
      name: name,
      nameBn: nameBn,
      category: category,
      location: location,
      description: description,
      descriptionBn: descriptionBn,
      targetFund: targetFund,
      totalShares: totalShares,
      pricePerShare: pricePerShare,
      minShares: minShares,
      maxShares: maxShares,
      allocatedShares: allocatedShares ?? this.allocatedShares,
      status: status ?? this.status,
      startDate: startDate,
      targetEndDate: targetEndDate ?? this.targetEndDate,
      milestones: milestones,
      highlights: highlights,
      imageUrl: imageUrl,
    );
  }
}
