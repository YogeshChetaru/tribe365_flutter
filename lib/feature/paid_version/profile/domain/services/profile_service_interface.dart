

abstract class ProfileServiceInterface {
  Future<dynamic> viewUserProfileData();
  Future<dynamic> viewQuestionsList();
  Future<dynamic> viewMotivationList();
  Future<dynamic> viewMotivationCompletedAnswerList();
  Future<dynamic> viewCompletedQuestionsList();
  Future<dynamic> getCOTMapperSummary();
  Future<dynamic> viewCOTindividualSummary();
  Future<dynamic> viewSOTmotivationUserList(Map<String, dynamic> loginBody);
  String getUserToken();
  Future<dynamic> updateProfile(Map<String, dynamic> body);
  Future<dynamic> sendTeamRoleData(Map<String, dynamic> body);
  Future<dynamic> sendMotivationData(Map<String, dynamic> body);
  Future<dynamic> sendTeamRoleDataUpdate(Map<String, dynamic> body);
  Future<void> saveUserTeamRoleData(String userData);
  Future<void> saveUserMotivationData(String userData);
  String getUserTeamRoleData();
  String getUserMotivationData();
  Future<void> clearSavedUserTeamRoleData();
  Future<void> clearSavedUserMotivationData();
}
