import 'package:field_track/core/usecase/usecase.dart';
import 'package:field_track/core/failures/failure.dart';
import 'package:field_track/features/tasks/domain/entities/task.dart';
import 'package:field_track/features/tasks/domain/repositories/task_repository.dart';
import 'package:fpdart/fpdart.dart' hide Task;

class GetAllTasksUsecase implements Usecase<List<Task>, NoParams> {
  final TaskRepository taskRepository;
  GetAllTasksUsecase({required this.taskRepository});
  @override
  Future<Either<Failure, List<Task>>> call(NoParams params) {
    return taskRepository.getAllTasks();
  }
}