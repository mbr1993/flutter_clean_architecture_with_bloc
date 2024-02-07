import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_with_bloc/core/errors/failures.dart';
import 'package:flutter_clean_architecture_with_bloc/core/usecases/usecase.dart';
import 'package:flutter_clean_architecture_with_bloc/src/auth/domain/entities/token_entity.dart';
import 'package:flutter_clean_architecture_with_bloc/src/auth/domain/repositories/auth_repositories.dart';

class LoginUseCase with UseCase<TokenEntity, LoginParams> {
  LoginUseCase(this._authRepo);

  final AuthRepositories _authRepo;

  @override
  Future<Either<Failure, TokenEntity>> call(LoginParams params) => _authRepo.login(params);
}

class LoginParams {
  LoginParams({this.email, this.password});

  factory LoginParams.fromJson(Map<String, dynamic> json) {
    return LoginParams(
      email: json['email'] as String?,
      password: json['password'] as String?,
    );
  }

  String? email;
  String? password;

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}
