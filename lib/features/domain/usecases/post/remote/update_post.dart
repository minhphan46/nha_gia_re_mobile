import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/repository/post_repository.dart';
import '../../../entities/posts/real_estate_post.dart';

class UpdatePostsUseCase
    implements UseCase<DataState<void>, RealEstatePostEntity> {
  final PostRepository _postRepository;

  UpdatePostsUseCase(this._postRepository);

  @override
  Future<DataState<void>> call({RealEstatePostEntity? params}) {
    return _postRepository.updatePost(params!);
  }
}
