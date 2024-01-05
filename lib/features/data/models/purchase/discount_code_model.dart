import 'package:nhagiare_mobile/features/domain/entities/purchase/discount_code.dart';

class DiscountCodeModel extends DiscountCodeEntity {
  DiscountCodeModel({
    required super.id,
    required super.packageId,
    required super.code,
    required super.discountPercent,
    required super.startingDate,
    required super.expirationDate,
    required super.description,
    required super.createdAt,
    required super.limitedQuantity,
    required super.minSubscriptionMonths,
    required super.isActive,
  });

  factory DiscountCodeModel.fromJson(Map<String, dynamic> json) {
    return DiscountCodeModel(
      id: json['id'] ?? "",
      packageId: json['package_id'] ?? "",
      code: json['code'] ?? "",
      discountPercent: json['discount_percent'],
      startingDate: json['starting_date'] ?? "",
      expirationDate: json['expiration_date'] ?? "",
      description: json['description'] ?? "",
      createdAt: DateTime.tryParse(json['created_at']) ?? DateTime.now(),
      limitedQuantity: json['limited_quantity'] ?? 0,
      minSubscriptionMonths: json['min_subscription_months'] ?? 0,
      isActive: json['is_active'] ?? false,
    );
  }
}
