import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_with_bloc/core/errors/failures.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/data/data_sources/auth_remote_data_sources.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/domain/entities/login_entity.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/domain/entities/register_entity.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/domain/repositories/auth_repositories.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/domain/use_cases/post_login.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/domain/use_cases/post_register.dart';

class AuthRepositoriesImp implements AuthRepositories {
  AuthRepositoriesImp(this._authRemoteDataSource);

  /// Data Source
  final AuthRemoteDataSource _authRemoteDataSource;

  @override
  Future<Either<Failure, LoginEntity>> login(
    LoginParams loginParams,
  ) async {
    final response = await _authRemoteDataSource.login(loginParams);

    return response.fold(Left.new, (loginResponse) {
      return Right(loginResponse.toEntity());
    });
  }

  @override
  Future<Either<Failure, RegisterEntity>> register(
    RegisterParams registerParams,
  ) async {
    final response = await _authRemoteDataSource.register(registerParams);

    return response.fold(
      Left.new,
      (registerResponse) {
        return Right(registerResponse.toEntity());
      },
    );
  }
}
