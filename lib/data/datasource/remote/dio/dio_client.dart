import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tribe365_new/data/datasource/remote/dio/retry_interceptor.dart';

import '../../../../utill/app_constants.dart';
import 'logging_interceptor.dart';

class DioClient {
  final String baseUrl;
  final LoggingInterceptor loggingInterceptor;
  final SharedPreferences sharedPreferences;

  late Dio dio;
  String? token;
  String? countryCode;

  DioClient(
    this.baseUrl,
    Dio? dioC, {
    required this.loggingInterceptor,
    required this.sharedPreferences,
  }) {
    token = sharedPreferences.getString(AppConstants.userLoginToken);
    countryCode = sharedPreferences.getString(AppConstants.countryCode) ?? AppConstants.languages[0].countryCode;

    dio = dioC ?? Dio();
    dio
      ..options = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30), // Faster failure detection
        receiveTimeout: const Duration(seconds: 30), // Reduce API delay
        headers: _buildHeaders(),
      )
      ..interceptors.addAll([
        loggingInterceptor,
        RetryInterceptor(dio: dio, maxRetries: 3),

      ]);

    if (kDebugMode) {
      debugPrint("Initialized DioClient with token: $token");
    }
  }

  Map<String, String> _buildHeaders() {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token != null ? 'Bearer $token' : '',
      'Accept': 'application/json',
      "Accept-Encoding": 'gzip, deflate, br',
      AppConstants.langKey: countryCode == 'US' ? 'en' : countryCode!.toLowerCase(),
    };
  }

  void updateHeader(String? newToken, String? newCountryCode) {
    token = newToken ?? token;
    countryCode = newCountryCode?.toLowerCase() ?? countryCode?.toLowerCase();

    if (newCountryCode == 'US') {
      countryCode = 'en';
    }

    dio.options.headers = _buildHeaders();
    if (kDebugMode) {
      debugPrint("Updated headers: ${dio.options.headers}");
    }
  }

  Future<Response> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _handleRequest(() => dio.get(
          uri,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
        ));
  }

  Future<Response> post(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _handleRequest(() => dio.post(
          uri,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        ));
  }

  Future<Response> put(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _handleRequest(() => dio.put(
          uri,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        ));
  }

  Future<Response> delete(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _handleRequest(() => dio.delete(
          uri,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ));
  }

  Future<Response> _handleRequest(Future<Response> Function() request) async {
    try {
      return await request();
    } on SocketException {
      throw const SocketException("No Internet connection");
    } on FormatException {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      debugPrint("Request error: $e");
      rethrow;
    }
  }
}
