import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_with_bloc/core/errors/failures.dart';
import 'package:flutter_clean_architecture_with_bloc/features/users/data/data_sources/users_remote_data_sources.dart';
import 'package:flutter_clean_architecture_with_bloc/features/users/domain/entities/users.dart';
import 'package:flutter_clean_architecture_with_bloc/features/users/domain/repositories/users_repositories.dart';
import 'package:flutter_clean_architecture_with_bloc/features/users/domain/use_cases/get_users.dart';

class UsersRepositoriesImp extends UsersRepositories {
  UsersRepositoriesImp(this.usersRemoteDataSource);

  /// Data Source
  final UsersRemoteDataSource usersRemoteDataSource;

  @override
  Future<Either<Failure, Users>> users(UsersParam usersParam) async {
    final response = await usersRemoteDataSource.users(usersParam);

    return response.fold(
      Left.new,
      (usersModel) {
        if (usersModel.dataUser?.isEmpty ?? true) {
          return Left(NoDataFailure());
        } else {
          return Right(usersModel.toEntity());
        }
      },
    );
  }
}
