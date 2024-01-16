import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_with_bloc/core/errors/failures.dart';
import 'package:flutter_clean_architecture_with_bloc/features/users/domain/entities/users.dart';
import 'package:flutter_clean_architecture_with_bloc/features/users/domain/use_cases/get_users.dart';

abstract class UsersRepositories {
  Future<Either<Failure, Users>> users(UsersParam usersParam);
}
