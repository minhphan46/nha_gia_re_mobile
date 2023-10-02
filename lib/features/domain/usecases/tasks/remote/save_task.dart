import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/entities/task.dart';
import 'package:nhagiare_mobile/features/domain/repository/task_repository.dart';

class SaveTaskUseCase implements UseCase<DataState<void>, TaskEntity> {
  final TaskRepository _taskRepository;

  SaveTaskUseCase(this._taskRepository);

  @override
  Future<DataState<void>> call({TaskEntity? params}) {
    return _taskRepository.createTask(params!);
  }
}
