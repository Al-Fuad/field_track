import 'package:dio/dio.dart';
import 'package:field_track/core/errors/exceptions.dart';
import 'package:field_track/core/network/api_client.dart';
import 'package:field_track/core/network/api_endpoint.dart';
import 'package:field_track/features/tasks/data/models/task_model.dart';
import 'package:field_track/features/tasks/domain/entities/task.dart';

abstract class TaskRemoteDatasource {
  Future<List<Task>> getAllTasks();
  Future<Task> updateTask(String taskId, bool isCompleted);
}

class TaskRemoteDatasourceImpl implements TaskRemoteDatasource {
  final ApiClient _apiClient;
  TaskRemoteDatasourceImpl(this._apiClient);
  
  @override
  Future<List<Task>> getAllTasks() async {
    try {
      final response = await _apiClient.get(ApiEndpoint.todos);
      return (response['data'] as List).map((e) => TaskModel.fromJson(e)).toList();
    } on DioException catch (e) {
      if (e.response?.data != null && e.response?.data['error'] != null) {
        final errorData = e.response!.data['error'];
        throw ServerException(
          code: errorData['code'],
          message: errorData['message'],
        );
      }
      throw const ServerException(
        code: 'NETWORK_ERROR',
        message: 'Connection failed',
      );
    }
  }

  @override
  Future<Task> updateTask(String taskId, bool isCompleted) async {
    try {
      final response = await _apiClient.patch(ApiEndpoint.todoId(taskId), body: {
        'is_completed': isCompleted,
        'updated_at': DateTime.now().toIso8601String(),
      });
      return TaskModel.fromJson(response['data']);
    } on DioException catch (e) {
      if (e.response?.data != null && e.response?.data['error'] != null) {
        final errorData = e.response!.data['error'];
        throw ServerException(
          code: errorData['code'],
          message: errorData['message'],
        );
      }
      throw const ServerException(
        code: 'NETWORK_ERROR',
        message: 'Connection failed',
      );
    }
    
  }
}