import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/entities/posts/limit_post.dart';
import 'package:nhagiare_mobile/features/domain/repository/post_repository.dart';

class GetLimitPostsUseCase
    implements UseCase<DataState<LitmitPostEntity>, void> {
  final PostRepository _postRepository;

  GetLimitPostsUseCase(this._postRepository);

  @override
  Future<DataState<LitmitPostEntity>> call({void params}) {
    return _postRepository.getLimitPosts();
  }
}
