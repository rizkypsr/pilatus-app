class ServerException implements Exception {}

class AuthenticationException implements Exception {}

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);
}
