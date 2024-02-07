import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_with_bloc/core/errors/failures.dart';
import 'package:flutter_clean_architecture_with_bloc/utils/services/hive.dart';

abstract class AuthLocalDataSource {
  Future<Either<Failure, void>> saveToken(String token);

  Future<Either<Failure, void>> deleteToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl(this._hive);

  final HiveService _hive;

  @override
  Future<Either<Failure, void>> saveToken(String token) async {
    try {
      await _hive.saveToken(token);
      return const Right(null);
    } catch (error) {
      return Left(LocalStorageFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteToken() async {
    try {
      await _hive.deleteToken();
      return const Right(null);
    } catch (error) {
      return Left(LocalStorageFailure(error.toString()));
    }
  }
}
