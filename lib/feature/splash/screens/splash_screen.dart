import 'package:flutter/material.dart';
import 'package:tribe365_new/feature/login/screens/login_screen.dart';
import '../../../main.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/images.dart';

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
      _route();
    });
  }
  void _route() {
    Navigator.of(Get.context!).pushReplacement(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        reverseTransitionDuration: Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) =>
        const LoginScreen(),
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
}
