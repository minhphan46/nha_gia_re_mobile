import 'package:dio/dio.dart';
import 'package:nhagiare_mobile/features/data/data_sources/local/authentication_local_data_source.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/resources/pair.dart';
import '../../../../core/utils/typedef.dart';
import '../../models/notification.dart';

abstract class NotificationRemoteDateSoure {
  Future<HttpResponse<Pair<int, List<NotificationModel>>>> getAllNotifications(
      int page);
}

class NotificationRemoteDataSourceImpl extends NotificationRemoteDateSoure {
  Dio client;
  AuthenLocalDataSrc localDataSrc;
  NotificationRemoteDataSourceImpl(this.client, this.localDataSrc);
  @override
  Future<HttpResponse<Pair<int, List<NotificationModel>>>> getAllNotifications(
      int page) {
    final url = '$apiAppUrl$kGetAllNotifications';
    try {
      String accessToken = localDataSrc.getAccessToken() ?? "";
      return client.get(url,
          options: Options(headers: {
            'Authorization': 'Bearer $accessToken',
          }),
          queryParameters: {"page": page}).then((response) {
        if (response.statusCode != 200) {
          throw ApiException(
            message: response.data,
            statusCode: response.statusCode!,
          );
        }

        final List<DataMap> list = List<DataMap>.from(response.data["result"]);
        int total = response.data["num_of_pages"];
        List<NotificationModel> value = list
            .map((postJson) => NotificationModel.fromJson(postJson))
            .toList();

        return HttpResponse(Pair(total, value), response);
      });
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }
}
