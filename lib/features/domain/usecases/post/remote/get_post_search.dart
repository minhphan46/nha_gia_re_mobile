import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/repository/post_repository.dart';
import '../../../../../core/resources/pair.dart';
import '../../../entities/posts/filter_request.dart';
import '../../../entities/posts/real_estate_post.dart';

class GetPostSearchsUseCase
    implements
        UseCase<DataState<Pair<int, List<RealEstatePostEntity>>>,
            Pair<PostFilter, int?>> {
  final PostRepository _postRepository;

  GetPostSearchsUseCase(this._postRepository);

  @override
  Future<DataState<Pair<int, List<RealEstatePostEntity>>>> call(
      {Pair<PostFilter, int?>? params}) {
    return _postRepository.getPostsSearch(params!.first, params.second);
  }
}
