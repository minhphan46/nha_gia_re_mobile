import '../../../../../core/resources/data_state.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../repository/post_repository.dart';

class DeletePostUseCase implements UseCase<DataState<void>, String> {
  final PostRepository _postRepository;

  DeletePostUseCase(this._postRepository);

  @override
  Future<DataState<void>> call({String? params}) {
    return _postRepository.deletePost(params!);
  }
}
