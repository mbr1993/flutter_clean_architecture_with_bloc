import 'package:flutter_clean_architecture_with_bloc/core/network/dio_client.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/data/data_sources/auth_remote_data_sources.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/data/repositories/auth_repositories_imp.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/domain/repositories/auth_repositories.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/domain/use_cases/login.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/domain/use_cases/register.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/presentation/login/cubit/auth_cubit.dart';
import 'package:flutter_clean_architecture_with_bloc/features/users/data/data_sources/users_remote_data_sources.dart';
import 'package:flutter_clean_architecture_with_bloc/features/users/data/repositories/users_repositories_imp.dart';
import 'package:flutter_clean_architecture_with_bloc/features/users/domain/repositories/users_repositories.dart';
import 'package:flutter_clean_architecture_with_bloc/features/users/domain/use_cases/get_users.dart';
import 'package:flutter_clean_architecture_with_bloc/features/users/presentation/cubit/users_cubit.dart';
import 'package:flutter_clean_architecture_with_bloc/utils/services/hive.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

Future<void> serviceLocator() async {
  sl.registerSingleton<DioClient>(DioClient());
  _repositories();
  _dataSources();
  _useCase();
  _cubit();
  await _initHive();
}

/// Register Hive
Future<HiveService> _initHive() async {
  await HiveService.initHive();
  return sl.registerSingleton<HiveService>(HiveService());
}

/// Register repositories
void _repositories() {
  sl
    ..registerLazySingleton<AuthRepositories>(() => AuthRepositoriesImp(sl(), sl()))
    ..registerLazySingleton<UsersRepositories>(() => UsersRepositoriesImp(sl()));
}

/// Register dataSources
void _dataSources() {
  sl
    ..registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(sl()))
    ..registerLazySingleton<UsersRemoteDataSource>(() => UsersRemoteDataSourceImpl(sl()));
}

/// Register useCases
void _useCase() {
  sl
    ..registerLazySingleton(() => LoginUseCase(sl()))
    ..registerLazySingleton(() => RegisterUseCase(sl()))
    ..registerLazySingleton(() => GetUsersUseCase(sl()));
}

/// Register cubits
void _cubit() {
  sl
    ..registerFactory(() => AuthCubit(sl()))
    ..registerFactory(() => UsersCubit(sl()));
}
