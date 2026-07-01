import 'package:field_track/core/usecase/usecase.dart';
import 'package:field_track/core/failures/failure.dart';
import 'package:field_track/features/tasks/domain/entities/task.dart';
import 'package:field_track/features/tasks/domain/repositories/task_repository.dart';
import 'package:fpdart/fpdart.dart' hide Task;

class UpdateTaskUsecase implements Usecase<Task, UpdateTaskParams> {
  final TaskRepository taskRepository;
  UpdateTaskUsecase({required this.taskRepository});
  @override
  Future<Either<Failure, Task>> call(UpdateTaskParams params) {
    return taskRepository.updateTask(params.taskId, params.isCompleted);
  }
}

class UpdateTaskParams {
  final String taskId;
  final bool isCompleted;
  const UpdateTaskParams({required this.taskId, required this.isCompleted});
}