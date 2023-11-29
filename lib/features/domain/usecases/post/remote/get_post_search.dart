import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/repository/post_repository.dart';
import '../../../entities/posts/real_estate_post.dart';

class GetPostSearchsUseCase
    implements
        UseCase<DataState<List<RealEstatePostEntity>>, Map<String, dynamic>?> {
  final PostRepository _postRepository;

  GetPostSearchsUseCase(this._postRepository);

  @override
  Future<DataState<List<RealEstatePostEntity>>> call(
      {Map<String, dynamic>? params}) {
    return _postRepository.getPostsSearch(params);
  }
}
