abstract class Failure {
  /// ignore: avoid_unused_constructor_parameters
  const Failure([List<dynamic> properties = const <dynamic>[]]);
}

class ServerFailure extends Failure {
  const ServerFailure(this.message);

  final String? message;

  @override
  bool operator ==(Object other) {
    return other is ServerFailure && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class NoDataFailure extends Failure {
  @override
  bool operator ==(Object other) => other is NoDataFailure;

  @override
  int get hashCode => 0;
}

class CacheFailure extends Failure {
  @override
  bool operator ==(Object other) => other is CacheFailure;

  @override
  int get hashCode => 0;
}
