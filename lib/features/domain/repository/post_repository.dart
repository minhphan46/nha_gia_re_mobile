import 'dart:io';
import '../../../../core/resources/data_state.dart';
import '../../../core/resources/pair.dart';
import '../entities/posts/filter_request.dart';
import '../entities/posts/real_estate_post.dart';

abstract class PostRepository {
  // API remote
  Future<DataState<Pair<int, List<RealEstatePostEntity>>>> getPosts(
      String? idUser);
  Future<DataState<RealEstatePostEntity>> getSinglePost(String id);
  Future<DataState<void>> createPost(RealEstatePostEntity post);
  Future<DataState<void>> updatePost(RealEstatePostEntity post);
  Future<DataState<void>> deletePost(String id);

  Future<DataState<Pair<int, List<RealEstatePostEntity>>>> getPostsSearch(
      PostFilter filter);

  Future<DataState<List<String>>> uploadImages(List<File> images);

  // management
  Future<DataState<Pair<int, List<RealEstatePostEntity>>>> getPostsApproved();
  Future<DataState<Pair<int, List<RealEstatePostEntity>>>> getPostsHided();
  Future<DataState<Pair<int, List<RealEstatePostEntity>>>> getPostsPending();
  Future<DataState<Pair<int, List<RealEstatePostEntity>>>> getPostsRejected();
  Future<DataState<Pair<int, List<RealEstatePostEntity>>>> getPostsExpired();
}
