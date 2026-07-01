class ServerException implements Exception {
  final String code;
  final String message;

  const ServerException({
    required this.code, 
    required this.message,
  });
}