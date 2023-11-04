import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/entities/task/task.dart';
import 'package:nhagiare_mobile/features/domain/repository/task_repository.dart';

class GetLocalTasksUseCase implements UseCase<List<TaskEntity>, void> {
  final TaskRepository _taskRepository;

  GetLocalTasksUseCase(this._taskRepository);

  @override
  Future<List<TaskEntity>> call({void params}) {
    return _taskRepository.getTasksLocal();
  }
}
