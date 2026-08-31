enum UserRole { investor, admin, financeManager, complianceOfficer }

class UserModel {
  final String id;
  final String name;
  final String phone;
  final String email;
  final UserRole role;
  final String avatarUrl;
  final bool isKycVerified;
  final DateTime memberSince;

  const UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.role,
    required this.avatarUrl,
    required this.isKycVerified,
    required this.memberSince,
  });

  UserModel copyWith({
    String? name,
    String? phone,
    String? email,
    UserRole? role,
    bool? isKycVerified,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      role: role ?? this.role,
      avatarUrl: avatarUrl,
      isKycVerified: isKycVerified ?? this.isKycVerified,
      memberSince: memberSince,
    );
  }
}
