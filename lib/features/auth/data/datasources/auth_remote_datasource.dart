import 'package:dio/dio.dart';
import 'package:field_track/core/errors/exceptions.dart';
import 'package:field_track/core/network/api_client.dart';
import 'package:field_track/core/network/api_endpoint.dart';
import 'package:field_track/features/auth/data/models/auth_response_model.dart';
import 'package:field_track/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<AuthResponseModel> login(String email, String password);
  Future<AuthResponseModel> register(
    String email,
    String password,
    String fullName,
  );
  Future<bool> logout();
  Future<UserModel> me();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final ApiClient _apiClient;

  AuthRemoteDatasourceImpl({required this._apiClient});

  @override
  Future<AuthResponseModel> login(String email, String password) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoint.login,
        body: {'email': email, 'password': password},
      );
      return AuthResponseModel.fromJson(response);
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
  Future<AuthResponseModel> register(
    String email,
    String password,
    String fullName,
  ) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoint.register,
        body: {'email': email, 'password': password, 'full_name': fullName},
      );
      return AuthResponseModel.fromJson(response);
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
  Future<bool> logout() async {
    try {
      final response = await _apiClient.post(ApiEndpoint.logout);
      return response['success'] as bool;
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
  Future<UserModel> me() async {
    try {
    final response = await _apiClient.get(ApiEndpoint.me);
    return UserModel.fromJson(response);
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
