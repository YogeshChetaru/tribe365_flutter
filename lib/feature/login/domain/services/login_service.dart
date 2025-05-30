import '../repositories/login_repository_interface.dart';
import 'login_service_interface.dart';

class LoginService implements LoginServiceInterface {
  LoginRepositoryInterface loginRepositoryInterface;

  LoginService({required this.loginRepositoryInterface});
}
