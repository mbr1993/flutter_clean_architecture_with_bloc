import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_with_bloc/core/errors/failures.dart';
import 'package:flutter_clean_architecture_with_bloc/core/usecases/usecase.dart';
import 'package:flutter_clean_architecture_with_bloc/src/auth/domain/entities/register_entity.dart';
import 'package:flutter_clean_architecture_with_bloc/src/auth/domain/repositories/auth_repositories.dart';

class RegisterUseCase with UseCase<RegisterEntity, RegisterParams> {
  RegisterUseCase(this._authRepo);

  final AuthRepositories _authRepo;

  @override
  Future<Either<Failure, RegisterEntity>> call(RegisterParams params) {
    return _authRepo.register(params);
  }
}

class RegisterParams {
  RegisterParams({this.email, this.password});

  factory RegisterParams.fromJson(Map<String, dynamic> json) {
    return RegisterParams(
      email: json['email'] as String?,
      password: json['password'] as String?,
    );
  }

  String? email;
  String? password;

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}
