import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/features/data/models/purchase/membership_package_model.dart';
import 'package:nhagiare_mobile/features/data/models/purchase/order_membership_package_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:nhagiare_mobile/core/constants/constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/resources/pair.dart';
import '../../../../core/utils/typedef.dart';
import '../../models/purchase/discount_code_model.dart';
import '../local/authentication_local_data_source.dart';

abstract class MembershipPackageRemoteDataSrc {
  Future<HttpResponse<List<MembershipPackageModel>>> getAllMembershipPackages();
  Future<HttpResponse<OrderMembershipPackageModel>> createOrder(
      String id, int numOfMonth, String? discountCode);
  Future<HttpResponse<bool>> unsubscribe();
  Future<HttpResponse<Pair<int, List<DiscountCodeModel>>>> getAllDiscountCodes(
      int page, String packageId);
}

class MembershipPackageRemoteDataSrcImpl
    implements MembershipPackageRemoteDataSrc {
  final Dio client;
  AuthenLocalDataSrc localDataSrc;
  MembershipPackageRemoteDataSrcImpl(this.client, this.localDataSrc);

  @override
  Future<HttpResponse<List<MembershipPackageModel>>>
      getAllMembershipPackages() {
    final url = '$apiAppUrl$kGetMembershipPackageEndpoint';

    try {
      return client.get(url, queryParameters: {
        "page": 'all',
        "is_active[eq]": true,
        'orders': '-created_at'
      }).then((response) {
        if (response.statusCode != 200) {
          throw ApiException(
            message: response.data,
            statusCode: response.statusCode!,
          );
        }

        final List<DataMap> taskDataList =
            List<DataMap>.from(response.data["result"]);

        List<MembershipPackageModel> value = taskDataList
            .map((postJson) => MembershipPackageModel.fromJson(postJson))
            .toList();

        return HttpResponse(value, response);
      });
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }

  @override
  Future<HttpResponse<OrderMembershipPackageModel>> createOrder(
      String id, int numOfMonth, String? discountCode) {
    final url = '$apiAppUrl$kCreateOrderEndpoint';
    try {
      return client.post(url, data: {
        "membership_package_id": id,
        "num_of_subscription_month": numOfMonth,
        "user_id": "1a9a5785-721a-4bb5-beb7-9d752e2070d4",
        "discount_code": discountCode
      }).then((response) {
        if (response.statusCode != 200) {
          throw ApiException(
            message: response.data,
            statusCode: response.statusCode!,
          );
        }
        final DataMap taskDataList = DataMap.from(response.data["result"]);

        OrderMembershipPackageModel value =
            OrderMembershipPackageModel.fromJson(taskDataList);

        return HttpResponse(value, response);
      });
    } on ApiException {
      rethrow;
    } catch (e) {
      e.printInfo();
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<HttpResponse<bool>> unsubscribe() {
    final url = '$apiAppUrl$kUnsubscribeEndpoint';

    String? accessToken = localDataSrc.getAccessToken();
    try {
      return client
          .post(url,
              options: Options(headers: {
                "Authorization": "Bearer ${accessToken ?? ""}",
              }))
          .then((response) {
        if (response.statusCode != 200) {
          throw ApiException(
            message: response.data,
            statusCode: response.statusCode!,
          );
        }

        final DataMap res = DataMap.from(response.data);

        // bool value = res["success"];
        bool value =
            bool.tryParse(res['result'].toString() ?? 'false') ?? false;

        return HttpResponse(value, response);
      });
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }

  @override
  Future<HttpResponse<Pair<int, List<DiscountCodeModel>>>> getAllDiscountCodes(
      int page, String packageId) {
    final url = '$apiAppUrl$kGetDiscountCodeEndpoint';
    try {
      return client.get(url, queryParameters: {
        "page": page,
        "package_id[eq]": '\'$packageId\''
      }).then((response) {
        if (response.statusCode != 200) {
          throw ApiException(
            message: response.data,
            statusCode: response.statusCode!,
          );
        }

        final List<DataMap> taskDataList =
            List<DataMap>.from(response.data["result"]);

        List<DiscountCodeModel> value = taskDataList
            .map((postJson) => DiscountCodeModel.fromJson(postJson))
            .toList();

        int totalPage =
            int.tryParse(response.data["num_of_pages"].toString()) ?? 1;

        return HttpResponse(Pair(totalPage, value), response);
      });
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }
}
