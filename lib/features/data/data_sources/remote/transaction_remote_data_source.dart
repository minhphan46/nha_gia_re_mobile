import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/features/data/data_sources/local/authentication_local_data_source.dart';
import 'package:nhagiare_mobile/features/data/models/purchase/subscription_model.dart';
import 'package:nhagiare_mobile/features/data/models/purchase/transaction_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:nhagiare_mobile/core/constants/constants.dart';
import '../../../../core/errors/exceptions.dart';

abstract class TransactionRemoteDataSrc {
  Future<HttpResponse<TransactionModel>> getTransactionByAppTransId(String id);
  Future<HttpResponse<List<TransactionModel>>> getAllTransactions();
  Future<HttpResponse<SubscriptionModel?>> getCurrentSubscription();
}

class TransactionRemoteDataSrcImpl extends TransactionRemoteDataSrc {
  AuthenLocalDataSrc _authenLocalDataSrc;
  final Dio client;
  TransactionRemoteDataSrcImpl(this.client, this._authenLocalDataSrc);

  String get accessToken => _authenLocalDataSrc.getAccessToken() ?? '';

  @override
  Future<HttpResponse<TransactionModel>> getTransactionByAppTransId(String id) {
    String url = '$apiAppUrl$kGetTransactionEndpoint?app_trans_id[eq]=\'$id\'';
    try {
      return client
          .get(url,
              options: Options(
                headers: {
                  'Authorization': 'Bearer $accessToken',
                },
              ))
          .then((response) {
        if (response.statusCode != 200) {
          throw ApiException(
            message: response.data,
            statusCode: response.statusCode!,
          );
        }

        final List<dynamic> taskDataList = response.data['result'];
        List<TransactionModel> value = taskDataList
            .map((dynamic item) => TransactionModel.fromJson(item))
            .toList();
        if (value.isEmpty) {
          throw const ApiException(
            message: "No data found",
            statusCode: 404,
          );
        } else {
          return HttpResponse(value[0], response);
        }
      });
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }

  @override
  Future<HttpResponse<List<TransactionModel>>> getAllTransactions() async {
    String url = '$apiAppUrl$kGetTransactionEndpoint';
    try {
      final httpResponse = await client.get(url,
          options: Options(
            headers: {
              'Authorization': 'Bearer $accessToken',
            },
          ),
          queryParameters: {
            'orders': '-timestamp',
            'status[eq]': '\'paid\'',
            'page': 'all',
          });
      if (httpResponse.statusCode != 200) {
        throw ApiException(
          message: httpResponse.data,
          statusCode: httpResponse.statusCode!,
        );
      }

      final List<dynamic> taskDataList = httpResponse.data['result'];
      List<TransactionModel> value = taskDataList
          .map((dynamic item) => TransactionModel.fromJson(item))
          .toList();
      return HttpResponse(value, httpResponse);
    } on ApiException catch (e) {
      printError(info: e.toString());
      rethrow;
    } catch (error) {
      print(error.toString());
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }

  @override
  Future<HttpResponse<SubscriptionModel?>> getCurrentSubscription() async {
    String url = '$apiAppUrl$kGetCurrentSubscriptionEndpoint';

    try {
      final httpResponse = await client.get(url,
          options: Options(headers: {
            'Authorization': 'Bearer $accessToken',
          }));
      if (httpResponse.statusCode != 200) {
        throw ApiException(
          message: httpResponse.data,
          statusCode: httpResponse.statusCode!,
        );
      }

      SubscriptionModel? value;
      try {
        value = httpResponse.data['result'] != null
            ? SubscriptionModel.fromJson(httpResponse.data['result'])
            : null;
      } catch (e) {
        print(e);
        value = null;
      }
      return HttpResponse(value, httpResponse);
    } on ApiException catch (e) {
      printError(info: e.toString());
      rethrow;
    } catch (error) {
      print(error.toString());
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }
}
