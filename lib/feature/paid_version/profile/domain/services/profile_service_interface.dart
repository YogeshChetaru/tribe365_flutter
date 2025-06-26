

abstract class ProfileServiceInterface {
  Future<dynamic> viewUserProfileData();
  Future<dynamic> viewQuestionsList();
  String getUserToken();
  Future<dynamic> updateProfile(Map<String, dynamic> body);
}
