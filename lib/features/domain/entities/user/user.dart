import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String? status;
  final bool? isIdentityVerified;
  final String? role;
  final String? email;
  final String? password;
  final String? address;
  final String? firstName;
  final String? lastName;
  final bool? gender;
  final String? avatar;
  final DateTime? dob;
  final String? phone;
  final String? banReason;
  final bool? isActive;
  final DateTime? lastActiveAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? bannedUtil;

  const UserEntity({
    this.id,
    this.status,
    this.isIdentityVerified,
    this.role,
    this.email,
    this.password,
    this.address,
    this.firstName,
    this.lastName,
    this.gender,
    this.avatar,
    this.dob,
    this.phone,
    this.banReason,
    this.isActive,
    this.lastActiveAt,
    this.createdAt,
    this.updatedAt,
    this.bannedUtil,
  });

  @override
  List<Object?> get props => [id];

  UserEntity copyWith({
    String? uuid,
    String? status,
    bool? isIdentityVerified,
    String? role,
    String? email,
    String? password,
    String? address,
    String? firstName,
    String? lastName,
    bool? gender,
    String? avatar,
    DateTime? dob,
    String? phone,
    String? banReason,
    bool? isActive,
    DateTime? lastActiveAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? bannedUtil,
  }) {
    return UserEntity(
      id: uuid ?? id,
      status: status ?? this.status,
      isIdentityVerified: isIdentityVerified ?? this.isIdentityVerified,
      role: role ?? this.role,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      avatar: avatar ?? this.avatar,
      dob: dob ?? this.dob,
      phone: phone ?? this.phone,
      banReason: banReason ?? this.banReason,
      isActive: isActive ?? this.isActive,
      lastActiveAt: lastActiveAt ?? this.lastActiveAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      bannedUtil: bannedUtil ?? this.bannedUtil,
    );
  }
}
