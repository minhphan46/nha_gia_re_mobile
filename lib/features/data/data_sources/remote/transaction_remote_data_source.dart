import 'package:dio/dio.dart';
import 'package:get/get.dart';
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
  String accessToken;
  final Dio client;
  TransactionRemoteDataSrcImpl(this.client, this.accessToken);

  @override
  Future<HttpResponse<TransactionModel>> getTransactionByAppTransId(String id) {
    String url = '$apiUrl$kGetTransactionEndpoint?app_trans_id[eq]=\'$id\'';
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
    String url = '$apiUrl$kGetTransactionEndpoint';
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

      final List<dynamic> taskDataList = httpResponse.data['result'];
      List<TransactionModel> value = taskDataList
          .map((dynamic item) => TransactionModel.fromJson(item))
          .toList();
      if (value.isEmpty) {
        throw const ApiException(
          message: "No data found",
          statusCode: 404,
        );
      } else {
        return HttpResponse(value, httpResponse);
      }
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
    String url = '$apiUrl$kGetCurrentSubscriptionEndpoint';
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
        value = SubscriptionModel.fromJson(httpResponse.data['result']);
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
