import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/features/domain/repository/post_repository.dart';
import '../../domain/entities/posts/real_estate_post.dart';
import '../data_sources/remote/new_api_service.dart';

class PostRepositoryImpl implements PostRepository {
  final NewApiService _newApiService;
  PostRepositoryImpl(this._newApiService);

  @override
  Future<DataState<List<RealEstatePostEntity>>> getPosts() {
    // TODO: implement getPosts
    throw UnimplementedError();
  }

  @override
  Future<DataState<void>> createPost(RealEstatePostEntity post) {
    // TODO: implement createPost
    throw UnimplementedError();
  }

  @override
  Future<DataState<void>> deletePost(String id) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<DataState<RealEstatePostEntity>> getSinglePost(String id) {
    // TODO: implement getSinglePost
    throw UnimplementedError();
  }

  @override
  Future<DataState<void>> updatePost(RealEstatePostEntity post) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}
