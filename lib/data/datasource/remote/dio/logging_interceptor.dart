import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart'; // For kDebugMode

class LoggingInterceptor extends Interceptor {
  final int maxCharactersPerLine = 200;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      print("--> ${options.method} ${options.uri}");
      print("Headers: ${options.headers}");
      if (options.data != null) {
        print("Body: ${options.data}");
      }
    }
    handler.next(options); // Continue request
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print("<-- ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}");
      String responseAsString = response.data.toString();

      if (responseAsString.length > maxCharactersPerLine) {
        int iterations = (responseAsString.length / maxCharactersPerLine).floor();
        for (int i = 0; i <= iterations; i++) {
          int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
          if (endingIndex > responseAsString.length) {
            endingIndex = responseAsString.length;
          }
          print(responseAsString.substring(i * maxCharactersPerLine, endingIndex));
        }
      } else {
        print(responseAsString);
      }
      print("<-- END HTTP");
    }
    handler.next(response); // Continue response
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print("❌ ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}");
      print("Message: ${err.message}");
      if (err.response?.data != null) {
        print("Response Data: ${err.response?.data}");
      }
    }
    handler.next(err); // Continue error handling
  }
}
