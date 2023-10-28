import 'package:nhagiare_mobile/features/domain/entities/properties/post.dart';
import '../../../../core/resources/data_state.dart';

abstract class PostRepository {
  // API remote
  Future<DataState<List<PostEntity>>> getPosts();
  Future<DataState<PostEntity>> getSinglePost(String id);
  Future<DataState<void>> createPost(PostEntity post);
  Future<DataState<void>> updatePost(PostEntity post);
  Future<DataState<void>> deletePost(String id);
}
