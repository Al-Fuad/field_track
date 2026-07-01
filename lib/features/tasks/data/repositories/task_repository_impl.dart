import 'package:field_track/core/errors/exceptions.dart';
import 'package:field_track/core/failures/failure.dart';
import 'package:field_track/features/tasks/domain/entities/task.dart';
import 'package:field_track/features/tasks/data/datasources/task_remote_datasource.dart';
import 'package:field_track/features/tasks/domain/repositories/task_repository.dart';
import 'package:fpdart/fpdart.dart' hide Task;

class TaskRepositoryImpl extends TaskRepository {
  final TaskRemoteDatasource taskRemoteDatasource;
  TaskRepositoryImpl({required this.taskRemoteDatasource});
  @override
  Future<Either<Failure, List<Task>>> getAllTasks() async {
    try {
      final user = await taskRemoteDatasource.getAllTasks();
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Failed to connect to the network.'));
    }
  }

  @override
  Future<Either<Failure, Task>> updateTask(String taskId, bool isCompleted) async {
    try {
      final user = await taskRemoteDatasource.updateTask(taskId, isCompleted);
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Failed to connect to the network.'));
    }
  }
}