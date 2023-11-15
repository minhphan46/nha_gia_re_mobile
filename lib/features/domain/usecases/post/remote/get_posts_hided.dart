import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/repository/post_repository.dart';
import '../../../entities/posts/real_estate_post.dart';

class GetPostsHidedUseCase
    implements UseCase<DataState<List<RealEstatePostEntity>>, void> {
  final PostRepository _postRepository;

  GetPostsHidedUseCase(this._postRepository);

  @override
  Future<DataState<List<RealEstatePostEntity>>> call({void params}) {
    return _postRepository.getPostsHided();
  }
}
