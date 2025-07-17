

import '../../../../../data/model/api_response.dart';
import '../repositories/profile_repository_interface.dart';
import 'profile_service_interface.dart';

class ProfileService implements ProfileServiceInterface {
  ProfileRepositoryInterface profileRepositoryInterface;

  ProfileService({required this.profileRepositoryInterface});

  @override
  Future<ApiResponse> viewUserProfileData() {
    return profileRepositoryInterface.viewUserProfileData();
  }
  @override
  String getUserToken() {
    return profileRepositoryInterface.getUserToken();
  }


  @override
  Future<ApiResponse> updateProfile(Map<String, dynamic> body) {
    return profileRepositoryInterface.updateProfile(body);
  }

  @override
  Future<ApiResponse> viewPersonalityTypeReport(Map<String, dynamic> body) {
    return profileRepositoryInterface.viewPersonalityTypeReport(body);
  }

  @override
  Future<ApiResponse> viewCOTFunctionalLensDetail(Map<String, dynamic> body) {
    return profileRepositoryInterface.viewCOTFunctionalLensDetail(body);
  }


  @override
  Future<ApiResponse> viewQuestionsList() {
    return profileRepositoryInterface.viewQuestionsList();
  }

  @override
  Future<ApiResponse> viewMotivationList() {
    return profileRepositoryInterface.viewMotivationList();
  }

  @override
  Future<ApiResponse> viewPersonalityTypeQuestionList() {
    return profileRepositoryInterface.viewPersonalityTypeQuestionList();
  }
  @override
  Future<ApiResponse> viewPersonalityTypeCompletedQuestionList() {
    return profileRepositoryInterface.viewPersonalityTypeCompletedQuestionList();
  }


  @override
  Future<ApiResponse> viewMotivationCompletedAnswerList() {
    return profileRepositoryInterface.viewMotivationCompletedAnswerList();
  }


  @override
  Future<ApiResponse> viewCompletedQuestionsList() {
    return profileRepositoryInterface.viewCompletedQuestionsList();
  }

  @override
  Future<ApiResponse> getCOTMapperSummary() {
    return profileRepositoryInterface.getCOTMapperSummary();
  }

  @override
  Future<void> saveUserTeamRoleData(String userData) {
    return profileRepositoryInterface.saveUserTeamRoleData(userData);
  }

  @override
  Future<void> saveUserMotivationData(String userData) {
    return profileRepositoryInterface.saveUserMotivationData(userData);
  }

  @override
  Future<void> saveSotQuestionListData(String userData) {
    return profileRepositoryInterface.saveSotQuestionListData(userData);
  }

  @override
  String getUserTeamRoleData() {
    return profileRepositoryInterface.getUserTeamRoleData();
  }

  @override
  String getUserMotivationData() {
    return profileRepositoryInterface.getUserMotivationData();
  }

  @override
  String getUserPersonalityTypeData() {
    return profileRepositoryInterface.getUserPersonalityTypeData();
  }

  @override
  String getSotQuestionListData() {
    return profileRepositoryInterface.getSotQuestionListData();
  }

  @override
  String getDiagnosticListData() {
    return profileRepositoryInterface.getDiagnosticListData();
  }

  @override
  String getTribeMeterQuestionListData() {
    return profileRepositoryInterface.getTribeMeterQuestionListData();
  }

  @override
  Future<ApiResponse> sendTeamRoleData(Map<String, dynamic> body) {
    return profileRepositoryInterface.sendTeamRoleData(body);
  }

  @override
  Future<ApiResponse> sendPersonalityCompletedData(Map<String, dynamic> body) {
    return profileRepositoryInterface.sendPersonalityCompletedData(body);
  }


  @override
  Future<ApiResponse> sendPersonalityTypeData(Map<String, dynamic> body) {
    return profileRepositoryInterface.sendPersonalityTypeData(body);
  }


  @override
  Future<ApiResponse> sendTeamRoleDataUpdate(Map<String, dynamic> body) {
    return profileRepositoryInterface.sendTeamRoleDataUpdate(body);
  }

  @override
  Future<ApiResponse> sendSotQuestionListData(Map<String, dynamic> body) {
    return profileRepositoryInterface.sendSotQuestionListData(body);
  }

  @override
  Future<ApiResponse> sendTribeMeterQuestionCompleteListData(Map<String, dynamic> body) {
    return profileRepositoryInterface.sendTribeMeterQuestionCompleteListData(body);
  }



  @override
  Future<void> saveUserPersonalityTypeData(String userData) {
    return profileRepositoryInterface.saveUserPersonalityTypeData(userData);
  }

  @override
  Future<void> saveDiagnosticQuestionListData(String userData) {
    return profileRepositoryInterface.saveDiagnosticQuestionListData(userData);
  }

  @override
  Future<void> saveTribeMeterQuestionListData(String userData) {
    return profileRepositoryInterface.saveTribeMeterQuestionListData(userData);
  }

  @override
  Future<void> clearSavedUserTeamRoleData() {
    return profileRepositoryInterface.clearSavedUserTeamRoleData();
  }

  @override
  Future<void> clearSavedUserMotivationData() {
    return profileRepositoryInterface.clearSavedUserMotivationData();
  }

  @override
  Future<void> clearSavedPersonalityTypeData() {
    return profileRepositoryInterface.clearSavedPersonalityTypeData();
  }

  @override
  Future<void> clearSotQuestionListData() {
    return profileRepositoryInterface.clearSotQuestionListData();
  }

  @override
  Future<void> clearDiagnosticQuestionListData() {
    return profileRepositoryInterface.clearDiagnosticQuestionListData();
  }

