import 'package:equatable/equatable.dart';
import 'package:nhagiare_mobile/features/domain/entities/purchase/membership_package.dart';

class Subscription extends Equatable {
  final String id;
  final String userId;
  final String packageId;
  final String? transactionId;
  final DateTime startingDate;
  final DateTime expirationDate;
  final bool isActive;
  final MembershipPackageEntity? package;

  const Subscription({
    required this.id,
    required this.userId,
    required this.packageId,
    required this.transactionId,
    required this.startingDate,
    required this.expirationDate,
    required this.isActive,
    this.package,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        packageId,
        transactionId,
        startingDate,
        expirationDate,
        isActive,
      ];
}
