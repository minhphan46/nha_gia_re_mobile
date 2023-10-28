import '../../../../core/resources/data_state.dart';
import '../entities/posts/real_estate_post.dart';

abstract class PostRepository {
  // API remote
  Future<DataState<List<RealEstatePostEntity>>> getPosts();
  Future<DataState<RealEstatePostEntity>> getSinglePost(String id);
  Future<DataState<void>> createPost(RealEstatePostEntity post);
  Future<DataState<void>> updatePost(RealEstatePostEntity post);
  Future<DataState<void>> deletePost(String id);
}