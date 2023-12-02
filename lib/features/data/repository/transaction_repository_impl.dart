import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/features/data/data_sources/remote/transaction_remote_data_source.dart';
import 'package:nhagiare_mobile/features/data/models/purchase/subscription_model.dart';

import 'package:nhagiare_mobile/features/domain/entities/purchase/transaction.dart';

import '../../domain/repository/transaction_repository.dart';

class TranstractionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSrc _transtractionDataSource;

  TranstractionRepositoryImpl(this._transtractionDataSource);

  @override
  Future<DataState<TransactionEntity>> getTransactionByAppTransId(
      String id) async {
    try {
      final httpResponse =
          await _transtractionDataSource.getTransactionByAppTransId(id);

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
  Future<DataState<List<TransactionEntity>>> getAllTransactions() async {
    try {
      final httpResponse = await _transtractionDataSource.getAllTransactions();

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
  Future<DataState<SubscriptionModel?>> getCurrentSubscription() {
    try {
      return _transtractionDataSource.getCurrentSubscription().then((value) {
        if (value.response.statusCode == HttpStatus.ok) {
          return DataSuccess(value.data);
        } else {
          return DataFailed(DioException(
            error: value.response.statusMessage,
            response: value.response,
            type: DioExceptionType.badResponse,
            requestOptions: value.response.requestOptions,
          ));
        }
      });
    } on DioException catch (e) {
      return Future.value(DataFailed(e));
    }
  }
}
