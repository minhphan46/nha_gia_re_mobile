import 'package:nhagiare_mobile/features/data/models/purchase/membership_package_model.dart';
import 'package:nhagiare_mobile/features/data/models/purchase/subscription_model.dart';
import 'package:nhagiare_mobile/features/data/models/user/user.dart';
import 'package:nhagiare_mobile/features/domain/entities/purchase/transaction.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel({
    required super.id,
    required super.userId,
    required super.discountId,
    required super.packageId,
    required super.numOfSubscriptionMonth,
    required super.appTransId,
    required super.status,
    required super.timestamp,
    required super.amount,
    required super.platform,
    required super.isActive,
    super.user,
    super.subscription,
    super.package,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      userId: json['user_id'],
      discountId: json['discount_id'],
      packageId: json['package_id'],
      numOfSubscriptionMonth: json['num_of_subscription_month'],
      appTransId: json['app_trans_id'],
      status: json['status'],
      timestamp: DateTime.tryParse(json['timestamp']) ?? DateTime.now(),
      amount: int.tryParse(json['amount']) ?? 0,
      platform: json['platform'] ?? "",
      isActive: json['is_active'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      subscription: json['subscription'] != null
          ? SubscriptionModel.fromJson(json['subscription'])
          : null,
      package: json['package'] != null
          ? MembershipPackageModel.fromJson(json['package'])
          : null,
    );
  }
}
