import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/common/basewidget/custom_header_widget.dart';
import 'package:tribe365_new/feature/paid_version/know/screens/know_members_screen.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/custom_route.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../main.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../free_version/free_dashboard/controllers/free_dashboard_controller.dart';
import '../../../free_version/free_dashboard/domain/models/get_office_list_response.dart';
import '../../../free_version/free_dashboard/domain/models/view_department_list_response.dart';
import '../../../free_version/hptm/screens/hptm_screen.dart';
import '../../home/widgets/amazingawarduserdialog.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/know_controller.dart';

class KnowScreen extends StatefulWidget {
  const KnowScreen({super.key});

  @override
  KnowScreenState createState() => KnowScreenState();
}

class KnowScreenState extends State<KnowScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  ProfileController profileController = Provider.of<ProfileController>(Get.context!,listen: false);

  @override
  void initState() {
    super.initState();
    loadAPI();
  }
  void loadAPI() {
    final ProfileController profileController = Provider.of<ProfileController>(context, listen: false);
   final KnowController knowController = Provider.of<KnowController>(context, listen: false);
    profileController.viewUserProfile().then((onValue) {
      knowController.updateOrgID(profileController.userProfileData);
      knowController.viewDepartmentList().then((value){
        knowController.viewOfficeList().then((onValue){
          knowController.viewKnowOrganisation();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Consumer<KnowController>(builder: (context, knowProvider, _) {
          return Consumer<FreeDashboardController>(builder: (context, dashboardProvider, _) {
            return Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              color: ColorResources.screenBg,
              child: Stack(
                children: [
                  Column(
                    children: [
                      CustomHeader(),
                      Expanded(
                        flex: 1,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: Row(
                                  children: [
                                    knowProvider.officesList == null
                                        ? SizedBox.fromSize()
                                        : Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            DropdownButtonHideUnderline(
                                              child: DropdownButton<Offices>(
                                                isExpanded: true,
                                                value: knowProvider.officeSelectedValue,
                                                items: knowProvider.officesList!.map((Offices value) {
                                                  return DropdownMenuItem<Offices>(
                                                    value: value,
                                                    child: Text(
                                                      value.office.toString(),
                                                      style: const TextStyle(
                                                        fontSize: Dimensions.sp14,
                                                        color: ColorResources.black,
                                                        fontWeight: FontWeight.w500,
                                                        fontFamily: 'Roboto',
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (Offices? newValue) {
                                                  knowProvider.updateOfficeSelectedValue(newValue);

                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    knowProvider.departmentList == null
                                        ? SizedBox.fromSize()
                                        : Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            DropdownButtonHideUnderline(
                                              child: DropdownButton<ViewDepartmentListData>(
                                                isExpanded: true,
                                                value: knowProvider.departmentSelectedValue,
                                                items: knowProvider.departmentList!.map((ViewDepartmentListData value) {
                                                  return DropdownMenuItem<ViewDepartmentListData>(
                                                    value: value,
                                                    child: Text(
                                                      value.department!,
                                                      style: const TextStyle(
                                                        fontSize: Dimensions.sp14,
                                                        color: ColorResources.black,
                                                        fontWeight: FontWeight.w500,
                                                        fontFamily: 'Roboto',
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (ViewDepartmentListData? newValue) {
                                                  knowProvider.updateDepartmentSelectedValue(newValue);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              knowProvider.homeData==null?SizedBox.shrink():
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerRight,
                                      width: 120,
                                      height: 20,
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          value: knowProvider.dayWiseSelectedValue,
                                          items: knowProvider.dayWiseList.map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: const TextStyle(
                                                  fontSize: Dimensions.sp14,
                                                  color: ColorResources.color9a9a9a,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Roboto',
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            knowProvider.updateDayWiseSelectedValue(newValue);
                                          },
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.sizeOf(context).width,
                                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              width: MediaQuery.sizeOf(context).width,
                                              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                              padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                              decoration: BoxDecoration(
                                                color: ColorResources.colorF8F8F8,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: ColorResources.colorAAADC4,
                                                    blurRadius: 2.0,
                                                  ),
                                                ],
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                   knowProvider.todayTitle,
                                                    style: TextStyle(
                                                      fontSize: Dimensions.sp14,
                                                      color: ColorResources.black, // Replace with ColorResources.mainColor
                                                      fontWeight: FontWeight.w600,
                                                      fontFamily: 'Roboto',
                                                    ),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Image.asset(knowProvider.todayEmoji,width: 30,height: 30,),
                                                  SizedBox(height: 5,),
                                                  Text(
                                                    knowProvider.todayValue,
                                                    style: TextStyle(
                                                      fontSize: Dimensions.sp12,
                                                      color:knowProvider.todayColor,
                                                      fontWeight: FontWeight.w700,
                                                      fontFamily: 'Roboto',
                                                    ),
                                                  ),
                                                  Text(
                                                    getTranslated("sentiment_index", context)!,
                                                    style: TextStyle(
                                                      fontSize: Dimensions.sp10,
                                                      color: ColorResources.color9a9a9a,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: 'Roboto',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              width: MediaQuery.sizeOf(context).width,
                                              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                              padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                              decoration: BoxDecoration(
                                                color: ColorResources.colorF8F8F8,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: ColorResources.colorAAADC4,
                                                    blurRadius: 2.0,
                                                  ),
                                                ],
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    knowProvider.yesterdayTitle,
                                                    style: TextStyle(
                                                      fontSize: Dimensions.sp14,
                                                      color: ColorResources.black, // Replace with ColorResources.mainColor
                                                      fontWeight: FontWeight.w600,
                                                      fontFamily: 'Roboto',
                                                    ),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Image.asset(knowProvider.yesterdayEmoji,width: 30,height: 30,),
                                                  SizedBox(height: 5,),
                                                  Text(
                                                    knowProvider.yesterdayValue,
                                                    style: TextStyle(
                                                      fontSize: Dimensions.sp12,
                                                      color: knowProvider.yesterdayColor, // Replace with ColorResources.mainColor
                                                      fontWeight: FontWeight.w700,
                                                      fontFamily: 'Roboto',
                                                    ),
                                                  ),
                                                  Text(
                                                    getTranslated("sentiment_index", context)!,
                                                    style: TextStyle(
                                                      fontSize: Dimensions.sp10,
                                                      color: ColorResources.color9a9a9a, // Replace with ColorResources.mainColor
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: 'Roboto',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              width: MediaQuery.sizeOf(context).width,
                                              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                              padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                              decoration: BoxDecoration(
                                                color: ColorResources.colorF8F8F8,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: ColorResources.colorAAADC4,
                                                    blurRadius: 2.0,
                                                  ),
                                                ],
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    knowProvider.dayAfterTitle,
                                                    style: TextStyle(
                                                      fontSize: Dimensions.sp14,
                                                      color: ColorResources.black, // Replace with ColorResources.mainColor
                                                      fontWeight: FontWeight.w600,
                                                      fontFamily: 'Roboto',
                                                    ),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Image.asset(knowProvider.dayAfterEmoji,width: 30,height: 30,),
                                                  SizedBox(height: 5,),
                                                  Text(
                                                    knowProvider.dayAfterValue,
                                                    style: TextStyle(
                                                      fontSize: Dimensions.sp12,
                                                      color: knowProvider.dayAfterColor, // Replace with ColorResources.mainColor
                                                      fontWeight: FontWeight.w700,
                                                      fontFamily: 'Roboto',
                                                    ),
                                                  ),
                                                  Text(
                                                    getTranslated("sentiment_index", context)!,
                                                    style: TextStyle(
                                                      fontSize: Dimensions.sp10,
                                                      color: ColorResources.color9a9a9a, // Replace with ColorResources.mainColor
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
                                  ],
                                ),
                              ),

                              knowProvider.homeData==null?
                              SizedBox.shrink():
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
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Row(
                                  children: [
                                    Expanded(flex: 30,child: Container(
                                      alignment: Alignment.center,
                                      child: Image.asset(knowProvider.cultureImagePath,width: 50,height: 50,fit: BoxFit.fill,),
                                    ),),
                                    Container(
                                      width: 0.5,
                                      height: 50,
                                      color: ColorResources.colorAAADC4,
                                    ),
                                    Expanded(flex: 10,child: Container(
                                    ),),
                                    Expanded(flex: 50,child: Container(
                                      width: MediaQuery.sizeOf(context).width,
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            getTranslated("culture_index", context)!,
                                            style: TextStyle(
                                              fontSize: Dimensions.sp14,
                                              color: ColorResources.black, // Replace with ColorResources.mainColor
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Roboto',
                                            ),
                                          ),
                                          Text(
                                            knowProvider.tvCultureRank,
                                            style: TextStyle(
                                              fontSize: Dimensions.sp14,
                                              color: ColorResources.color9a9a9a, // Replace with ColorResources.mainColor
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Roboto',
                                            ),
                                          ),
                                          Text(
                                            knowProvider.tvCultureValue,
                                            style: TextStyle(
                                              fontSize: Dimensions.sp14,
                                              color: knowProvider.cultureTextColor, // Replace with ColorResources.mainColor
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Roboto',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),),
                                  ],
                                ),
                              ),

                              knowProvider.homeData==null?
                              SizedBox.shrink():
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
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Row(
                                  children: [
                                    Expanded(flex: 30,child: Container(
                                      alignment: Alignment.center,
                                      child: Image.asset(knowProvider.engagementImagePath,width: 50,height: 50,fit: BoxFit.fill,),
                                    ),),
                                    Container(
                                      width: 0.5,
                                      height: 50,
                                      color: ColorResources.colorAAADC4,
                                    ),
                                    Expanded(flex: 10,child: Container(
                                    ),),
                                    Expanded(flex: 50,child: Container(
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
                                              color: ColorResources.black,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Roboto',
                                            ),
                                          ),
                                          Text(
                                            knowProvider.engagementRank,
                                            style: TextStyle(
                                              fontSize: Dimensions.sp14,
                                              color: ColorResources.color9a9a9a,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Roboto',
                                            ),
                                          ),
                                          Text(
                                            knowProvider.engagementValue,
                                            style: TextStyle(
                                              fontSize: Dimensions.sp14,
                                              color: knowProvider.engagementTextColor,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Roboto',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),),
                                  ],
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getTranslated("kudos_awards", context)!,
                                      style: TextStyle(
                                        fontSize: Dimensions.sp16,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'roboto',
                                        color: ColorResources.black,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showDialog(context, AmazingAwardUserDialog());
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
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
                                              "Tarun",
                                              style: TextStyle(
                                                fontFamily: 'roboto',
                                                fontSize: Dimensions.sp14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              "Amazing",
                                              style: TextStyle(
                                                fontFamily: 'roboto',
                                                fontSize: Dimensions.sp14,
                                                fontWeight: FontWeight.w600,
                                                color: ColorResources.mainColor,
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  Images.imgGroupCircleRed,
                                                  width: 20,
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "Demo Lead & 3 more",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontFamily: 'roboto',
                                                    fontSize: Dimensions.sp14,
                                                    fontWeight: FontWeight.w400,
                                                    color: ColorResources.color333333,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: MediaQuery.sizeOf(context).width,
                                              child: Text(
                                                "29 apr 2025, 03:09 pm",
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontFamily: 'roboto',
                                                  fontSize: Dimensions.sp12,
                                                  fontWeight: FontWeight.w400,
                                                  color: ColorResources.color9a9a9a,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  routePush(context, KnowMembersScreen());
                                },child: Container(
                                margin: EdgeInsets.fromLTRB(15, 15, 15, 10),
                                width: MediaQuery.sizeOf(context).width,
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                decoration: BoxDecoration(
                                  color: ColorResources.mainColor,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                                ),
                                child: Text(getTranslated("know_members", context)!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: Dimensions.sp16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto',
                                  ),),
                              ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        routePush(context, HPTMScreen());
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
            );
          });
        }),
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
