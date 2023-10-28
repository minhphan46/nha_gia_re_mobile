import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/entities/properties/post.dart';
import 'package:nhagiare_mobile/features/domain/repository/post_repository.dart';

class GetPostsUseCase implements UseCase<DataState<List<PostEntity>>, void> {
  final PostRepository _postRepository;

  GetPostsUseCase(this._postRepository);

  @override
  Future<DataState<List<PostEntity>>> call({void params}) {
    return _postRepository.getPosts();
  }
}
