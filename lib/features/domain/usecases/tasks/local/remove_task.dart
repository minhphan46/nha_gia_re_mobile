import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/entities/task/task.dart';
import 'package:nhagiare_mobile/features/domain/repository/task_repository.dart';

class RemoveLocalTasksUseCase implements UseCase<void, TaskEntity> {
  final TaskRepository _taskRepository;

  RemoveLocalTasksUseCase(this._taskRepository);

  @override
  Future<void> call({TaskEntity? params}) {
    return _taskRepository.removeTaskLocal(params!);
  }
}
