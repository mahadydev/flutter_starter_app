import 'package:dio/dio.dart';
import 'package:flutter_starter_app/core/constants/api_endpoints.dart';
import 'package:flutter_starter_app/core/constants/app_constants.dart';
import 'package:flutter_starter_app/core/errors/error_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioModule {
  Dio provideDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: AppConstants.apiConnectTimeout),
        receiveTimeout: const Duration(seconds: AppConstants.apiReceiveTimeout),
      ),
    );

    // Interceptors
    dio.interceptors.add(
      PrettyDioLogger(requestHeader: true, requestBody: true),
    );
    dio.interceptors.add(ErrorInterceptor());

    return dio;
  }
}
