import 'dart:io';
import '../../../../core/resources/data_state.dart';
import '../../../core/resources/pair.dart';
import '../entities/posts/filter_request.dart';
import '../entities/posts/limit_post.dart';
import '../entities/posts/real_estate_post.dart';

abstract class PostRepository {
  // API remote
  Future<DataState<Pair<int, List<RealEstatePostEntity>>>> getPosts(
      String? idUser, int? page);
  Future<DataState<RealEstatePostEntity>> getSinglePost(String id);
  Future<DataState<void>> createPost(RealEstatePostEntity post);
  Future<DataState<void>> updatePost(RealEstatePostEntity post);
  Future<DataState<void>> deletePost(String id);

  Future<DataState<Pair<int, List<RealEstatePostEntity>>>> getPostsSearch(
      PostFilter filter, int? page);

  Future<DataState<List<String>>> uploadImages(List<File> images);

  Future<DataState<List<String>>> getSuggestKeywords(String keyword);

  // management
  Future<DataState<Pair<int, List<RealEstatePostEntity>>>> getPostsApproved(
      int? page);
  Future<DataState<Pair<int, List<RealEstatePostEntity>>>> getPostsHided(
      int? page);
  Future<DataState<Pair<int, List<RealEstatePostEntity>>>> getPostsPending(
      int? page);
  Future<DataState<Pair<int, List<RealEstatePostEntity>>>> getPostsRejected(
      int? page);
  Future<DataState<Pair<int, List<RealEstatePostEntity>>>> getPostsExpired(
      int? page);

  Future<DataState<LitmitPostEntity>> getLimitPosts();
}
