import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture_with_bloc/utils/app_utils.dart';

InterceptorsWrapper interceptorsWrapper() {
  return InterceptorsWrapper(
    onRequest: (options, handler) {
      //checkConnection();
      AppUtils.myPrint('⬇⬇⬇ onRequest ⬇⬇⬇');
      AppUtils.myPrint(options.uri);
      AppUtils.myPrint(options.headers.toString());
      AppUtils.myPrint(options.data);
      AppUtils.myPrint('⬆⬆⬆ onRequest ⬆⬆⬆');
      return handler.next(options);
    },
    onResponse: (response, handler) {
      AppUtils.myPrint('⬇⬇⬇ onResponse ⬇⬇⬇');
      AppUtils.myPrint('response: $response');
      AppUtils.myPrint('⬆⬆⬆ onResponse ⬆⬆⬆');
      return handler.next(response);
    },
    onError: (e, handler) async {
      if (e.response?.statusCode == 401) {
        // refreshToken();
      }
      AppUtils.myPrint('⬇⬇⬇ onError ⬇⬇⬇');
      AppUtils.myPrint(e.error);
      AppUtils.myPrint(e.response);
      AppUtils.myPrint('⬆⬆⬆ onError ⬆⬆⬆');
      return handler.next(e);
    },
  );
}
