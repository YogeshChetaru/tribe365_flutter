import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/common/basewidget/custom_header_back_widget.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../controllers/offloading_controller.dart';

class OffLoadingChatDetailsScreen extends StatefulWidget {
  const OffLoadingChatDetailsScreen({super.key});

  @override
  OffLoadingChatDetailsScreenState createState() => OffLoadingChatDetailsScreenState();
}

class OffLoadingChatDetailsScreenState extends State<OffLoadingChatDetailsScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  final TextEditingController usernameController = TextEditingController();
  final FocusNode usernameFocus = FocusNode();

  @override
  void dispose() {
    usernameController.dispose();
    usernameFocus.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Consumer<OffloadingController>(builder: (context, offloadingProvider, _) {
          return Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            color: ColorResources.screenBg,
            child: Column(
              children: [
                CustomHeaderBack(title: ""),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: ColorResources.white ,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: ColorResources.colorAAADC4,
                        blurRadius: 3.0,
                      ),
                    ],
                  ),
                  padding: EdgeInsetsDirectional.fromSTEB(15, 15,15, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(getTranslated("details", context)!,style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: ColorResources.mainColor,
                        fontFamily: 'roboto'
                      ),),
                      SizedBox(height: 10,),
                      Text("04 Jun 2025, 01:24 pm",style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: ColorResources.mainColor,
                          fontFamily: 'roboto'
                      ),),
                      SizedBox(height: 10,),
                      Text("test",style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: ColorResources.color333333,
                          fontFamily: 'roboto'
                      ),),
                    ],
                  ),
                ),

              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom, // Moves it up when keyboard shows
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            width: MediaQuery.of(context).size.width,
            height: 70,
            decoration: BoxDecoration(
              color: ColorResources.white ,
              boxShadow: [
                BoxShadow(
                  color: ColorResources.colorAAADC4,
                  blurRadius: 3.0,
                ),
              ],
            ),
            child: Row(
              children: [
                Image.asset(Images.imgAttachmentBlack,width: 20,height: 20,),
                SizedBox(width: 10,),
                Expanded(flex: 1,child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    color: ColorResources.color808080.withAlpha(51),
                    border: Border.all(color: ColorResources.color808080.withAlpha(51), width: 0.5),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: TextField(
                    controller: usernameController,
                    focusNode: usernameFocus,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    style: const TextStyle(
                      fontSize: Dimensions.sp14,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto',
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      hintText: getTranslated("new_massage", context),
                      hintStyle: const TextStyle(
                        color: ColorResources.color9a9a9a,
                        fontSize: Dimensions.sp14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ),),
                SizedBox(width: 10,),
                Text(getTranslated("send", context)!,style: TextStyle(
                  fontFamily: 'roboto',
                  fontSize: Dimensions.sp18,
                  color: ColorResources.black,
                  fontWeight: FontWeight.w700
                ),)
              ],
            ),

          ),
        ),
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

}
