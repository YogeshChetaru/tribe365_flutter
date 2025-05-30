import 'package:dio/dio.dart';

import 'package:flutter/cupertino.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;

  RetryInterceptor({required this.dio, this.maxRetries = 3});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err) && maxRetries > 0) {
      for (int attempt = 1; attempt <= maxRetries; attempt++) {
        try {
          debugPrint("Retrying request ($attempt/$maxRetries)...");

          final response = await dio.request(
            err.requestOptions.path,
            options: Options(
              method: err.requestOptions.method,
              headers: err.requestOptions.headers,
              responseType: err.requestOptions.responseType,
              followRedirects: err.requestOptions.followRedirects,
              contentType: err.requestOptions.contentType,
            ),
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
          );

          return handler.resolve(response);
        } catch (e) {
          debugPrint("Retry failed: $e");
        }
      }
    }
    handler.next(err); // If retries fail, propagate the error
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout;
  }
}
