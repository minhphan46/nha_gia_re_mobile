import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/repository/post_repository.dart';
import '../../../../../core/resources/pair.dart';
import '../../../entities/posts/real_estate_post.dart';

class GetPostsUseCase
    implements
        UseCase<DataState<Pair<int, List<RealEstatePostEntity>>>,
            Pair<String?, int?>?> {
  final PostRepository _postRepository;

  GetPostsUseCase(this._postRepository);

  @override
  Future<DataState<Pair<int, List<RealEstatePostEntity>>>> call(
      {Pair<String?, int?>? params}) {
    return _postRepository.getPosts(params!.first, params.second);
  }
}
