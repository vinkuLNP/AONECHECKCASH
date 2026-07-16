class ServerException implements Exception {}

class CacheException implements Exception {}

class NetworkException implements Exception {}

class ApiException implements Exception {
  final int? statusCode;
  final String message;

  const ApiException({this.statusCode, required this.message});

  @override
  String toString() {
    return 'ApiException(statusCode: $statusCode, message: $message)';
  }
}
