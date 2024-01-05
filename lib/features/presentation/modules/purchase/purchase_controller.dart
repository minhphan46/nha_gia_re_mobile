import 'package:flutter_zalopay_sdk/flutter_zalopay_sdk.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/resources/pair.dart';
import 'package:nhagiare_mobile/features/domain/entities/purchase/membership_package.dart';
import 'package:nhagiare_mobile/features/domain/entities/purchase/order_membership_package.dart';
import 'package:nhagiare_mobile/features/domain/entities/purchase/subscription.dart';
import 'package:nhagiare_mobile/features/domain/entities/purchase/transaction.dart';
import 'package:nhagiare_mobile/features/domain/usecases/purchase/get_all_transactions.dart';
import 'package:nhagiare_mobile/features/domain/usecases/purchase/get_current_subscription.dart';
import 'package:nhagiare_mobile/features/domain/usecases/purchase/get_membership_package.dart';
import 'package:nhagiare_mobile/features/domain/usecases/purchase/get_order.dart';
import 'package:nhagiare_mobile/features/domain/usecases/purchase/get_transaction.dart';
import 'package:nhagiare_mobile/injection_container.dart';

import '../../../domain/entities/purchase/discount_code.dart';
import '../../../domain/usecases/purchase/get_discount_codes_usercase.dart';
import '../../../domain/usecases/purchase/unsubcribe.dart';

class CreateOrderResult {
  final String? appTransId;
  final bool isCreateSuccess;
  final FlutterZaloPayStatus? payResult;
  final String? message;
  CreateOrderResult(
      {required this.isCreateSuccess,
      this.appTransId,
      this.payResult,
      this.message});
}

// All membership package, current subscription, transaction
class PurchaseState {
  final List<MembershipPackageEntity> membershipPackages;
  final List<TransactionEntity> transactions;
  final Subscription? currentSubscription;
  PurchaseState({
    required this.membershipPackages,
    required this.transactions,
    required this.currentSubscription,
  });
}

class PurchaseController extends GetxController {
  final getMembershipPackageUseCase = sl<GetMembershipPackageUseCase>();
  final getTransactionUseCase = sl<GetTransactionUseCase>();
  final GetOrderMembershipPackageUseCase getOrderMembershipPackageUseCase =
      sl<GetOrderMembershipPackageUseCase>();
  final GetAllTransactionUseCase getAllTransactionUseCase =
      sl<GetAllTransactionUseCase>();

  final GetCurrentSubscriptionUseCase getCurrentSubscriptionUseCase =
      sl<GetCurrentSubscriptionUseCase>();

  Future<List<MembershipPackageEntity>> getMembershipPackages() async {
    final result = await getMembershipPackageUseCase();
    if (result is DataSuccess) {
      return result.data!;
    } else {
      return [];
    }
  }

  Future<TransactionEntity?> getTransaction(String id) async {
    final result = await getTransactionUseCase(params: id);
    if (result is DataSuccess) {
      return result.data!;
    } else {
      return null;
    }
  }

  Future<OrderMembershipPackage?> _createOrder(
      String packageId, int numOfMonth, String? discountCode) async {
    print('create order');
    print(packageId);
    print(numOfMonth);
    print(discountCode);
    // return null;
    final result = await getOrderMembershipPackageUseCase(params: {
      'package_id': packageId,
      'num_of_month': numOfMonth,
      'discount_code': discountCode
    });
    if (result is DataSuccess) {
      return result.data!;
    } else {
      return null;
    }
  }

  Future<CreateOrderResult> createOrder(
      String packageId, int numOfMonth, String? discountCode) async {
    final result = await _createOrder(packageId, numOfMonth, discountCode);
    await Future.delayed(const Duration(seconds: 1));
    if (result != null) {
      FlutterZaloPayStatus payResult =
          await FlutterZaloPaySdk.payOrder(zpToken: result.zpTransToken);
      if (payResult == FlutterZaloPayStatus.success) {
        return CreateOrderResult(
          isCreateSuccess: true,
          payResult: payResult,
          appTransId: result.appTransId,
        );
      } else {
        return CreateOrderResult(
            appTransId: result.appTransId,
            isCreateSuccess: false,
            payResult: FlutterZaloPayStatus.failed,
            message: 'Thanh toán thất bại');
      }
    } else {
      return CreateOrderResult(
          isCreateSuccess: false, message: 'Tạo đơn hàng thất bại');
    }
  }

  Future<List<TransactionEntity>> getAllTransactions() async {
    final result = await getAllTransactionUseCase(params: 0);
    if (result is DataSuccess) {
      return result.data!;
    } else {
      return [];
    }
  }

  Future<Subscription?> getCurrentSubscription() async {
    final result = await getCurrentSubscriptionUseCase.call();
    return result;
  }

  final unsubscribeUseCase = sl<UnsubscribeUseCase>();
  Future<bool> unsubscribe() async {
    return await unsubscribeUseCase.call();
  }

  Future<PurchaseState> getPurchaseState() async {
    final membershipPackages = await getMembershipPackages();
    final transactions = await getAllTransactions();
    final currentSubscription = await getCurrentSubscription();
    return PurchaseState(
        membershipPackages: membershipPackages,
        transactions: transactions,
        currentSubscription: currentSubscription);
  }

  final getDiscountCodeUseCase = sl<GetDiscountCodeUseCase>();
  Future<Pair<int, List<DiscountCodeEntity>>> getAllDiscountCodes(
      int page, String packageId) async {
    final result = await getDiscountCodeUseCase(
        params: GetDiscountCodeUseCaseParams(page, packageId));
    return result;
  }
}
