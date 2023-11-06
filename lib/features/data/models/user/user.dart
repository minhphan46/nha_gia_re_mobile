import 'package:nhagiare_mobile/features/data/models/post/address.dart';

import '../../../domain/entities/user/user.dart';

class UserModel extends UserEntity {
  const UserModel({
    String? id,
    String? status,
    bool? isIdentityVerified,
    String? role,
    String? email,
    String? password,
    AddressModel? address,
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
  }) : super(
          id: id,
          status: status,
          isIdentityVerified: isIdentityVerified,
          role: role,
          email: email,
          password: password,
          address: address,
          firstName: firstName,
          lastName: lastName,
          gender: gender,
          avatar: avatar,
          dob: dob,
          phone: phone,
          banReason: banReason,
          isActive: isActive,
          lastActiveAt: lastActiveAt,
          createdAt: createdAt,
          updatedAt: updatedAt,
          bannedUtil: bannedUtil,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      status: json['status'],
      isIdentityVerified: json['is_identity_verified'],
      role: json['role'],
      email: json['email'],
      password: json['password'],
      address: AddressModel.fromJson(json['address']),
      firstName: json['first_name'],
      lastName: json['last_name'],
      gender: json['gender'],
      avatar: json['avatar'],
      dob: DateTime.parse(json['dob']),
      phone: json['phone'],
      banReason: json['ban_reason'],
      isActive: json['is_active'],
      lastActiveAt: DateTime.parse(json['last_active_at']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      bannedUtil: DateTime.tryParse(json['banned_util'] ?? ""),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'is_identity_verified': isIdentityVerified,
      'role': role,
      'email': email,
      'password': password,
      'address': address,
      'first_name': firstName,
      'last_name': lastName,
      'gender': gender,
      'avatar': avatar,
      'dob': dob!.toIso8601String(),
      'phone': phone,
      'ban_reason': banReason,
      'is_active': isActive,
      'last_active_at': lastActiveAt!.toIso8601String(),
      'created_at': createdAt!.toIso8601String(),
      'updated_at': updatedAt!.toIso8601String(),
      'banned_util': bannedUtil!.toIso8601String(),
    };
  }
}
