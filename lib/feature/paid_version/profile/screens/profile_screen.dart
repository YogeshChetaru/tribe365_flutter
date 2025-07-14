import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/profile/screens/motivation_questions_screen.dart';
import 'package:tribe365_new/feature/paid_version/profile/screens/personality_type_screen.dart';
import 'package:tribe365_new/feature/paid_version/profile/screens/profile_actions_screen.dart';
import 'package:tribe365_new/feature/paid_version/profile/screens/profile_demo_studies_screen.dart';
import 'package:tribe365_new/feature/paid_version/profile/screens/profile_edit_profile_screen.dart';
import 'package:tribe365_new/feature/paid_version/profile/screens/profile_setting_screen.dart';
import 'package:tribe365_new/feature/paid_version/profile/screens/profile_support_screen.dart';
import 'package:tribe365_new/feature/paid_version/profile/screens/team_role_screen.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/custom_route.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../main.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../free_version/free_dashboard/widgets/changepassworddialog.dart';
import '../../../free_version/free_dashboard/widgets/logoutdialog.dart';
import '../../../free_version/free_dashboard/widgets/worknotdialog.dart';
import '../../know/widgets/motivationitem.dart';
import '../../know/widgets/personalitytypeitem.dart';
import '../../know/widgets/teamroleitem.dart';
import '../controllers/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  String _appVersion = '';
  ProfileController profileController = Provider.of<ProfileController>(Get.context!, listen: false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadVersion();
    loadAPI();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App is resumed
      debugPrint("onResume called");
      loadAPI();
    }
  }

  void loadAPI() {
    profileController.viewUserProfile();
  }

  void _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = info.version;
    });
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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
                            image: profileProvider.userProfileData!.organisationLogo == null
                                ? AssetImage(Images.imgTribe365) as ImageProvider
                                : NetworkImage(profileProvider.userProfileData!.organisationLogo!) as ImageProvider,
                          ),
                        ),
                      ),
                      Spacer(),
                      InkWell(onTap: (){
                        routePush(context, ProfileSettingScreen());
                      },child: Image.asset(Images.imgSettingRed,width: 30,height: 30,))
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
                                    image: profileProvider.userProfileData!.profileImage == ""
                                        ? AssetImage(Images.imgUserCircleGray) as ImageProvider
                                        : NetworkImage(profileProvider.userProfileData!.profileImage!) as ImageProvider,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5,),
                              Text(
                                "${ profileProvider.userProfileData!.name} ${ profileProvider.userProfileData!.lastName}",
                                style: const TextStyle(
                                  fontSize: Dimensions.sp14,
                                  color: ColorResources.mainColor,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                              Text(
                                profileProvider.userProfileData!.email!,
                                style: const TextStyle(
                                  fontSize: Dimensions.sp12,
                                  color: ColorResources.color9a9a9a,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                              Text(
                                "${profileProvider.userProfileData!.departmentName!}, ${profileProvider.userProfileData!.officeName!}",
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
                                  color: ColorResources.black,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                              profileProvider.userProfileData!.personalityTypeDetailsArr==null?
                              InkWell(
                                onTap: () async {
                                bool status = await Navigator.of(context).push(
                                    PageRouteBuilder(
                                      transitionDuration: Duration(milliseconds: 500),
                                      reverseTransitionDuration: Duration(milliseconds: 500),
                                      pageBuilder: (context, animation, secondaryAnimation) => PersonalityTypeScreen(),
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
                                if(status){
                                  loadAPI();
                                }
                                },child: Container(
                                  margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                                  child: Text(
                                    profileProvider.userProfileData!.personalityTypeDetails!,
                                    style: TextStyle(
                                      fontSize: Dimensions.sp12,
                                      color: ColorResources.black, // Replace with ColorResources.mainColor
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ),
                              ):
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                child: GridView.builder(
                                  itemCount: profileProvider.userProfileData!.personalityTypeDetailsArr!.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 3 / 1,
                                  ),
                                  itemBuilder: (context, index) {
                                    return PersonalityTypeItem(personalityTypeDetails: profileProvider.userProfileData!.personalityTypeDetailsArr![index]);
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
                                  color: ColorResources.black,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                              profileProvider.userProfileData!.cotTeamRoleMapArr!.isEmpty?
                              InkWell(
                                onTap: () async {
                              bool status = await  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      transitionDuration: Duration(milliseconds: 500),
                                      reverseTransitionDuration: Duration(milliseconds: 500),
                                      pageBuilder: (context, animation, secondaryAnimation) => TeamRoleScreen(),
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
                                  if(status){
                                    loadAPI();
                                  }
                                },child: Container(
                                  margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                                  child: Text(
                                    profileProvider.userProfileData!.cotTeamRoleMap!,
                                    style: TextStyle(
                                      fontSize: Dimensions.sp12,
                                      color: ColorResources.black,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ),
                              ):
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                child: GridView.builder(
                                  itemCount: profileProvider.userProfileData!.cotTeamRoleMapArr!.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 3 / 1,
                                  ),
                                  itemBuilder: (context, index) {
                                    return TeamRoleItem(name: profileProvider.userProfileData!.cotTeamRoleMapArr![index],);
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
                                  color: ColorResources.black,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                              profileProvider.userProfileData!.sotMotivationDetailArr!.isEmpty?
                              InkWell(
                                onTap: (){
                                  routePush(context, MotivationQuestionsScreen());
                                },child: Container(
                                  margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                                  child: Text(
                                    profileProvider.userProfileData!.sotMotivationDetail!,
                                    style: TextStyle(
                                      fontSize: Dimensions.sp12,
                                      color: ColorResources.black, // Replace with ColorResources.mainColor
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ),
                              ):
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                child: GridView.builder(
                                  itemCount: profileProvider.userProfileData!.sotMotivationDetailArr!.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 3 / 1,
                                  ),
                                  itemBuilder: (context, index) {
                                    return MotivationItem(name: profileProvider.userProfileData!.sotMotivationDetailArr![index],);
                                  },
                                ),
                              ),
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
                              InkWell(
                                onTap: () async {
                                bool status = await  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      transitionDuration: Duration(milliseconds: 500),
                                      reverseTransitionDuration: Duration(milliseconds: 500),
                                      pageBuilder: (context, animation, secondaryAnimation) => ProfileEditProfileScreen(),
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
                                if(status){
                                  loadAPI();
                                }
                                },child: Row(
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
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                width: MediaQuery.of(context).size.width,
                                height: 0.5,
                                color: ColorResources.color9a9a9a,
                              ),
                              InkWell(
                                onTap: (){
                                  routePush(context, ProfileActionsScreen());
                                },child: Row(
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
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                width: MediaQuery.of(context).size.width,
                                height: 0.5,
                                color: ColorResources.color9a9a9a,
                              ),
                              InkWell(
                                onTap: (){
                                  routePush(context, ProfileDemoStudiesScreen());
                                },child: Row(
                                  children: [
                                    Image.asset(Images.imgDemoStudiesProfile,width: 50,height: 50,),
                                    SizedBox(width: 10,),
                                    Expanded(child: Text("${profileProvider.userProfileData!.organisationName!} ${getTranslated("studies", context)}",style: TextStyle(
                                      fontSize: Dimensions.sp16,
                                      color: ColorResources.black,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Roboto',
                                    ),))
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                width: MediaQuery.of(context).size.width,
                                height: 0.5,
                                color: ColorResources.color9a9a9a,
                              ),
                              InkWell(
                                onTap: (){
                                  routePush(context, ProfileSupportScreen());
                                },child: Row(
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
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                width: MediaQuery.of(context).size.width,
                                height: 0.5,
                                color: ColorResources.color9a9a9a,
                              ),
                              InkWell(
                                onTap: (){
                                  customShowDialog(context,WorkNotDialog());
                                },
                                child: Row(
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
                              InkWell(
                                onTap: (){
                                  customShowDialog(context,ChangePasswordDialog());
                                },child: Row(
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
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                width: MediaQuery.of(context).size.width,
                                height: 0.5,
                                color: ColorResources.color9a9a9a,
                              ),
                              InkWell(
                                onTap: (){
                                  customShowDialog(context,LogoutDialog());
                                },
                                child: Row(
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
