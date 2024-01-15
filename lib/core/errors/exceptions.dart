class ServerException implements Exception {
  ServerException(this.message);

  String? message;
}

class CacheException implements Exception {}
