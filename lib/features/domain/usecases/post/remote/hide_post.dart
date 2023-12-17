import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/repository/post_repository.dart';
import '../../../../../core/resources/pair.dart';
import '../../../entities/posts/real_estate_post.dart';

class HidePostsUseCase
    implements UseCase<DataState<void>, Pair<RealEstatePostEntity, bool>> {
  final PostRepository _postRepository;

  HidePostsUseCase(this._postRepository);

  @override
  Future<DataState<void>> call({Pair<RealEstatePostEntity, bool>? params}) {
    RealEstatePostEntity post = params!.first;
    return _postRepository.updatePost(post.copyWith(isActive: params.second));
  }
}
