import 'package:flutter/material.dart';
import '../domain/services/login_service_interface.dart';

class LoginController extends ChangeNotifier {
  final LoginServiceInterface? loginServiceInterface;

  LoginController({required this.loginServiceInterface});

  bool isLoginUser = true;

  bool obscurePasswordText = true;
  bool obscureConfPasswordText = true;

  void togglePasswordVisibility() {
    obscurePasswordText = !obscurePasswordText;
    notifyListeners();
  }

  void toggleConfPasswordVisibility() {
    obscureConfPasswordText = !obscureConfPasswordText;
    notifyListeners();
  }


  void updateIsLogin(String s)
  {
    if(s=="newUser"){
      isLoginUser = false;
    }
    else{
      isLoginUser = true;
    }
    notifyListeners();
  }


}
