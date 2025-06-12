import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:tribe365_new/feature/free_version/free_dashboard/screens/free_dashboard_screen.dart';
import 'package:tribe365_new/feature/login/domain/models/login_model.dart';
import 'package:tribe365_new/feature/login/screens/login_screen.dart';
import 'package:tribe365_new/feature/paid_version/paid_dashboard/screens/paid_dashboard_screen.dart';
import 'package:tribe365_new/utill/app_constants.dart';
import 'package:tribe365_new/utill/custom_route.dart';
import '../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../data/model/api_response.dart';
import '../../../helper/api_checker.dart';
import '../../../main.dart';
import '../domain/models/login_response_model.dart';
import '../domain/services/login_service_interface.dart';

class LoginController extends ChangeNotifier {
  final LoginServiceInterface? loginServiceInterface;

  LoginController({required this.loginServiceInterface});

  bool isLoginUser = true;

  bool obscurePasswordText = true;
  bool obscureConfPasswordText = true;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  String? fcmToken;

  void togglePasswordVisibility() {
    obscurePasswordText = !obscurePasswordText;
    notifyListeners();
  }

  void toggleConfPasswordVisibility() {
    obscureConfPasswordText = !obscureConfPasswordText;
    notifyListeners();
  }

  void updateIsLogin(String s) {
    if (s == "newUser") {
      isLoginUser = false;
    } else {
      isLoginUser = true;
    }
    notifyListeners();
  }

  Future<String?> getDeviceToken() async {
    if (kIsWeb) {
      fcmToken = await FirebaseMessaging.instance.getToken(vapidKey: "BCpqau3wqZhJgjAJc4FwT5HQohcyqNk2iKjMcNtZQNq2UxwB3TVnCZdomZTUSSQYQUIGbdHnw4_tAiMa_I491iw");
    } else {
      if (Platform.isIOS) {
        fcmToken = await FirebaseMessaging.instance.getAPNSToken();
        fcmToken ??= await FirebaseMessaging.instance.getToken();
      } else {
        fcmToken = await FirebaseMessaging.instance.getToken();
      }
    }

    if (fcmToken != null) {
      log('--------Device Token---------- $fcmToken');
    } else {
      log('--------Device Token is NULL--------');
    }
    notifyListeners();
    return fcmToken;
  }

  int getDeviceType() {
    if (kIsWeb) {
      return 0; // Web (you can return any code you want, e.g. 3 for Web)
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 1; // Android
      case TargetPlatform.iOS:
        return 2; // iOS
      default:
        return 0; // Unknown or unsupported platform
    }
  }

  Future<String?> getDeviceId() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        return androidInfo.id; // OR androidInfo.androidId (usually better for unique device ID)
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        return iosInfo.identifierForVendor; // Unique ID on iOS devices
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Failed to get device ID: $e');
      return null;
    }
  }

  bool isLoggedIn() {
    return loginServiceInterface!.isLoggedIn()==true?true:false;
  }

  String userLoginType() {
    return loginServiceInterface!.userLoginType().isEmpty?"":loginServiceInterface!.userLoginType();
  }


  //API calling

  Future<void> login(String username, String password) async {
    String? deviceId = await getDeviceId();
    _isLoading = true;
    notifyListeners();
    LoginModel loginModel = LoginModel(email: username, password: password, deviceId: deviceId, deviceType: getDeviceType().toString(), fcmToken: fcmToken, role: AppConstants.userRole);
    ApiResponse apiResponse = await loginServiceInterface!.login(loginModel.toJson());
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      LoginResponse loginResponse = LoginResponse.fromJson(map);

      String userDataString = jsonEncode(map["data"]);
      showCustomSnackBar(loginResponse.message, Get.context!, isError: false);
      if(loginResponse.data!.token != null && loginResponse.data!.token!.isNotEmpty){
        loginServiceInterface!.saveUserToken(
            loginResponse.data!.token!,
            loginResponse.data!.appPaymentVersion!,
            userDataString
        );
      }

      if (loginResponse.data!.role=="3") {
        if (loginResponse.data!.appPaymentVersion==1){
          routePushAndRemoveUntil(Get.context!, FreeDashboardScreen());
        }else if (loginResponse.data!.appPaymentVersion==3){
          routePushAndRemoveUntil(Get.context!, PaidDashboardScreen());
        }
      }
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!,isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> forgotPassword(String email) async {
    _isLoading = true;
    notifyListeners();
    LoginModel loginModel = LoginModel(email: email);
    ApiResponse apiResponse = await loginServiceInterface!.forgotPassword(loginModel.toJson());
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      LoginResponse loginResponse = LoginResponse.fromJson(map);

      showCustomSnackBar(loginResponse.message, Get.context!, isError: false);

      routePushAndRemoveUntil(Get.context!, LoginScreen());
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!,isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> signup(String username, String password) async {
    _isLoading = true;
    notifyListeners();
    LoginModel loginModel = LoginModel(email: username, password: password);
    ApiResponse apiResponse = await loginServiceInterface!.userSetPassword(loginModel.toJson());
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      int code = map['code'];
      String message = map['message'] ?? '';
      if(code==200){
        login(username, password);
      }else{
        showCustomSnackBar(message, Get.context!,isError: true);
      }
    } else {
      Map<String, dynamic> map = apiResponse.response!.data;
      String message = map['message'] ?? '';
      showCustomSnackBar(message, Get.context!,isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await loginServiceInterface!.logout();
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      LoginResponse loginResponse = LoginResponse.fromJson(map);
      loginServiceInterface!.clearUserData();
      showCustomSnackBar(loginResponse.message, Get.context!, isError: false);
      routePushAndRemoveUntil(Get.context!, LoginScreen());
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!,isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }
}
