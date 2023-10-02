import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/entities/task.dart';
import '../../repository/task_repository.dart';

class GetTasksUseCase implements UseCase<DataState<List<TaskEntity>>, void> {
  final TaskRepository _taskRepository;

  GetTasksUseCase(this._taskRepository);

  @override
  Future<DataState<List<TaskEntity>>> call({void params}) {
    return _taskRepository.getTasks();
  }
}
