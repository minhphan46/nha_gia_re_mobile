import 'dart:io';
import '../../../../core/resources/data_state.dart';
import '../entities/posts/filter_request.dart';
import '../entities/posts/real_estate_post.dart';

abstract class PostRepository {
  // API remote
  Future<DataState<List<RealEstatePostEntity>>> getPosts(String? idUser);
  Future<DataState<RealEstatePostEntity>> getSinglePost(String id);
  Future<DataState<void>> createPost(RealEstatePostEntity post);
  Future<DataState<void>> updatePost(RealEstatePostEntity post);
  Future<DataState<void>> deletePost(String id);

  Future<DataState<List<RealEstatePostEntity>>> getPostsSearch(
      PostFilter filter);

  Future<DataState<List<String>>> uploadImages(List<File> images);

  // management
  Future<DataState<List<RealEstatePostEntity>>> getPostsApproved();
  Future<DataState<List<RealEstatePostEntity>>> getPostsHided();
  Future<DataState<List<RealEstatePostEntity>>> getPostsPending();
  Future<DataState<List<RealEstatePostEntity>>> getPostsRejected();
  Future<DataState<List<RealEstatePostEntity>>> getPostsExpired();
}
