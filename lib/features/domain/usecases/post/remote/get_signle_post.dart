import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/repository/post_repository.dart';
import '../../../entities/posts/real_estate_post.dart';

class GetSignlePostUseCase
    implements UseCase<DataState<RealEstatePostEntity>, String> {
  final PostRepository _postRepository;

  GetSignlePostUseCase(this._postRepository);

  @override
  Future<DataState<RealEstatePostEntity>> call({String? params}) {
    return _postRepository.getSinglePost(params!);
  }
}
