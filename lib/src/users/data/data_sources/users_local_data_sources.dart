import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_with_bloc/core/errors/failures.dart';
import 'package:flutter_clean_architecture_with_bloc/src/users/data/models/users_model.dart';
import 'package:flutter_clean_architecture_with_bloc/utils/services/hive.dart';

mixin UsersLocalDataSource {
  Future<Either<Failure, void>> saveUsersData(UsersModel usersModel);

  Future<Either<Failure, UsersModel>> getUsersData();

  Future<Either<Failure, void>> clearUsersData();
}

class UsersLocalDataSourceImpl implements UsersLocalDataSource {
  @override
  Future<Either<Failure, bool>> saveUsersData(UsersModel usersModel) async {
    try {
      await HiveService.box?.put('userData', usersModel.toRawJson());
      return const Right(true);
    } catch (e) {
      return Left(LocalStorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UsersModel>> getUsersData() async {
    try {
      final userData = HiveService.box?.get('userData');
      if (userData != null) {
        return Right(UsersModel.fromJson(userData as Map<String, dynamic>));
      } else {
        return Left(NoDataFailure());
      }
    } catch (e) {
      return Left(LocalStorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearUsersData() async {
    try {
      await HiveService.box?.delete('userData');
      return const Right(null);
    } catch (e) {
      return Left(LocalStorageFailure(e.toString()));
    }
  }
}
