import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoint {
  static String get baseUrl => dotenv.env["BASE_URL"] ?? "http://localhost:5858";
  // Health
  static const String health = "/health";
  // Auth
  static const String register = "/api/v1/auth/register";
  static const String login = "/api/v1/auth/login";
  static const String refresh = "/api/v1/auth/refresh";
  static const String logout = "/api/v1/auth/logout";
  static const String me = "/api/v1/me";
  // Locations
  static const String locations = "/api/v1/locations";
  static String locationId(String id) => "/api/v1/locations/$id";
  // Todos (Tasks)
  static const String todos = "/api/v1/todos";
  static String todoId(String id) => "/api/v1/todos/$id";
  static const String syncTodos = "/api/v1/todos/sync";
}