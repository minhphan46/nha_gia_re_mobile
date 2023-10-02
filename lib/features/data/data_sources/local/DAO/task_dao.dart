import 'package:floor/floor.dart';
import '../../../models/task_local.dart';

@dao
abstract class TaskDao {
  @Insert()
  Future<void> insertTask(TaskLocalModel task);

  // delete
  @delete
  Future<void> deleteTask(TaskLocalModel task);

  // get tasks
  @Query('SELECT * FROM task')
  Future<List<TaskLocalModel>> getTasks();
}
