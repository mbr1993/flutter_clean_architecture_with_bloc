import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_with_bloc/core/errors/failures.dart';
import 'package:flutter_clean_architecture_with_bloc/core/usecases/usecase.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/domain/entities/login_entity.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/domain/repositories/auth_repositories.dart';

class PostLogin extends UseCase<LoginEntity, LoginParams> {
  PostLogin(this._authRepo);

  final AuthRepositories _authRepo;

  @override
  Future<Either<Failure, LoginEntity>> call(LoginParams params) {
    return _authRepo.login(params);
  }
}

class LoginParams {
  LoginParams({this.email, this.password});

  factory LoginParams.fromRawJson(String str) {
    return LoginParams.fromJson(json.decode(str) as Map<String, dynamic>);
  }

  factory LoginParams.fromJson(Map<String, dynamic> json) {
    return LoginParams(
      email: json['email'] as String?,
      password: json['password'] as String?,
    );
  }

  String? email;
  String? password;

  LoginParams copyWith({String? email, String? password}) {
    return LoginParams(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
