import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/login/controllers/login_controller.dart';
import 'package:tribe365_new/feature/login/screens/login_screen.dart';
import '../../../main.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/images.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../free_version/free_dashboard/screens/free_dashboard_screen.dart';
import '../../paid_version/paid_dashboard/screens/paid_dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldMessengerState> globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      LoginController loginController = Provider.of<LoginController>(Get.context!,listen: false);
      if(loginController.isLoggedIn()){
        if (loginController.userLoginType()=="1"){
          _route(const FreeDashboardScreen());
        }else if (loginController.userLoginType()=="3"){
          _route(const PaidDashboardScreen());
        }
      }
      else{
        _route(const LoginScreen());
      }
      getDeviceToken();
    });

  }
  void _route(Widget screen) {
    Navigator.of(Get.context!).pushReplacement(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        reverseTransitionDuration: Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // from right
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          final offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      key: globalKey,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: ColorResources.white,
          child: Center(
            child: Image.asset(
              Images.splashLogo,
              width: MediaQuery.of(context).size.width / 1.5,
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> getDeviceToken() async {
    String? deviceToken;

    if (kIsWeb) {
      deviceToken = await FirebaseMessaging.instance.getToken(vapidKey: "BCpqau3wqZhJgjAJc4FwT5HQohcyqNk2iKjMcNtZQNq2UxwB3TVnCZdomZTUSSQYQUIGbdHnw4_tAiMa_I491iw");
    } else {
      if (Platform.isIOS) {
        deviceToken = await FirebaseMessaging.instance.getAPNSToken();
        deviceToken ??= await FirebaseMessaging.instance.getToken();
      } else {
        deviceToken = await FirebaseMessaging.instance.getToken();
      }
    }

    if (deviceToken != null) {
      log('--------Device Token---------- $deviceToken');
    } else {
      log('--------Device Token is NULL--------');
    }

    return deviceToken;
  }
}
