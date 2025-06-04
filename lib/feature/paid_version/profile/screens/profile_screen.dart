import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../controllers/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  String _appVersion = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  void _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = info.version;
    });
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
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: ColorResources.mainColor, width: 1),
                          image: DecorationImage(
                            image: AssetImage(Images.imgTribe365),
                          ),
                        ),
                      ),
                      Spacer(),
                      Image.asset(Images.imgSettingRed,width: 30,height: 30,)
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          width: MediaQuery.sizeOf(context).width,
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: ColorResources.mainColor, width: 1),
                                  image: DecorationImage(
                                    image: AssetImage(Images.imgUserCircleGray),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5,),
                              Text(
                                "Yogesh ",
                                style: const TextStyle(
                                  fontSize: Dimensions.sp14,
                                  color: ColorResources.mainColor,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                              Text(
                                "Yogesh@text.com",
                                style: const TextStyle(
                                  fontSize: Dimensions.sp12,
                                  color: ColorResources.color9a9a9a,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                              Text(
                                "Apps, Demo Office",
                                style: const TextStyle(
                                  fontSize: Dimensions.sp12,
                                  color: ColorResources.black,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Roboto',
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
                              Container(
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
                              ),
                              /*Container(
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
                              ),*/
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
                              Container(
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
                              ),
                              /*Container(
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
                              ),*/
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
                              Container(
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
                              ),
                              /*Container(
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
                              ),*/
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 20, 15, 10),
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
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(Images.imgEditProfile,width: 50,height: 50,),
                                  SizedBox(width: 10,),
                                  Expanded(child: Text(getTranslated("edit_profile", context)!,style: TextStyle(
                                    fontSize: Dimensions.sp16,
                                    color: ColorResources.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto',
                                  ),))
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                width: MediaQuery.of(context).size.width,
                                height: 0.5,
                                color: ColorResources.color9a9a9a,
                              ),
                              Row(
                                children: [
                                  Image.asset(Images.imgActionRed,width: 50,height: 50,),
                                  SizedBox(width: 10,),
                                  Expanded(child: Text(getTranslated("actions", context)!,style: TextStyle(
                                    fontSize: Dimensions.sp16,
                                    color: ColorResources.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto',
                                  ),))
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                width: MediaQuery.of(context).size.width,
                                height: 0.5,
                                color: ColorResources.color9a9a9a,
                              ),
                              Row(
                                children: [
                                  Image.asset(Images.imgDemoStudiesProfile,width: 50,height: 50,),
                                  SizedBox(width: 10,),
                                  Expanded(child: Text(getTranslated("demo_studies", context)!,style: TextStyle(
                                    fontSize: Dimensions.sp16,
                                    color: ColorResources.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto',
                                  ),))
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                width: MediaQuery.of(context).size.width,
                                height: 0.5,
                                color: ColorResources.color9a9a9a,
                              ),
                              Row(
                                children: [
                                  Image.asset(Images.imgSupportProfile,width: 50,height: 50,),
                                  SizedBox(width: 10,),
                                  Expanded(child: Text(getTranslated("support", context)!,style: TextStyle(
                                    fontSize: Dimensions.sp16,
                                    color: ColorResources.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto',
                                  ),))
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                width: MediaQuery.of(context).size.width,
                                height: 0.5,
                                color: ColorResources.color9a9a9a,
                              ),
                              Row(
                                children: [
                                  Image.asset(Images.imgTakeLeaveRed,width: 50,height: 50,),
                                  SizedBox(width: 10,),
                                  Expanded(child: Text(getTranslated("take_a_leave", context)!,style: TextStyle(
                                    fontSize: Dimensions.sp16,
                                    color: ColorResources.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto',
                                  ),))
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                width: MediaQuery.of(context).size.width,
                                height: 0.5,
                                color: ColorResources.color9a9a9a,
                              ),
                              Row(
                                children: [
                                  Image.asset(Images.imgAppTourProfile,width: 50,height: 50,),
                                  SizedBox(width: 10,),
                                  Expanded(child: Text(getTranslated("app_tour", context)!,style: TextStyle(
                                    fontSize: Dimensions.sp16,
                                    color: ColorResources.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto',
                                  ),))
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                width: MediaQuery.of(context).size.width,
                                height: 0.5,
                                color: ColorResources.color9a9a9a,
                              ),
                              Row(
                                children: [
                                  Image.asset(Images.imgChangePasswordRedProfile,width: 50,height: 50,),
                                  SizedBox(width: 10,),
                                  Expanded(child: Text(getTranslated("change_password", context)!,style: TextStyle(
                                    fontSize: Dimensions.sp16,
                                    color: ColorResources.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto',
                                  ),))
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                width: MediaQuery.of(context).size.width,
                                height: 0.5,
                                color: ColorResources.color9a9a9a,
                              ),
                              Row(
                                children: [
                                  Image.asset(Images.imgLogoutProfile,width: 50,height: 50,),
                                  SizedBox(width: 10,),
                                  Expanded(child: Text(getTranslated("logout", context)!,style: TextStyle(
                                    fontSize: Dimensions.sp16,
                                    color: ColorResources.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto',
                                  ),))
                                ],
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            "${getTranslated("version", context)} $_appVersion",
                            style: const TextStyle(
                              fontSize: Dimensions.sp16,
                              color: ColorResources.black,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),

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

}
