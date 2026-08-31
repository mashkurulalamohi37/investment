enum KycStatus { notStarted, pending, underReview, verified, rejected }

class NomineeModel {
  final String name;
  final String relationship;
  final String phone;
  final String nidNumber;
  final double percentage;

  const NomineeModel({
    required this.name,
    required this.relationship,
    required this.phone,
    required this.nidNumber,
    this.percentage = 100.0,
  });
}

class KycModel {
  final String id;
  final String userId;
  final String fullName;
  final String fatherName;
  final String motherName;
  final String nidNumber;
  final String dateOfBirth;
  final String presentAddress;
  final String permanentAddress;
  final String bankName;
  final String bankAccountNumber;
  final String routingNumber;
  final String? nidFrontUrl;
  final String? nidBackUrl;
  final KycStatus status;
  final DateTime? submittedAt;
  final DateTime? verifiedAt;
  final String? verifiedBy;
  final String? rejectionReason;
  final NomineeModel? nominee;

  const KycModel({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.fatherName,
    required this.motherName,
    required this.nidNumber,
    required this.dateOfBirth,
    required this.presentAddress,
    required this.permanentAddress,
    required this.bankName,
    required this.bankAccountNumber,
    required this.routingNumber,
    this.nidFrontUrl,
    this.nidBackUrl,
    required this.status,
    this.submittedAt,
    this.verifiedAt,
    this.verifiedBy,
    this.rejectionReason,
    this.nominee,
  });

  KycModel copyWith({
    KycStatus? status,
    DateTime? verifiedAt,
    String? verifiedBy,
    String? rejectionReason,
    NomineeModel? nominee,
  }) {
    return KycModel(
      id: id,
      userId: userId,
      fullName: fullName,
      fatherName: fatherName,
      motherName: motherName,
      nidNumber: nidNumber,
      dateOfBirth: dateOfBirth,
      presentAddress: presentAddress,
      permanentAddress: permanentAddress,
      bankName: bankName,
      bankAccountNumber: bankAccountNumber,
      routingNumber: routingNumber,
      nidFrontUrl: nidFrontUrl,
      nidBackUrl: nidBackUrl,
      status: status ?? this.status,
      submittedAt: submittedAt,
      verifiedAt: verifiedAt ?? this.verifiedAt,
      verifiedBy: verifiedBy ?? this.verifiedBy,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      nominee: nominee ?? this.nominee,
    );
  }
}
