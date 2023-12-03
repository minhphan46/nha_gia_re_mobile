import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nhagiare_mobile/core/resources/data_state.dart';

import 'package:nhagiare_mobile/core/resources/pair.dart';
import 'package:nhagiare_mobile/features/data/data_sources/remote/user_remote_date_source.dart';

import '../../domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl(this.userRemoteDataSource);

  @override
  Future<DataState<bool>> followOrUnfollowUser(String userId) async {
    try {
      final httpResponse =
          await userRemoteDataSource.followOrUnfollowUser(userId);

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
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DataState<Pair<int, int>>> getFollowersAndFollowingsCount(
      String userId) async {
    try {
      final httpResponse =
          await userRemoteDataSource.getFollowersAndFollowingsCount(userId);

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
    } catch (e) {
      rethrow;
    }
  }
}
