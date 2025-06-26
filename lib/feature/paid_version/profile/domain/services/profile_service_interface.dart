

abstract class ProfileServiceInterface {
  Future<dynamic> viewUserProfileData();
  Future<dynamic> viewQuestionsList();
  Future<dynamic> getCOTMapperSummary();
  Future<dynamic> viewCOTindividualSummary();
  String getUserToken();
  Future<dynamic> updateProfile(Map<String, dynamic> body);
  Future<dynamic> sendTeamRoleData(Map<String, dynamic> body);
  Future<void> saveUserTeamRoleData(String userData);
  String getUserTeamRoleData();
  Future<void> clearSavedUserTeamRoleData();
}
