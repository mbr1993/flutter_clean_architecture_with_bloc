abstract class Failure {
  /// ignore: avoid_unused_constructor_parameters
  const Failure([
    List<dynamic> properties = const <dynamic>[],
  ]);
}

class ServerFailure extends Failure {
  const ServerFailure(this.message);

  final String? message;

  @override
  String toString() {
    return 'ServerFailure: Check your email or password.';
  }
}

class NoDataFailure extends Failure {}

class CacheFailure extends Failure {}

class NoInternetFailure extends Failure {
  NoInternetFailure(this.message);

  final String message;

  @override
  String toString() {
    return message;
  }
}

class LocalStorageFailure extends Failure {
  LocalStorageFailure(this.message);

  final String message;

  @override
  String toString() {
    return message;
  }
}

class TokenNotFountFailure extends Failure {
  TokenNotFountFailure(this.message);

  final String message;

  @override
  String toString() {
    return message;
  }
}
