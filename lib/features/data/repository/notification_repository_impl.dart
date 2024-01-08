import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nhagiare_mobile/features/data/data_sources/remote/notification_remote_data_source.dart';

import '../../../core/resources/data_state.dart';
import '../../../core/resources/pair.dart';
import '../../domain/repository/notification_repository.dart';
import '../models/notification.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  NotificationRemoteDateSoure remoteDataSrc;

  NotificationRepositoryImpl(this.remoteDataSrc);

  @override
  Future<DataState<Pair<int, List<NotificationModel>>>> getAllNotifications(
      int page) async {
    try {
      final httpResponse = await remoteDataSrc.getAllNotifications(page);

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
}
