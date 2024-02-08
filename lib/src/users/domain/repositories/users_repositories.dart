import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_with_bloc/core/errors/failures.dart';
import 'package:flutter_clean_architecture_with_bloc/src/users/domain/entities/users.dart';
import 'package:flutter_clean_architecture_with_bloc/src/users/domain/use_cases/use_cases.dart';

mixin UsersRepositories {
  Future<Either<Failure, Users>> getUsers(UsersParam usersParam);

  // save users
  Future<Either<Failure, void>> saveUsers(UsersParam usersParam);

  // clear users
  Future<Either<Failure, void>> clearUsers(UsersParam usersParam);
}
