import 'package:flutter_clean_architecture_with_bloc/core/network/dio_client.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/data/data_sources/auth_remote_data_sources.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/data/repositories/auth_repositories_imp.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/domain/repositories/auth_repositories.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/domain/use_cases/post_login.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/domain/use_cases/post_register.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/presentation/login/cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

Future<void> serviceLocator() async {
  sl.registerSingleton<DioClient>(DioClient());
  _repositories();
  _dataSources();
  _useCase();
  _cubit();
}

/// Register repositories
void _repositories() {
  sl.registerLazySingleton<AuthRepositories>(() => AuthRepositoriesImp(sl()));
}

/// Register dataSources
void _dataSources() {
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(sl()));
}

void _cubit() {
  /// Auth
  sl.registerFactory<AuthCubit>(() => AuthCubit(sl()));
}

void _useCase() {
  /// Auth
  sl
    ..registerLazySingleton<PostLogin>(() => PostLogin(sl()))
    ..registerLazySingleton<PostRegister>(() => PostRegister(sl()));
}
