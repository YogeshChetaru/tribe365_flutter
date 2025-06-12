import '../../../../data/model/api_response.dart';
import '../../../../interface/repo_interface.dart';

abstract class LoginRepositoryInterface implements RepositoryInterface {

  Future<ApiResponse> login(Map<String, dynamic> body);
  Future<ApiResponse> forgotPassword(Map<String, dynamic> body);

  Future<ApiResponse> logout();

  Future<ApiResponse> userSetPassword(Map<String, dynamic> body);

  Future<void> saveUserToken(String token,int userType,String userData);
  Future<void> clearUserData();
  bool isLoggedIn();
  String userLoginType();
}
