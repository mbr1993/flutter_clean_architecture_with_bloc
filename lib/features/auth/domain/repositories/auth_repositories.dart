import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_with_bloc/core/errors/failures.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/domain/entities/login_entity.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/domain/entities/register_entity.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/domain/use_cases/post_login.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/domain/use_cases/post_register.dart';

abstract class AuthRepositories {
  Future<Either<Failure, LoginEntity>> login(LoginParams loginParams);

  Future<Either<Failure, RegisterEntity>> register(RegisterParams registerParams);
}
