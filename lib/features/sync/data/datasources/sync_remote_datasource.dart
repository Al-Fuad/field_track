import 'package:dio/dio.dart';
import 'package:field_track/core/errors/exceptions.dart';
import 'package:field_track/core/network/api_client.dart';
import 'package:field_track/core/network/api_endpoint.dart';

abstract class SyncRemoteDatasource {
  Future<void> syncAll();
}

class SyncRemoteDatasourceImpl implements SyncRemoteDatasource {
  final ApiClient apiClient;
  SyncRemoteDatasourceImpl({required this.apiClient});

  @override
  Future<void> syncAll() async {
    try {
      final response = await apiClient.get(ApiEndpoint.syncTodos);
      return response['data'];
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