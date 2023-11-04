import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/repository/post_repository.dart';
import '../../../entities/posts/real_estate_post.dart';

class GetPostsUseCase
    implements UseCase<DataState<List<RealEstatePostEntity>>, void> {
  final PostRepository _postRepository;

  GetPostsUseCase(this._postRepository);

  @override
  Future<DataState<List<RealEstatePostEntity>>> call({void params}) {
    return _postRepository.getPosts();
  }
}
