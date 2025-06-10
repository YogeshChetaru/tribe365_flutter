import '../../../../data/model/api_response.dart';
import '../repositories/login_repository_interface.dart';
import 'login_service_interface.dart';

class LoginService implements LoginServiceInterface {
  LoginRepositoryInterface loginRepositoryInterface;

  LoginService({required this.loginRepositoryInterface});

  @override
  Future<ApiResponse> login(Map<String, dynamic> body) {
    return loginRepositoryInterface.login(body);
  }

  @override
  Future<ApiResponse> forgotPassword(Map<String, dynamic> body) {
    return loginRepositoryInterface.forgotPassword(body);
  }

  @override
  Future<ApiResponse> logout() {
    return loginRepositoryInterface.logout();
  }

  @override
  Future<ApiResponse> userSetPassword(Map<String, dynamic> body) {
    return loginRepositoryInterface.userSetPassword(body);
  }

  @override
  Future<void> saveUserToken(String token,int userType) {
    return loginRepositoryInterface.saveUserToken(token,userType);
  }

  @override
  Future<void> clearUserData() {
    return loginRepositoryInterface.clearUserData();
  }

  @override
  bool isLoggedIn() {
    return loginRepositoryInterface.isLoggedIn();
  }

  @override
  String userLoginType() {
    return loginRepositoryInterface.userLoginType();
  }
}
