import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/datasource/remote/dio/dio_client.dart';
import '../../../../data/datasource/remote/exception/api_error_handler.dart';
import '../../../../data/model/api_response.dart';
import '../../../../utill/app_constants.dart';
import 'login_repository_interface.dart';

class LoginRepository implements LoginRepositoryInterface {
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;

  LoginRepository({required this.dioClient, required this.sharedPreferences});


  @override
  Future<ApiResponse> login(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.loginUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> forgotPassword(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.forgotPasswordUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> userSetPassword(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.userSetPasswordUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponse> logout() async {
    try {
      Response response = await dioClient!.post(
        AppConstants.logoutUri,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<void> clearUserData() async {
    try {
      await sharedPreferences!.remove(AppConstants.userLoginToken);
      await sharedPreferences!.remove(AppConstants.userLoginStatus);
      await sharedPreferences!.remove(AppConstants.userLoginType);
    } catch (e) {
      rethrow;
    }
  }


  @override
  Future<void> saveUserToken(String token,int userType) async {
    dioClient!.updateHeader(token, null);
    try {
      debugPrint("UserToken >>>>>>$token");
      await sharedPreferences!.setString(AppConstants.userLoginToken, token);
      await sharedPreferences!.setBool(AppConstants.userLoginStatus, true);
      await sharedPreferences!.setString(AppConstants.userLoginType, userType.toString());
    } catch (e) {
      rethrow;
    }
  }

  @override
  bool isLoggedIn() {
    return sharedPreferences?.getBool(AppConstants.userLoginStatus) ?? false;
  }

  @override
  String userLoginType() {
    return sharedPreferences?.getString(AppConstants.userLoginType) ?? "";
  }

  @override
  Future add(value) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future get(String id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future getList({int? offset = 1}) {
    // TODO: implement getList
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body, int id) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
