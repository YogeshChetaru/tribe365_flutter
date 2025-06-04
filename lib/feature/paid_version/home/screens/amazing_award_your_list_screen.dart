import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../controllers/home_controller.dart';

class AmazingAwardYourListScreen extends StatefulWidget {
  const AmazingAwardYourListScreen({super.key});

  @override
  AmazingAwardYourListScreenState createState() => AmazingAwardYourListScreenState();
}

class AmazingAwardYourListScreenState extends State<AmazingAwardYourListScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Consumer<HomeController>(builder: (context, homeProvider, _) {
          return Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            color: ColorResources.screenBg,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: ColorResources.white,
                    boxShadow: [
                      BoxShadow(
                        color: ColorResources.colorAAADC4,
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  width: MediaQuery.sizeOf(context).width,
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            Images.imgCircleBackRed,
                            width: 24,
                            height: 24,
                          )),
                      Expanded(child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          getTranslated("amazing_awards", context)!,
                          style: TextStyle(
                            fontSize: Dimensions.sp18,
                            fontWeight:FontWeight.w600,
                            color: ColorResources.black,
                          ),
                        ),
                      )),
                      SizedBox(
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 20, 15,0),
                          width: MediaQuery.sizeOf(context).width,
                          padding: EdgeInsets.fromLTRB(15, 20,15, 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Colors.black12,
                                offset: Offset(0, 2),
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getTranslated("amazing_awards", context)!,
                                style: TextStyle(
                                  fontSize: Dimensions.sp16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'roboto',
                                  color: ColorResources.black,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width,
                                alignment: Alignment.center,
                                child: Text(
                                  textAlign: TextAlign.center,
                                  getTranslated("no_award_received_yet", context)!,
                                  style: TextStyle(
                                    fontSize: Dimensions.sp14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'roboto',
                                    color: ColorResources.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  void route(BuildContext context, Widget screen) {
    Navigator.of(context).push(
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

  void showDialog(BuildContext context, Widget workNotDialog) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        barrierColor: Colors.black54,
        pageBuilder: (context, animation, secondaryAnimation) {
          return Center(child: workNotDialog);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // From right
          const end = Offset(-1.0, 0.0); // To left when popping
          final tween = Tween(begin: begin, end: Offset.zero);
          final reverseTween = Tween(begin: Offset.zero, end: end);
          final offsetAnimation = animation.drive(tween);
          final reverseOffset = secondaryAnimation.drive(reverseTween);

          return SlideTransition(
            position: animation.status == AnimationStatus.reverse ? reverseOffset : offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }
}
