import 'package:dio/dio.dart';
import 'token_storage.dart';
import 'api_endpoint.dart';

class ApiClient {
  final Dio _dio;
  final TokenStorage _tokenStorage;

  ApiClient({TokenStorage? tokenStorage})
    : _tokenStorage = tokenStorage ?? TokenStorage(),
      _dio = Dio(
        BaseOptions(
          baseUrl: ApiEndpoint.baseUrl,
          headers: {"Content-Type": "application/json"},
        ),
      ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _tokenStorage.getToken();
          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },
      ),
    );
  }

  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final response = await _dio.get(
      endpoint,
      queryParameters: queryParameters,
      options: headers != null ? Options(headers: headers) : null,
    );
    return _processResponse(response);
  }

  Future<dynamic> post(
    String endpoint, {
    Map<String, dynamic>? headers,
    dynamic body,
  }) async {
    final response = await _dio.post(
      endpoint,
      data: body,
      options: headers != null ? Options(headers: headers) : null,
    );
    return _processResponse(response);
  }

  Future<dynamic> put(
    String endpoint, {
    Map<String, dynamic>? headers,
    dynamic body,
  }) async {
    final response = await _dio.put(
      endpoint,
      data: body,
      options: headers != null ? Options(headers: headers) : null,
    );
    return _processResponse(response);
  }

  Future<dynamic> delete(
    String endpoint, {
    Map<String, dynamic>? headers,
    dynamic body,
  }) async {
    final response = await _dio.delete(
      endpoint,
      data: body,
      options: headers != null ? Options(headers: headers) : null,
    );
    return _processResponse(response);
  }

  Future<dynamic> patch(
    String endpoint, {
    Map<String, dynamic>? headers,
    dynamic body,
  }) async {
    final response = await _dio.patch(
      endpoint,
      data: body,
      options: headers != null ? Options(headers: headers) : null,
    );
    return _processResponse(response);
  }

  dynamic _processResponse(Response response) {
    final statusCode = response.statusCode;
    final responseData = response.data;

    if (statusCode != null && statusCode >= 200 && statusCode < 300) {
      return responseData ?? {};
    } else {
      throw Exception('API Error: $statusCode $responseData');
    }
  }
}
