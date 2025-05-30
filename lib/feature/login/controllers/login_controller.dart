import 'package:flutter/material.dart';
import '../domain/services/login_service_interface.dart';

class LoginController extends ChangeNotifier {
  final LoginServiceInterface? loginServiceInterface;

  LoginController({required this.loginServiceInterface});
}
