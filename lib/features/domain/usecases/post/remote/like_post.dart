import '../../../../../core/resources/data_state.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../repository/post_repository.dart';

class LikePostUseCase implements UseCase<DataState<bool>, String> {
  final PostRepository _postRepository;

  LikePostUseCase(this._postRepository);

  @override
  Future<DataState<bool>> call({String? params}) {
    return _postRepository.markFavPost(params!);
  }
}
