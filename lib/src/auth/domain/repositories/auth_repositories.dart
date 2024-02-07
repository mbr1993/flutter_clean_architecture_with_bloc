import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_with_bloc/core/errors/failures.dart';
import 'package:flutter_clean_architecture_with_bloc/src/auth/domain/entities/register_entity.dart';
import 'package:flutter_clean_architecture_with_bloc/src/auth/domain/entities/token_entity.dart';
import 'package:flutter_clean_architecture_with_bloc/src/auth/domain/use_cases/login.dart';
import 'package:flutter_clean_architecture_with_bloc/src/auth/domain/use_cases/register.dart';

abstract class AuthRepositories {
  // Login
  Future<Either<Failure, TokenEntity>> login(LoginParams loginParams);

  // Logout
  Future<Either<Failure, void>> logout();

  // Register
  Future<Either<Failure, RegisterEntity>> register(RegisterParams registerParams);
}
