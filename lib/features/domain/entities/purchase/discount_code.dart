import 'package:equatable/equatable.dart';

class DiscountCodeEntity extends Equatable {
  final String id;
  final String packageId;
  final String code;
  final double discountPercent;
  final String startingDate;
  final String expirationDate;
  final String description;
  final DateTime createdAt;
  final int limitedQuantity;
  final int minSubscriptionMonths;
  final bool isActive;

  const DiscountCodeEntity({
    required this.id,
    required this.packageId,
    required this.code,
    required this.discountPercent,
    required this.startingDate,
    required this.expirationDate,
    required this.description,
    required this.createdAt,
    required this.limitedQuantity,
    required this.minSubscriptionMonths,
    required this.isActive,
  });

  @override
  List<Object?> get props => [
        id,
        packageId,
        code,
        discountPercent,
        startingDate,
        expirationDate,
        description,
        createdAt,
        limitedQuantity,
        minSubscriptionMonths,
        isActive,
      ];
}
