import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/features/data/data_sources/remote/post_remote_data_sources.dart';
import 'package:nhagiare_mobile/features/data/models/post/real_estate_post.dart';
import 'package:nhagiare_mobile/features/domain/repository/post_repository.dart';
import '../../domain/entities/posts/real_estate_post.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSrc _dataSrc;
  PostRepositoryImpl(this._dataSrc);

  @override
  Future<DataState<List<RealEstatePostEntity>>> getPosts(String? userId) async {
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
  Future<DataState<List<RealEstatePostEntity>>> getPostsApproved() async {
    try {
      final httpResponse = await _dataSrc.getPostsStatus("approved");

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
  Future<DataState<List<RealEstatePostEntity>>> getPostsExpired() async {
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
  Future<DataState<List<RealEstatePostEntity>>> getPostsHided() async {
    try {
      final httpResponse = await _dataSrc.getPostsStatus("hided");

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
  Future<DataState<List<RealEstatePostEntity>>> getPostsPending() async {
    try {
      final httpResponse = await _dataSrc.getPostsStatus("pending");

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
  Future<DataState<List<RealEstatePostEntity>>> getPostsRejected() async {
    try {
      final httpResponse = await _dataSrc.getPostsStatus("rejected");

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
  Future<DataState<List<RealEstatePostEntity>>> getPostsSearch(
      Map<String, dynamic>? query) async {
    try {
      final httpResponse = await _dataSrc.getPostsSearch(query);

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
