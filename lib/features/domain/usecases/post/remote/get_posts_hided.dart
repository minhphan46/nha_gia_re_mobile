import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/repository/post_repository.dart';
import '../../../../../core/resources/pair.dart';
import '../../../entities/posts/real_estate_post.dart';

class GetPostsHidedUseCase
    implements UseCase<DataState<Pair<int, List<RealEstatePostEntity>>>, void> {
  final PostRepository _postRepository;

  GetPostsHidedUseCase(this._postRepository);

  @override
  Future<DataState<Pair<int, List<RealEstatePostEntity>>>> call({void params}) {
    return _postRepository.getPostsHided();
  }
}
