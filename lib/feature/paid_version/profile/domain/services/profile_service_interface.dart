

import '../../../../../data/model/api_response.dart';

abstract class ProfileServiceInterface {
  Future<dynamic> viewUserProfileData();
  Future<dynamic> viewQuestionsList();
  Future<dynamic> viewMotivationList();
  Future<dynamic> viewPersonalityTypeQuestionList();
  Future<dynamic> viewPersonalityTypeCompletedQuestionList();
  Future<dynamic> viewMotivationCompletedAnswerList();
  Future<dynamic> viewCompletedQuestionsList();
  Future<dynamic> getCOTMapperSummary();
  Future<dynamic> viewCOTindividualSummary();
  Future<dynamic> viewSOTmotivationUserList(Map<String, dynamic> loginBody);
  String getUserToken();
  Future<dynamic> updateProfile(Map<String, dynamic> body);
  Future<dynamic> viewPersonalityTypeReport(Map<String, dynamic> body);
  Future<dynamic> viewCOTFunctionalLensDetail(Map<String, dynamic> body);
  Future<dynamic> sendTeamRoleData(Map<String, dynamic> body);
  Future<dynamic> sendPersonalityTypeData(Map<String, dynamic> body);
  Future<dynamic> sendPersonalityCompletedData(Map<String, dynamic> body);
  Future<dynamic> sendMotivationData(Map<String, dynamic> body);
  Future<dynamic> sendMotivationDataUpdate(Map<String, dynamic> body);
  Future<dynamic> sendTeamRoleDataUpdate(Map<String, dynamic> body);
  Future<void> saveUserTeamRoleData(String userData);
  Future<void> saveUserMotivationData(String userData);
  Future<void> saveUserPersonalityTypeData(String userData);
  String getUserTeamRoleData();
  String getUserMotivationData();
  String getUserPersonalityTypeData();
  Future<void> clearSavedUserTeamRoleData();
  Future<void> clearSavedUserMotivationData();
  Future<void> clearSavedPersonalityTypeData();
  Future<ApiResponse> viewActionList(Map<String, dynamic> body);
  Future<ApiResponse> updateActionItemStatus(Map<String, dynamic> body);
  Future<ApiResponse> deleteActionItemStatus(Map<String, dynamic> body);
  Future<ApiResponse> viewDepartmentUserList(Map<String, dynamic> body);
  Future<ApiResponse> viewUserByTypeList(Map<String, dynamic> body);
  Future<ApiResponse> viewThemeList(Map<String, dynamic> body);
  Future<ApiResponse> addActionData(Map<String, dynamic> body);
  Future<ApiResponse> updateActionData(Map<String, dynamic> body);
  Future<ApiResponse> viewCommentList(Map<String, dynamic> body);
  Future<ApiResponse> addCommentList(Map<String, dynamic> body);
  Future<ApiResponse> viewActionTierList();
}
