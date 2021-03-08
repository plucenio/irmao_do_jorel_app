class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

class EmptyResultException implements Exception {
  final String message = "Empty result";

  EmptyResultException();
}
