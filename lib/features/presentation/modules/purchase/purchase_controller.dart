import 'package:flutter_zalopay_sdk/flutter_zalopay_sdk.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/core/resources/data_state.dart';
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
      String packageId, int numOfMonth) async {
    final result = await getOrderMembershipPackageUseCase(
        params: {'package_id': packageId, 'num_of_month': numOfMonth});
    if (result is DataSuccess) {
      return result.data!;
    } else {
      return null;
    }
  }

  Future<CreateOrderResult> createOrder(
      String packageId, int numOfMonth) async {
    final result = await _createOrder(packageId, numOfMonth);
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
}