  @override
  Future<void> clearTribeMeterQuestionListData() {
    return profileRepositoryInterface.clearTribeMeterQuestionListData();
  }

  @override
  Future<ApiResponse> sendMotivationData(Map<String, dynamic> body) {
    return profileRepositoryInterface.sendMotivationData(body);
  }

  @override
  Future<ApiResponse> sendMotivationDataUpdate(Map<String, dynamic> body) {
    return profileRepositoryInterface.sendMotivationDataUpdate(body);
  }

  @override
  Future<ApiResponse> sendSotQuestionListCompletedData(Map<String, dynamic> body) {
    return profileRepositoryInterface.sendSotQuestionListCompletedData(body);
  }

  @override
  Future<ApiResponse> sendDiagnosticQuestionListData(Map<String, dynamic> body) {
    return profileRepositoryInterface.sendDiagnosticQuestionListData(body);
  }


  @override
  Future<ApiResponse> sendDiagnosticCompletedQuestionListData(Map<String, dynamic> body) {
    return profileRepositoryInterface.sendDiagnosticCompletedQuestionListData(body);
  }

  @override
  Future<ApiResponse> sendTribeMeterQuestionListData(Map<String, dynamic> body) {
    return profileRepositoryInterface.sendTribeMeterQuestionListData(body);
  }



  @override
  Future<void> viewSOTmotivationUserList(Map<String, dynamic> loginBody) {
    return profileRepositoryInterface.viewSOTmotivationUserList(loginBody);
  }

  @override
  Future<void> viewTribeMeterQuestionList() {
    return profileRepositoryInterface.viewTribeMeterQuestionList();
  }

  @override
  Future<void> viewTribeMeterQuestionCompletedList() {
    return profileRepositoryInterface.viewTribeMeterQuestionCompletedList();
  }


  @override
  Future<void> viewCOTindividualSummary() {
    return profileRepositoryInterface.viewCOTindividualSummary();
  }

  @override
  Future<ApiResponse> viewActionList(Map<String, dynamic> body) {
    return profileRepositoryInterface.viewActionList(body);
  }

  @override
  Future<ApiResponse> updateActionItemStatus(Map<String, dynamic> body) {
    return profileRepositoryInterface.updateActionItemStatus(body);
  }

  @override
  Future<ApiResponse> deleteActionItemStatus(Map<String, dynamic> body) {
    return profileRepositoryInterface.deleteActionItemStatus(body);
  }

  @override
  Future<ApiResponse> viewActionTierList() {
    return profileRepositoryInterface.viewActionTierList();
  }

  @override
  Future<ApiResponse> viewDepartmentUserList(Map<String, dynamic> body) {
    return profileRepositoryInterface.viewDepartmentUserList(body);
  }

  @override
  Future<ApiResponse> viewUserByTypeList(Map<String, dynamic> body) {
    return profileRepositoryInterface.viewUserByTypeList(body);
  }

  @override
  Future<ApiResponse> viewThemeList(Map<String, dynamic> body) {
    return profileRepositoryInterface.viewThemeList(body);
  }

  @override
  Future<ApiResponse> addActionData(Map<String, dynamic> body) {
    return profileRepositoryInterface.addActionData(body);
  }

  @override
  Future<ApiResponse> updateActionData(Map<String, dynamic> body) {
    return profileRepositoryInterface.updateActionData(body);
  }

  @override
  Future<ApiResponse> viewCommentList(Map<String, dynamic> body) {
    return profileRepositoryInterface.viewCommentList(body);
  }

  @override
  Future<ApiResponse> addCommentList(Map<String, dynamic> body) {
    return profileRepositoryInterface.addCommentList(body);
  }

  @override
  Future<ApiResponse> viewOrgDashboardReportWithFilter(Map<String, dynamic> body) {
    return profileRepositoryInterface.viewOrgDashboardReportWithFilter(body);
  }
  @override
  Future<ApiResponse> viewOfficeList(Map<String, dynamic> body) {
    return profileRepositoryInterface.viewOfficeList(body);
  }
  @override
  Future<ApiResponse> viewDepartmentList() {
    return profileRepositoryInterface.viewDepartmentList();
  }

  @override
  Future<ApiResponse> viewSotQuestionList() {
    return profileRepositoryInterface.viewSotQuestionList();
  }

  @override
  Future<ApiResponse> viewSotQuestionCompletedList() {
    return profileRepositoryInterface.viewSotQuestionCompletedList();
  }

  @override
  Future<ApiResponse> viewDiagnosticQuestionList() {
    return profileRepositoryInterface.viewDiagnosticQuestionList();
  }
  @override
  Future<ApiResponse> viewDiagnosticCompletedQuestionList() {
    return profileRepositoryInterface.viewDiagnosticCompletedQuestionList();
  }
  @override
  Future<ApiResponse> viewSupportHistoryList(Map<String, dynamic> body) {
    return profileRepositoryInterface.viewSupportHistoryList(body);
  }

  @override
  Future<ApiResponse> addCustomerSupport(Map<String, dynamic> body) {
    return profileRepositoryInterface.addCustomerSupport(body);
  }

  @override
  Future<ApiResponse> viewChatMessages(Map<String, dynamic> body) {
    return profileRepositoryInterface.viewChatMessages(body);
  }

  @override
  Future<ApiResponse> sendChatMessages(Map<String, dynamic> body) {
    return profileRepositoryInterface.sendChatMessages(body);
  }

  @override
  Future<ApiResponse> updatePushNotificationStatus(Map<String, dynamic> body) {
    return profileRepositoryInterface.updatePushNotificationStatus(body);
  }

  @override
  Future<ApiResponse> viewActionDetail(Map<String, dynamic> body) {
    return profileRepositoryInterface.viewActionDetail(body);
  }


}
