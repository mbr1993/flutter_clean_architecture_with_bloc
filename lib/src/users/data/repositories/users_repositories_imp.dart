import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_with_bloc/core/errors/failures.dart';
import 'package:flutter_clean_architecture_with_bloc/core/network/network_info.dart';
import 'package:flutter_clean_architecture_with_bloc/src/users/data/data_sources/users_local_data_sources.dart';
import 'package:flutter_clean_architecture_with_bloc/src/users/data/data_sources/users_remote_data_sources.dart';
import 'package:flutter_clean_architecture_with_bloc/src/users/data/models/users_model.dart';
import 'package:flutter_clean_architecture_with_bloc/src/users/domain/entities/users.dart';
import 'package:flutter_clean_architecture_with_bloc/src/users/domain/repositories/users_repositories.dart';
import 'package:flutter_clean_architecture_with_bloc/src/users/domain/use_cases/use_cases.dart';

class UsersRepositoriesImp with UsersRepositories {
  UsersRepositoriesImp(
    this._remoteDataSource,
    this._localDataSource,
    this._networkInfo,
  );

  final UsersRemoteDataSource _remoteDataSource;
  final UsersLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Failure, Users>> getUsers(UsersParam usersParam) async {
    final response = await _remoteDataSource.getUsers(usersParam);

    if (!await _networkInfo.hasInternet()) {
      return Left(NoInternetFailure('No Internet Connection'));
    } else {
      return response.fold(
        Left.new,
        (usersModel) {
          if (usersModel.dataUser?.isEmpty ?? true) {
            return Left(NoDataFailure());
          } else {
            _localDataSource.saveUsersData(UsersModel());
            return Right(usersModel.toEntity());
          }
        },
      );
    }
  }

  @override
  Future<Either<Failure, void>> clearUsers(UsersParam usersParam) {
    // TODO: implement clearUsers
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> saveUsers(UsersParam usersParam) {
    // TODO: implement saveUsers
    throw UnimplementedError();
  }
}
