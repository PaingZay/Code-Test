class ServerException implements Exception {
  final String message;

  ServerException([this.message = "Something went wrong"]);
}

class NetworkException implements Exception {
  final String message;

  NetworkException([this.message = "No internet connection"]);
}
