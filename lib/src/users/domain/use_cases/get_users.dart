import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_with_bloc/core/errors/failures.dart';
import 'package:flutter_clean_architecture_with_bloc/core/usecases/usecase.dart';
import 'package:flutter_clean_architecture_with_bloc/src/users/domain/entities/users.dart';
import 'package:flutter_clean_architecture_with_bloc/src/users/domain/repositories/users_repositories.dart';

class GetUsersUseCase with UseCase<Users, UsersParam> {
  GetUsersUseCase(this._repo);

  final UsersRepositories _repo;

  @override
  Future<Either<Failure, Users>> call(UsersParam params) {
    return _repo.users(params);
  }
}

class UsersParam {
  UsersParam({this.page});

  factory UsersParam.fromRawJson(String str) => UsersParam.fromJson(json.decode(str) as Map<String, dynamic>);

  factory UsersParam.fromJson(Map<String, dynamic> json) => UsersParam(page: json['page'] as int?);

  int? page = 1;

  UsersParam copyWith({int? page}) => UsersParam(page: page ?? this.page);

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {'page': page};
}
