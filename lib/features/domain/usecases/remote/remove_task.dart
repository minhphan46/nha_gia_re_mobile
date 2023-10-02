import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import '../../repository/task_repository.dart';

class RemoveTaskUseCase implements UseCase<DataState<void>, String> {
  final TaskRepository _taskRepository;

  RemoveTaskUseCase(this._taskRepository);

  @override
  Future<DataState<void>> call({String? params}) {
    return _taskRepository.deleteTask(params!);
  }
}
