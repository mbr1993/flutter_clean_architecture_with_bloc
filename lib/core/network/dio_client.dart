import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture_with_bloc/core/errors/failures.dart';
import 'package:flutter_clean_architecture_with_bloc/core/network/api_constant.dart';
import 'package:flutter_clean_architecture_with_bloc/core/network/isolate_parser.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

typedef ResponseConverter<T> = T Function(dynamic response);

class DioClient {
  final BaseOptions _baseOptions = BaseOptions(
    baseUrl: ApiConstant.baseUrl,
    headers: {
      'Content-Type': 'application/json',
      'accept': 'application/json',
    },
    receiveTimeout: const Duration(minutes: 1),
    connectTimeout: const Duration(minutes: 1),
  );

  Dio get dio {
    final dio = Dio(_baseOptions);
    dio.interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true, responseHeader: true));
    return dio;
  }

  Future<Either<Failure, T>> postRequest<T>(
    String url, {
    required ResponseConverter<T> converter,
    Map<String, dynamic>? data,
    bool isIsolate = true,
  }) async {
    try {
      final response = await dio.post<dynamic>(url, data: data);

      if ((response.statusCode ?? 0) < 200 || (response.statusCode ?? 0) > 201) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }

      if (!isIsolate) {
        return Right(converter(response.data));
      }
      final isolateParse = IsolateParser<T>(
        response.data as Map<String, dynamic>,
        converter,
      );
      final result = await isolateParse.parseInBackground();
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  Future<Either<Failure, T>> getRequest<T>(
    String url, {
    required ResponseConverter<T> converter,
    Map<String, dynamic>? queryParameters,
    bool isIsolate = true,
  }) async {
    try {
      final response = await dio.get<dynamic>(
        url,
        queryParameters: queryParameters,
      );
      if ((response.statusCode ?? 0) < 200 || (response.statusCode ?? 0) > 201) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }

      if (!isIsolate) {
        return Right(converter(response.data));
      }
      final isolateParse = IsolateParser<T>(
        response.data as Map<String, dynamic>,
        converter,
      );
      final result = await isolateParse.parseInBackground();
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}