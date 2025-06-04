import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../../../../common/basewidget/custom_header_back_widget.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/dimensions.dart';
import '../controllers/know_controller.dart';
import '../widgets/motivationitem.dart';
import '../widgets/personalitytypeitem.dart';
import '../widgets/teamroleitem.dart';
import 'knowuserlistdialog.dart';

class KnowMembersScreen extends StatefulWidget {
  const KnowMembersScreen({super.key});

  @override
  KnowMembersScreenState createState() => KnowMembersScreenState();
}

class KnowMembersScreenState extends State<KnowMembersScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Consumer<KnowController>(builder: (context, knowProvider, _) {
          return Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            color: ColorResources.screenBg,
            child: Column(
              children: [
                CustomHeaderBack(title: getTranslated("know_members", context)!),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            showDialog(context, KnowUserListDialog());
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                            decoration: BoxDecoration(
                              color: ColorResources.white,
                              boxShadow: [
                                BoxShadow(
                                  color: ColorResources.colorAAADC4,
                                  blurRadius: 3.0,
                                ),
                              ],
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            width: MediaQuery.sizeOf(context).width,
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: Text(
                              "Yogesh Tribe demo",
                              style: TextStyle(
                                fontSize: Dimensions.sp14,
                                color: ColorResources.color9a9a9a, // Replace with ColorResources.mainColor
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                          decoration: BoxDecoration(
                            color: ColorResources.white,
                            boxShadow: [
                              BoxShadow(
                                color: ColorResources.colorAAADC4,
                                blurRadius: 3.0,
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          width: MediaQuery.sizeOf(context).width,
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 30,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    knowProvider.getEmoji("normal"),
                                    style: const TextStyle(fontSize: 50),
                                  ),
                                ),
                              ),
                              Container(
                                width: 0.5,
                                height: 50,
                                color: ColorResources.colorAAADC4,
                              ),
                              Expanded(
                                flex: 10,
                                child: Container(),
                              ),
                              Expanded(
                                flex: 50,
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width,
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        getTranslated("engagement_index", context)!,
                                        style: TextStyle(
                                          fontSize: Dimensions.sp14,
                                          color: ColorResources.color9a9a9a, // Replace with ColorResources.mainColor
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                      Text(
                                        "-50",
                                        style: TextStyle(
                                          fontSize: Dimensions.sp14,
                                          color: ColorResources.mainColor, // Replace with ColorResources.mainColor
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                      Text(
                                        "LOW",
                                        style: TextStyle(
                                          fontSize: Dimensions.sp14,
                                          color: ColorResources.black, // Replace with ColorResources.mainColor
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                          width: MediaQuery.sizeOf(context).width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getTranslated("personality_type", context)!,
                                style: TextStyle(
                                  fontSize: Dimensions.sp14,
                                  color: ColorResources.black, // Replace with ColorResources.mainColor
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                              /*Container(
                                margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                                child: Text(
                                  getTranslated("you_have_not_submit_your_answers_yet", context)!,
                                  style: TextStyle(
                                    fontSize: Dimensions.sp12,
                                    color: ColorResources.black, // Replace with ColorResources.mainColor
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ),*/
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                child: GridView.builder(
                                  itemCount: 4,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 3 / 1,
                                  ),
                                  itemBuilder: (context, index) {
                                    return PersonalityTypeItem();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                          width: MediaQuery.sizeOf(context).width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getTranslated("team_role", context)!,
                                style: TextStyle(
                                  fontSize: Dimensions.sp14,
                                  color: ColorResources.black, // Replace with ColorResources.mainColor
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                              /*Container(
                                margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                                child: Text(
                                  getTranslated("you_have_not_submit_your_answers_yet", context)!,
                                  style: TextStyle(
                                    fontSize: Dimensions.sp12,
                                    color: ColorResources.black, // Replace with ColorResources.mainColor
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ),*/
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                child: GridView.builder(
                                  itemCount: 3,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 3 / 1,
                                  ),
                                  itemBuilder: (context, index) {
                                    return TeamRoleItem();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                          width: MediaQuery.sizeOf(context).width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getTranslated("motivation", context)!,
                                style: TextStyle(
                                  fontSize: Dimensions.sp14,
                                  color: ColorResources.black, // Replace with ColorResources.mainColor
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                              /*Container(
                                margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                                child: Text(
                                  getTranslated("you_have_not_submit_your_answers_yet", context)!,
                                  style: TextStyle(
                                    fontSize: Dimensions.sp12,
                                    color: ColorResources.black, // Replace with ColorResources.mainColor
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ),*/
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                child: GridView.builder(
                                  itemCount: 3,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 3 / 1,
                                  ),
                                  itemBuilder: (context, index) {
                                    return MotivationItem();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
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
