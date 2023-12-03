import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/features/data/data_sources/remote/post_remote_data_sources.dart';
import 'package:nhagiare_mobile/features/data/models/post/real_estate_post.dart';
import 'package:nhagiare_mobile/features/domain/repository/post_repository.dart';
import '../../../core/resources/pair.dart';
import '../../domain/entities/posts/filter_request.dart';
import '../../domain/entities/posts/real_estate_post.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSrc _dataSrc;
  PostRepositoryImpl(this._dataSrc);

  @override
  Future<DataState<Pair<int, List<RealEstatePostEntity>>>> getPosts(
      String? userId) async {
    try {
      final httpResponse = await _dataSrc.getAllPosts(userId);

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
  Future<DataState<void>> createPost(RealEstatePostEntity post) async {
    try {
      final httpResponse =
          await _dataSrc.createPost(RealEstatePostModel.fromEntity(post));

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<void>> deletePost(String id) async {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<DataState<RealEstatePostEntity>> getSinglePost(String id) async {
    // TODO: implement getSinglePost
    throw UnimplementedError();
  }

  @override
  Future<DataState<void>> updatePost(RealEstatePostEntity post) async {
    // TODO: implement updatePost
    throw UnimplementedError();
  }

  @override
  Future<DataState<Pair<int, List<RealEstatePostEntity>>>> getPostsApproved(
      int? page) async {
    try {
      final httpResponse = await _dataSrc.getPostsStatus("approved", page);

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
  Future<DataState<Pair<int, List<RealEstatePostEntity>>>>
      getPostsExpired() async {
    try {
      final httpResponse = await _dataSrc.getPostsExpired();

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
  Future<DataState<Pair<int, List<RealEstatePostEntity>>>>
      getPostsHided() async {
    try {
      final httpResponse = await _dataSrc.getPostsStatus("hided", 1);

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
  Future<DataState<Pair<int, List<RealEstatePostEntity>>>>
      getPostsPending() async {
    try {
      final httpResponse = await _dataSrc.getPostsStatus("pending", 1);

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
  Future<DataState<Pair<int, List<RealEstatePostEntity>>>>
      getPostsRejected() async {
    try {
      final httpResponse = await _dataSrc.getPostsStatus("rejected", 1);

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
  Future<DataState<List<String>>> uploadImages(List<File> images) async {
    try {
      final httpResponse = await _dataSrc.uploadImages(images);

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
  Future<DataState<Pair<int, List<RealEstatePostEntity>>>> getPostsSearch(
      PostFilter? query) async {
    try {
      final httpResponse = await _dataSrc.getPostsSearch(query!);

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
  Future<DataState<List<String>>> getSuggestKeywords(String keyword) async {
    try {
      final httpResponse = await _dataSrc.getSuggestKeywords(keyword);

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
