

abstract class LoginServiceInterface {
  Future<dynamic> login(Map<String, dynamic> body);
  Future<dynamic> forgotPassword(Map<String, dynamic> body);
  Future<dynamic> logout();
  Future<dynamic> userSetPassword(Map<String, dynamic> body);
  Future<void> saveUserToken(String token,int userType,String userData);
  Future<void> clearUserData();
  bool isLoggedIn();
  String userLoginType();

}
