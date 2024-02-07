import 'package:flutter_clean_architecture_with_bloc/core/network/dio_client.dart';
import 'package:flutter_clean_architecture_with_bloc/core/network/network_info.dart';
import 'package:flutter_clean_architecture_with_bloc/src/auth/data/data_sources/auth_local_data_sources.dart';
import 'package:flutter_clean_architecture_with_bloc/src/auth/data/data_sources/auth_remote_data_sources.dart';
import 'package:flutter_clean_architecture_with_bloc/src/auth/data/repositories/auth_repositories_imp.dart';
import 'package:flutter_clean_architecture_with_bloc/src/auth/domain/repositories/auth_repositories.dart';
import 'package:flutter_clean_architecture_with_bloc/src/auth/domain/use_cases/login.dart';
import 'package:flutter_clean_architecture_with_bloc/src/auth/domain/use_cases/logout.dart';
import 'package:flutter_clean_architecture_with_bloc/src/auth/domain/use_cases/register.dart';
import 'package:flutter_clean_architecture_with_bloc/src/auth/presentation/login/cubit/auth_cubit.dart';
import 'package:flutter_clean_architecture_with_bloc/src/users/data/data_sources/users_remote_data_sources.dart';
import 'package:flutter_clean_architecture_with_bloc/src/users/data/repositories/users_repositories_imp.dart';
import 'package:flutter_clean_architecture_with_bloc/src/users/domain/repositories/users_repositories.dart';
import 'package:flutter_clean_architecture_with_bloc/src/users/domain/use_cases/get_users.dart';
import 'package:flutter_clean_architecture_with_bloc/src/users/presentation/cubit/users_cubit.dart';
import 'package:flutter_clean_architecture_with_bloc/utils/services/hive.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

Future<void> serviceLocator() async {
  sl.registerSingleton<DioClient>(DioClient());
  _repositories();
  _dataSources();
  _useCase();
  _cubit();
  _network();
  await _initHive();
}

/// Register Hive
Future<void> _initHive() async {
  await HiveService.initHive();
  sl.registerSingleton<HiveService>(HiveService());
}

/// Register repositories
void _repositories() {
  sl
    ..registerLazySingleton<AuthRepositories>(() => AuthRepositoriesImp(sl(), sl(), sl()))
    ..registerLazySingleton<UsersRepositories>(() => UsersRepositoriesImp(sl()));
}

/// Network
void _network() => sl.registerLazySingleton<NetworkInfo>(NetworkInfoImpl.new);

/// Register dataSources
void _dataSources() {
  sl
    ..registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(sl()))
    ..registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(sl()))
    ..registerLazySingleton<UsersRemoteDataSource>(() => UsersRemoteDataSourceImpl(sl()));
}

/// Register useCases
void _useCase() {
  sl
    ..registerLazySingleton(() => LoginUseCase(sl()))
    ..registerLazySingleton(() => LogoutUseCase(sl()))
    ..registerLazySingleton(() => RegisterUseCase(sl()))
    ..registerLazySingleton(() => GetUsersUseCase(sl()));
}

/// Register cubits
void _cubit() {
  sl
    ..registerFactory(() => AuthCubit(sl(), sl()))
    ..registerFactory(() => UsersCubit(sl()));
}
