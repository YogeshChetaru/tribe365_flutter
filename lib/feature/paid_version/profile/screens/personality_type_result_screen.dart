import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/profile/screens/personality_full_result_screen.dart';
import 'package:tribe365_new/feature/paid_version/profile/screens/update_personality_questions_screen.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/custom_route.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../controllers/profile_controller.dart';
class PersonalityTypeResultScreen extends StatefulWidget {

  const PersonalityTypeResultScreen({super.key});

  @override
  PersonalityTypeResultScreenState createState() => PersonalityTypeResultScreenState();
}

class PersonalityTypeResultScreenState extends State<PersonalityTypeResultScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    loadAPI();
  }

  void loadAPI() {
    ProfileController controller = Provider.of<ProfileController>(context, listen: false);
    controller.viewCOTFunctionalLensDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Consumer<ProfileController>(builder: (context, profileProvider, _) {
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
                          onTap:() {
                            Navigator.of(context).pop();
                          },
                          child: Image.asset(
                            Images.imgCircleBackRed,
                            width: 24,
                            height: 24,
                          )),
                      Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              getTranslated("personality_type_result", context)!,
                              style: TextStyle(
                                fontSize: Dimensions.sp18,
                                fontWeight: FontWeight.w600,
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
                profileProvider.isLoading == true
                    ? Expanded(
                        flex: 1,
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          height: MediaQuery.sizeOf(context).height,
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        flex: 1,
                        child: Container(
                          color: ColorResources.white,
                          width: MediaQuery.sizeOf(context).width,
                          height: MediaQuery.sizeOf(context).height,
                          child: SingleChildScrollView(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if(profileProvider.userNameStatus==false)
                                Text("${profileProvider.userProfileData!.name} ${profileProvider.userProfileData!.lastName??""}",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                if(profileProvider.userNameStatus==false)
                                SizedBox(height: 10),
                                InkWell(
                                  onTap: () {
                                    routePush(context, PersonalityQuestionsUpdateScreen());
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                                    width: MediaQuery.sizeOf(context).width,
                                    padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                                    decoration: BoxDecoration(
                                      color: ColorResources.mainColor,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    child: Text(
                                      getTranslated("REDO_REVIEW_QUESTIONNAIRE",
                                          context)!,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: Dimensions.sp16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                  ),
                                ),

                                InkWell(
                                  onTap: () {
                                    routePush(context, PersonalityFullResultScreen());
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(15, 20, 15, 15),
                                    width: MediaQuery.sizeOf(context).width,
                                    padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                                    decoration: BoxDecoration(
                                      color: ColorResources.mainColor,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    child: Text(
                                      getTranslated("view_full_result",
                                          context)!,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: Dimensions.sp16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
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
}

