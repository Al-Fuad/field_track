import 'package:field_track/core/failures/failure.dart';
import 'package:field_track/features/tasks/domain/entities/task.dart';
import 'package:fpdart/fpdart.dart' hide Task;

abstract class TaskRepository {
  Future<Either<Failure, List<Task>>> getAllTasks();
  Future<Either<Failure, Task>> updateTask(String taskId, bool isCompleted);
}