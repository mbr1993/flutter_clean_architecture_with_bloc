import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_with_bloc/core/errors/failures.dart';
import 'package:flutter_clean_architecture_with_bloc/core/network/api_endpoint_urls.dart';
import 'package:flutter_clean_architecture_with_bloc/core/network/dio_client.dart';
import 'package:flutter_clean_architecture_with_bloc/src/users/data/models/users_model.dart';
import 'package:flutter_clean_architecture_with_bloc/src/users/domain/use_cases/use_cases.dart';

mixin UsersRemoteDataSource {
  Future<Either<Failure, UsersModel>> getUsers(UsersParam usersParam);
}

class UsersRemoteDataSourceImpl implements UsersRemoteDataSource {
  UsersRemoteDataSourceImpl(this._dioClient);

  final DioClient _dioClient;

  @override
  Future<Either<Failure, UsersModel>> getUsers(UsersParam usersParam) async {
    final response = await _dioClient.getRequest(
      ApiEndpointUrls.users,
      queryParameters: usersParam.toJson(),
      converter: (response) {
        return UsersModel.fromJson(response as Map<String, dynamic>);
      },
    );

    return response;
  }
}
