import 'package:dio/dio.dart';
import 'package:nhagiare_mobile/core/resources/pair.dart';
import 'package:nhagiare_mobile/features/data/data_sources/local/authentication_local_data_source.dart';
import 'package:retrofit/retrofit.dart';
import 'package:nhagiare_mobile/core/constants/constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../domain/entities/user/account_verification_requests.dart';
import '../../../domain/entities/user/report.dart';
import '../../../domain/enums/verification_status.dart';

abstract class UserRemoteDataSource {
  Future<HttpResponse<bool>> followOrUnfollowUser(String userId);
  Future<HttpResponse<Pair<int, int>>> getFollowersAndFollowingsCount(
      String userId);
  Future<HttpResponse<void>> sendVerificationUser(
      AccountVerificationRequestEntity entity);
  Future<HttpResponse<Pair<VerificationStatus, String>>>
      getVerificationStatus();

  Future<HttpResponse<void>> sendReport(ReportEntity report);
  Future<HttpResponse<bool>> checkIsFollow(String userId);
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  final Dio client;
  AuthenLocalDataSrc authenLocalDataSrc;
  UserRemoteDataSourceImpl(this.client, this.authenLocalDataSrc);

  @override
  Future<HttpResponse<bool>> followOrUnfollowUser(String userId) {
    String url = '$apiAppUrl$kFollowUserEndpoint'.replaceAll(':id', userId);
    print(url);
    try {
      return client
          .post(url,
              options: Options(
                headers: {
                  'Authorization':
                      'Bearer ${authenLocalDataSrc.getAccessToken()}',
                },
              ))
          .then((response) {
        if (response.statusCode != 200) {
          throw ApiException(
            message: response.data,
            statusCode: response.statusCode!,
          );
        }

        final bool data = response.data['result'];

        return HttpResponse(data, response);
      });
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }

  @override
  Future<HttpResponse<bool>> checkIsFollow(String userId) {
    String url =
        '$apiAppUrl$kCheckIsFollowUserEndpoint'.replaceAll(':id', userId);
    print(url);
    try {
      return client
          .get(url,
              options: Options(
                headers: {
                  'Authorization':
                      'Bearer ${authenLocalDataSrc.getAccessToken()}',
                },
              ))
          .then((response) {
        if (response.statusCode != 200) {
          throw ApiException(
            message: response.data,
            statusCode: response.statusCode!,
          );
        }

        final bool data = response.data['result'];

        return HttpResponse(data, response);
      });
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }

  @override
  Future<HttpResponse<Pair<int, int>>> getFollowersAndFollowingsCount(
      String userId) {
    String url = '$apiAppUrl$kGetFollowersAndFollowingsCountEndpoint';
    try {
      return client
          .get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${authenLocalDataSrc.getAccessToken()}',
          },
        ),
      )
          .then((response) {
        if (response.statusCode != 200) {
          throw ApiException(
            message: response.data,
            statusCode: response.statusCode!,
          );
        }

        final Map<String, dynamic> taskDataList = response.data['result'];
        Pair<int, int> value = Pair(
          taskDataList['num_of_following'],
          taskDataList['num_of_followers'],
        );
        return HttpResponse(value, response);
      });
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }

  @override
  Future<HttpResponse<void>> sendVerificationUser(
      AccountVerificationRequestEntity entity) async {
    String url = '$apiAppUrl$kSendVerificationUserEndpoint';
    try {
      return client
          .post(
        url,
        data: entity.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer ${authenLocalDataSrc.getAccessToken()}',
          },
        ),
      )
          .then((response) {
        if (response.statusCode != 200) {
          throw ApiException(
            message: response.data,
            statusCode: response.statusCode!,
          );
        }

        return HttpResponse(null, response);
      });
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }

  @override
  Future<HttpResponse<Pair<VerificationStatus, String>>>
      getVerificationStatus() async {
    String url = '$apiAppUrl$kSendVerificationUserEndpoint';
    try {
      return client
          .get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${authenLocalDataSrc.getAccessToken()}',
          },
        ),
      )
          .then((response) {
        print(response.data);
        if (response.statusCode != 200) {
          throw ApiException(
            message: response.data,
            statusCode: response.statusCode!,
          );
        }

        final Map<String, dynamic> taskDataList = response.data['result'];
        Pair<VerificationStatus, String> value = Pair(
          VerificationStatus.parse(taskDataList['status']),
          taskDataList['rejected_info'] ?? '',
        );

        return HttpResponse(value, response);
      });
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }

  @override
  Future<HttpResponse<void>> sendReport(ReportEntity report) async {
    String url = '$apiAppUrl$kSendReportUserEndpoint';
    try {
      print(report.toJson());
      return client
          .post(
        url,
        data: report.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer ${authenLocalDataSrc.getAccessToken()}',
          },
        ),
      )
          .then((response) {
        if (response.statusCode != 200) {
          throw ApiException(
            message: response.data,
            statusCode: response.statusCode!,
          );
        }

        return HttpResponse(null, response);
      });
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }
}
