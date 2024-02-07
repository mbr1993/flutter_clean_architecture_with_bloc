import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_with_bloc/core/errors/failures.dart';
import 'package:flutter_clean_architecture_with_bloc/core/usecases/usecase.dart';
import 'package:flutter_clean_architecture_with_bloc/src/auth/domain/repositories/auth_repositories.dart';

class LogoutUseCase with UseCase<void, void> {
  LogoutUseCase(this._authRepo);

  final AuthRepositories _authRepo;

  @override
  Future<Either<Failure, void>> call(void params) {
    return _authRepo.logout();
  }
}
