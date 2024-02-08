import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_with_bloc/core/errors/failures.dart';
import 'package:flutter_clean_architecture_with_bloc/core/usecases/usecase.dart';
import 'package:flutter_clean_architecture_with_bloc/src/users/domain/entities/users.dart';
import 'package:flutter_clean_architecture_with_bloc/src/users/domain/repositories/users_repositories.dart';

class UsersUseCase {
  UsersUseCase(this._repo);

  final UsersRepositories _repo;

  Future<Either<Failure, Users>> getUsers(UsersParam params) {
    return _repo.getUsers(params);
  }

  Future<Either<Failure, void>> saveUsers(UsersParam params) {
    return _repo.saveUsers(params);
  }
}

class UsersParam {
  UsersParam({this.page});

  int? page = 1;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {'page': page};
}
