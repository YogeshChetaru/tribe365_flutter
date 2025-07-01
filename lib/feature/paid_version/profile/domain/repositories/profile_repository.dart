import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../data/datasource/remote/dio/dio_client.dart';
import '../../../../../data/datasource/remote/exception/api_error_handler.dart';
import '../../../../../data/model/api_response.dart';
import '../../../../../utill/app_constants.dart';
import 'profile_repository_interface.dart';

class ProfileRepository implements ProfileRepositoryInterface {
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;

  ProfileRepository({required this.dioClient, required this.sharedPreferences});

  @override
  Future<ApiResponse> updateProfile(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.updateUserProfileUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> viewUserProfileData() async {
    try {
      Response response = await dioClient!.get(
        AppConstants.userProfileUri,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> viewQuestionsList() async {
    try {
      Response response = await dioClient!.get(
        AppConstants.getCOTQuestionsUri,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> viewPersonalityTypeQuestionList() async {
    try {
      Response response = await dioClient!.get(
        AppConstants.getPersonalityTypeQuestionListUri,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> viewMotivationList() async {
    try {
      Response response = await dioClient!.get(
        AppConstants.getSOTmotivationQuestionsUri,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> viewMotivationCompletedAnswerList() async {
    try {
      Response response = await dioClient!.get(
        AppConstants.getSOTmotivationCompletedAnswerUri,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> viewCompletedQuestionsList() async {
    try {
      Response response = await dioClient!.get(
        AppConstants.getCOTteamRoleCompletedAnswersUri,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> viewCOTindividualSummary() async {
    try {
      Response response = await dioClient!.get(
        AppConstants.getCOTindividualSummaryUri,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> viewSOTmotivationUserList(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.getSOTmotivationUserListUri,
      data: loginBody
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> getCOTMapperSummary() async {
    try {
      Response response = await dioClient!.get(
        AppConstants.getCOTMapperSummaryUri,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  String getUserToken() {
    return sharedPreferences!.getString(AppConstants.userLoginToken) ?? "";
  }

  @override
  Future<void> saveUserTeamRoleData(String userData) async {
    try {
      await sharedPreferences!
          .setString(AppConstants.userTeamRoleData, userData);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveUserMotivationData(String userData) async {
    try {
      await sharedPreferences!.setString(AppConstants.userMotivationData, userData);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveUserPersonalityTypeData(String userData) async {
    try {
      await sharedPreferences!.setString(AppConstants.userPersonalityTypeData, userData);
    } catch (e) {
      rethrow;
    }
  }

  @override
  String getUserTeamRoleData() {
    return sharedPreferences!.getString(AppConstants.userTeamRoleData) ?? "";
  }

  @override
  String getUserMotivationData() {
    return sharedPreferences!.getString(AppConstants.userMotivationData) ?? "";
  }

  @override
  String getUserPersonalityTypeData() {
    return sharedPreferences!.getString(AppConstants.userPersonalityTypeData) ?? "";
  }

  @override
  Future<void> clearSavedUserTeamRoleData() async {
    sharedPreferences!.remove(AppConstants.userTeamRoleData);
  }

  @override
  Future<void> clearSavedUserMotivationData() async {
    sharedPreferences!.remove(AppConstants.userMotivationData);
  }

  @override
  Future<void> clearSavedPersonalityTypeData() async {
    sharedPreferences!.remove(AppConstants.userPersonalityTypeData);
  }

  @override
  Future<ApiResponse> sendTeamRoleData(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.addCOTAnswerUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> sendPersonalityTypeData(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.addPersonalityTypeAnswersUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> sendMotivationData(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.addSOTmotivationAnswerUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> sendMotivationDataUpdate(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.updateSOTmotivationAnswersUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> sendTeamRoleDataUpdate(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.updateCOTTeamRoleMapAnswersUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
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
