import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_with_bloc/core/errors/failures.dart';
import 'package:flutter_clean_architecture_with_bloc/core/network/api_endpoint_urls.dart';
import 'package:flutter_clean_architecture_with_bloc/core/network/dio_client.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/data/models/login_response.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/data/models/register_response.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/domain/use_cases/login.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/domain/use_cases/register.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failure, RegisterResponse>> register(RegisterParams registerParams);

  Future<Either<Failure, LoginResponse>> login(LoginParams loginParams);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._client);

  final DioClient _client;

  @override
  Future<Either<Failure, RegisterResponse>> register(
    RegisterParams registerParams,
  ) async {
    final response = await _client.postRequest(
      ApiEndpointUrls.register,
      data: registerParams.toJson(),
      converter: (data) => RegisterResponse.fromJson(
        data as Map<String, dynamic>,
      ),
    );

    return response;
  }

  @override
  Future<Either<Failure, LoginResponse>> login(LoginParams loginParams) async {
    final response = await _client.postRequest(
      ApiEndpointUrls.login,
      data: loginParams.toJson(),
      converter: (response) => LoginResponse.fromJson(
        response as Map<String, dynamic>,
      ),
    );
    return response;
  }
}
