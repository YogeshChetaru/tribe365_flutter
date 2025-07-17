import 'package:dio/dio.dart';
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
  Future<ApiResponse> viewPersonalityTypeReport(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.getPersonalityTypeReportUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> viewCOTFunctionalLensDetail(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.getCOTFunctionalLensDetailUri,
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
  Future<ApiResponse> viewPersonalityTypeCompletedQuestionList() async {
    try {
      Response response = await dioClient!.post(
        AppConstants.getPersonalityTypeCompletedAnswersUri,
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
  Future<ApiResponse> viewDiagnosticQuestionList() async {
    try {
      Response response = await dioClient!.get(
          AppConstants.getDiagnosticQuestionListUri,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> viewDiagnosticCompletedQuestionList() async {
    try {
      Response response = await dioClient!.get(
        AppConstants.getDiagnosticCompletedAnswersUri,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> viewTribeMeterQuestionList() async {
    try {
      Response response = await dioClient!.get(
        AppConstants.getTribeMeterQuestionListUri,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> viewTribeMeterQuestionCompletedList() async {
    try {
      Response response = await dioClient!.get(
        AppConstants.getTribeMeterCompletedAnswersUri,
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
  Future<void> saveSotQuestionListData(String userData) async {
    try {
      await sharedPreferences!.setString(AppConstants.userSotQuestionListData, userData);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveDiagnosticQuestionListData(String userData) async {
    try {
      await sharedPreferences!.setString(AppConstants.userDiagnosticQuestionListData, userData);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveTribeMeterQuestionListData(String userData) async {
    try {
      await sharedPreferences!.setString(AppConstants.userTribeMeterQuestionListData, userData);
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
  String getSotQuestionListData() {
    return sharedPreferences!.getString(AppConstants.userSotQuestionListData) ?? "";
  }

  @override
  String getTribeMeterQuestionListData() {
    return sharedPreferences!.getString(AppConstants.userTribeMeterQuestionListData) ?? "";
  }

  @override
  String getDiagnosticListData() {
    return sharedPreferences!.getString(AppConstants.userDiagnosticQuestionListData) ?? "";
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
  Future<void> clearSotQuestionListData() async {
    sharedPreferences!.remove(AppConstants.userSotQuestionListData);
  }

  @override
  Future<void> clearDiagnosticQuestionListData() async {
    sharedPreferences!.remove(AppConstants.userDiagnosticQuestionListData);
  }

  @override
  Future<void> clearTribeMeterQuestionListData() async {
    sharedPreferences!.remove(AppConstants.userTribeMeterQuestionListData);
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
  Future<ApiResponse> sendPersonalityCompletedData(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.updatePersonalityTypeAnswersUri,
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
  Future<ApiResponse> sendSotQuestionListData(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.addSOTanswersUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> sendSotQuestionListCompletedData(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.updateSOTquestionAnswerUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> sendDiagnosticQuestionListData(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.addDiagnosticAnswersUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> sendDiagnosticCompletedQuestionListData(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.updateDiagnosticAnswersUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponse> sendTribeMeterQuestionListData(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.addTribeMeterAnswersUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> sendTribeMeterQuestionCompleteListData(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.updateTribeMeterAnswersUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponse> viewActionList(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.getActionListUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> updateActionItemStatus(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.updateStatusUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> deleteActionItemStatus(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.deleteActionUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> viewActionTierList() async {
    try {
      Response response = await dioClient!.get(
        AppConstants.actionTierListUri,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> viewDepartmentUserList(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.getDepartmentUserListUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> viewUserByTypeList(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.getUserByTypeUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> viewThemeList(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.getThemeListUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> addActionData(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.addActionUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> updateActionData(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.updateActionUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> viewCommentList(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.listCommentUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> addCommentList(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.addCommentUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> viewOrgDashboardReportWithFilter(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.getOrgDashboardReportWithFilterUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> viewOfficeList(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.getAllOfficeDepartmentsUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> viewDepartmentList() async {
    try {
      Response response = await dioClient!.get(
        AppConstants.getDepartmentListUri,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> viewSotQuestionList() async {
    try {
      Response response = await dioClient!.get(
        AppConstants.getSotQuestionListUri,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> viewSotQuestionCompletedList() async {
    try {
      Response response = await dioClient!.get(
        AppConstants.getSOTquestionAnswersUri,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> viewSupportHistoryList(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.getSupportHistoryUri,
        data: loginBody
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> addCustomerSupport(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.addCustomerSupportUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponse> viewChatMessages(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.getUserChatMessagesUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> sendChatMessages(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.sendChatMessageUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> updatePushNotificationStatus(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.updatePushNotificationStatusUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> viewActionDetail(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.getActionDetailUri,
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
