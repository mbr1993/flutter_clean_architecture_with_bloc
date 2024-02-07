import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_with_bloc/core/errors/failures.dart';
import 'package:flutter_clean_architecture_with_bloc/core/network/network_info.dart';
import 'package:flutter_clean_architecture_with_bloc/src/auth/data/data_sources/auth_local_data_sources.dart';
import 'package:flutter_clean_architecture_with_bloc/src/auth/data/data_sources/auth_remote_data_sources.dart';
import 'package:flutter_clean_architecture_with_bloc/src/auth/domain/entities/register_entity.dart';
import 'package:flutter_clean_architecture_with_bloc/src/auth/domain/entities/token_entity.dart';
import 'package:flutter_clean_architecture_with_bloc/src/auth/domain/repositories/auth_repositories.dart';
import 'package:flutter_clean_architecture_with_bloc/src/auth/domain/use_cases/login.dart';
import 'package:flutter_clean_architecture_with_bloc/src/auth/domain/use_cases/register.dart';

class AuthRepositoriesImp implements AuthRepositories {
  AuthRepositoriesImp(this._remoteDataSource, this._localDataSource, this._networkInfo);

  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Failure, TokenEntity>> login(LoginParams loginParams) async {
    try {
      final response = await _remoteDataSource.login(loginParams);
      if (!await _networkInfo.hasInternet()) {
        return Left(NoInternetFailure('Check internet connection'));
      } else {
        return response.fold(Left.new, (loginResponse) async {
          await _localDataSource.saveToken(loginResponse.token!);
          return Right(loginResponse.tokenEntity());
        });
      }
    } catch (error) {
      return Left(
        ServerFailure(error.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, RegisterEntity>> register(RegisterParams registerParams) async {
    try {
      final response = await _remoteDataSource.register(registerParams);

      if (!await _networkInfo.hasInternet()) {
        return Left(NoInternetFailure('Check internet connection'));
      } else {
        return response.fold(Left.new, (registerResponse) async {
          await _localDataSource.saveToken(registerResponse.token!);
          return Right(registerResponse.toEntity());
        });
      }
    } catch (error) {
      return Left(
        ServerFailure(error.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      if (!await _networkInfo.hasInternet()) {
        return Left(NoInternetFailure('Check internet connection'));
      }
      await _localDataSource.deleteToken();
      return const Right(null);
    } catch (error) {
      return Left(
        ServerFailure(error.toString()),
      );
    }
  }
}
