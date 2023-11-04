import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/entities/task/task.dart';
import 'package:nhagiare_mobile/features/domain/repository/task_repository.dart';

class GetSingleTaskUseCase implements UseCase<DataState<TaskEntity>, String> {
  final TaskRepository _taskRepository;

  GetSingleTaskUseCase(this._taskRepository);

  @override
  Future<DataState<TaskEntity>> call({String? params}) {
    return _taskRepository.getTask(params!);
  }
}
