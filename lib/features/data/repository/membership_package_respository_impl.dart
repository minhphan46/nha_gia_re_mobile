import 'package:get/get.dart';
import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/resources/pair.dart';
import 'package:nhagiare_mobile/features/data/data_sources/remote/membership_package_data_source.dart';
import 'package:nhagiare_mobile/features/data/models/purchase/order_membership_package_model.dart';
import 'package:nhagiare_mobile/features/domain/entities/purchase/discount_code.dart';
import 'package:nhagiare_mobile/features/domain/entities/purchase/membership_package.dart';
import 'package:nhagiare_mobile/features/domain/repository/membership_package_repository.dart';
import 'dart:io';

import 'package:dio/dio.dart';

class MembershipPackageRepositoryImpl extends MembershipPackageRepository {
  MembershipPackageRemoteDataSrc remoteDataSrc;

  MembershipPackageRepositoryImpl(this.remoteDataSrc);
  @override
  Future<DataState<List<MembershipPackageEntity>>>
      getMembershipPackages() async {
    try {
      final httpResponse = await remoteDataSrc.getAllMembershipPackages();

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<OrderMembershipPackageModel>> createOrder(
      String packageId, int numOfMonth, String? discountCode) async {
    try {
      final httpResponse =
          await remoteDataSrc.createOrder(packageId, numOfMonth, discountCode);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      e.printError();
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<bool>> unsubscribe() {
    try {
      return remoteDataSrc.unsubscribe().then((httpResponse) {
        if (httpResponse.response.statusCode == HttpStatus.ok) {
          return DataSuccess(httpResponse.data);
        } else {
          return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ));
        }
      });
    } on DioException catch (e) {
      return Future(() => DataFailed(e));
    }
  }

  @override
  Future<DataState<Pair<int, List<DiscountCodeEntity>>>> getAllDiscountCodes(
      int page, String packageId) {
    try {
      return remoteDataSrc
          .getAllDiscountCodes(page, packageId)
          .then((httpResponse) {
        if (httpResponse.response.statusCode == HttpStatus.ok) {
          return DataSuccess(httpResponse.data);
        } else {
          return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ));
        }
      });
    } on DioException catch (e) {
      return Future(() => DataFailed(e));
    }
  }
}
