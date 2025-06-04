import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/common/basewidget/custom_header_widget.dart';
import 'package:tribe365_new/feature/paid_version/offloading/screens/offloading_sub_screen.dart';
import 'package:tribe365_new/feature/paid_version/offloading/screens/reflection_screen.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/dimensions.dart';
import '../../../free_version/hptm/screens/hptm_screen.dart';
import '../controllers/offloading_controller.dart';

class OffLoadingScreen extends StatefulWidget {
  const OffLoadingScreen({super.key});

  @override
  OffLoadingScreenState createState() => OffLoadingScreenState();
}

class OffLoadingScreenState extends State<OffLoadingScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Consumer<OffloadingController>(builder: (context, offloadingProvider, _) {
          return SingleChildScrollView(
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              color: ColorResources.screenBg,
              child: Stack(
                children: [
                  Column(
                    children: [
                      CustomHeader(),
                      Container(
                        margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  offloadingProvider.updateIsType("offloading");
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.fromLTRB(0, 13, 0, 15),
                                  width: MediaQuery.sizeOf(context).width,
                                  decoration: BoxDecoration(
                                    color: offloadingProvider.isType == true ? ColorResources.mainColor : ColorResources.white,
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ColorResources.colorAAADC4,
                                        blurRadius: 3.0,
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    getTranslated("offloading", context)!,
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: Dimensions.sp14,
                                        fontWeight: FontWeight.w600,
                                        color: offloadingProvider.isType == true ? ColorResources.white : ColorResources.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  offloadingProvider.updateIsType("reflection");
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.fromLTRB(0, 13, 0, 15),
                                  width: MediaQuery.sizeOf(context).width,
                                  decoration: BoxDecoration(
                                    color: offloadingProvider.isType != true ? ColorResources.mainColor : ColorResources.white,
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ColorResources.colorAAADC4,
                                        blurRadius: 3.0,
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    getTranslated("reflection", context)!,
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: Dimensions.sp14,
                                        fontWeight: FontWeight.w600,
                                        color: offloadingProvider.isType != true ? ColorResources.white : ColorResources.black),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      offloadingProvider.isType == true ? OffLoadingSubScreen() : ReflectionScreen(),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        route(context, HPTMScreen());
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                        width: 20,
                        decoration: BoxDecoration(
                          color: ColorResources.mainColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          ),
                        ),
                        child: Text(
                          getTranslated("hptm", context)!,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'roboto',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
