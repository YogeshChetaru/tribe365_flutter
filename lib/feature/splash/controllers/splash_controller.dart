import 'package:flutter/material.dart';
import '../domain/services/splash_service_interface.dart';

class SplashController extends ChangeNotifier {
  final SplashServiceInterface? splashServiceInterface;

  SplashController({required this.splashServiceInterface});
}
