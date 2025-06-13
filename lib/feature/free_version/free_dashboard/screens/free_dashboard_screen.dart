import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/free_version/free_dashboard/controllers/free_dashboard_controller.dart';
import 'package:tribe365_new/feature/free_version/free_dashboard/widgets/builddaytext.dart';
import 'package:tribe365_new/feature/free_version/free_dashboard/widgets/calendaritemwidget.dart';
import 'package:tribe365_new/feature/free_version/hptm/screens/hptm_screen.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/custom_route.dart';
import 'package:tribe365_new/utill/images.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/dimensions.dart';
import '../../../paid_version/profile/controllers/profile_controller.dart';
import '../domain/models/get_office_list_response.dart';
import '../domain/models/view_department_list_response.dart';
import '../widgets/changepassworddialog.dart';
import '../widgets/logoutdialog.dart';
import '../widgets/out_office_mode_dialog.dart';
import '../widgets/worknotdialog.dart';

class FreeDashboardScreen extends StatefulWidget {
  const FreeDashboardScreen({super.key});

  @override
  FreeDashboardScreenState createState() => FreeDashboardScreenState();
}

class FreeDashboardScreenState extends State<FreeDashboardScreen> {
  void updateNotificationStatus() {}

  void dialogAbsent() {}

  void dialogEnableAbsent() {}

  @override
  void initState() {
    super.initState();
    //---------setup---------
    updateNotificationStatus();
    //----------
    loadAPI();
  }

  void loadAPI() {
    final ProfileController profileController = Provider.of<ProfileController>(context, listen: false);
    final FreeDashboardController freeController = Provider.of<FreeDashboardController>(context, listen: false);
    profileController.viewUserProfile().then((onValue) {
      freeController.updateOrgID(profileController.userProfileData!.orgId);
      freeController.updateUserID(profileController.userProfileData!.id);
      freeController.viewDepartmentList();
      freeController.viewOfficeList();
      freeController.initYears(DateTime.now().year);
      freeController.getHomePageDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Consumer<FreeDashboardController>(builder: (context, dashboardProvider, _) {
          return Consumer<ProfileController>(builder: (context, profileProvider, _) {
            return Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              color: ColorResources.screenBg,
              child: Column(
                children: [
                  profileProvider.userProfileData == null
                      ? SizedBox.shrink()
                      : Container(
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
                                width: 60,
                                height: 60,
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
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  width: MediaQuery.sizeOf(context).width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${profileProvider.userProfileData!.name!} ${profileProvider.userProfileData!.lastName!}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: Dimensions.sp16,
                                          color: ColorResources.mainColor,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                      Text(
                                        profileProvider.userProfileData!.email!,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: Dimensions.sp14,
                                          color: ColorResources.color9a9a9a,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                      Text(
                                        "${profileProvider.userProfileData!.departmentName!}, ${profileProvider.userProfileData!.officeName!}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: Dimensions.sp14,
                                          color: ColorResources.black,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showBottomMenuSheet(context);
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        Images.imgRedMenuDot,
                                        width: 24,
                                        height: 24,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          dashboardProvider.isHappyIndexStatus==false ?
                          SizedBox.shrink():
                          Container(
                            margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                            width: MediaQuery.sizeOf(context).width,
                            padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ColorResources.mainColor,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  getTranslated("how_s_things_at_work_today", context)!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: Dimensions.sp16,
                                    color: ColorResources.white,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: InkWell(
                                        onTap: (){
                                          dashboardProvider.addHappyIndex("3");
                                        },child: SizedBox(
                                          width: 55,
                                          height: 55,
                                          child: Image.asset(
                                            Images.imgHappyEmoji,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: InkWell(
                                        onTap: (){
                                          dashboardProvider.addHappyIndex("2");
                                        },child: SizedBox(
                                          width: 55,
                                          height: 55,
                                          child: Image.asset(
                                            Images.imgNeutralEmoji,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: InkWell(
                                        onTap: (){
                                          dashboardProvider.addHappyIndex("1");
                                        },child: SizedBox(
                                          width: 55,
                                          height: 55,
                                          child: Image.asset(
                                            Images.imgSadEmoji,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    dashboardProvider.updateDate();
                                    customShowDialog(context, WorkNotDialog());
                                  },
                                  child: Text(
                                    getTranslated("i_m_not_in_work_today", context)!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: Dimensions.sp16,
                                      color: ColorResources.white,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto',
                                      decoration: TextDecoration.underline,
                                      decorationColor: ColorResources.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                         if (dashboardProvider.isAbsentVisible)
                              InkWell(
                                onTap: (){
                                  customShowDialog(context, OutOfficeModeDialog());
                                },
                            child: Container(
                                    margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                                    width: MediaQuery.sizeOf(context).width,
                                    padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: ColorResources.mainColor,
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        getTranslated("out_of_office_mode_enabled", context)!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),),

                          Container(
                            margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                            width: MediaQuery.sizeOf(context).width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                dashboardProvider.officesList == null
                                    ? SizedBox.fromSize()
                                    : Text(
                                        getTranslated("sentiment_index", context)!,
                                        style: const TextStyle(
                                          fontSize: Dimensions.sp18,
                                          color: ColorResources.black,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    dashboardProvider.officesList == null
                                        ? SizedBox.fromSize()
                                        : Expanded(
                                            flex: 1,
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                              color: Colors.white,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  DropdownButtonHideUnderline(
                                                    child: DropdownButton<Offices>(
                                                      isExpanded: true,
                                                      value: dashboardProvider.officeSelectedValue,
                                                      items: dashboardProvider.officesList!.map((Offices value) {
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
                                                        dashboardProvider.updateOfficeSelectedValue(newValue);
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
                                    dashboardProvider.departmentList == null
                                        ? SizedBox.fromSize()
                                        : Expanded(
                                            flex: 1,
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                              color: Colors.white,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  DropdownButtonHideUnderline(
                                                    child: DropdownButton<ViewDepartmentListData>(
                                                      isExpanded: true,
                                                      value: dashboardProvider.departmentSelectedValue,
                                                      items: dashboardProvider.departmentList!.map((ViewDepartmentListData value) {
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
                                                        dashboardProvider.updateDepartmentSelectedValue(newValue);
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                dashboardProvider.yearList.isEmpty
                                    ? SizedBox.shrink()
                                    : Container(
                                        width: MediaQuery.sizeOf(context).width,
                                        color: ColorResources.white,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                color: Colors.white,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    DropdownButtonHideUnderline(
                                                      child: DropdownButton<String>(
                                                        isExpanded: true,
                                                        value: dashboardProvider.monthSelectedValue,
                                                        items: dashboardProvider.monthList.map((String value) {
                                                          return DropdownMenuItem<String>(
                                                            value: value,
                                                            child: Text(
                                                              value,
                                                              style: const TextStyle(
                                                                fontSize: Dimensions.sp14,
                                                                color: ColorResources.black,
                                                                fontWeight: FontWeight.w500,
                                                                fontFamily: 'Roboto',
                                                              ),
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onChanged: (String? newValue) {
                                                          dashboardProvider.updateMonthSelectedValue(newValue);
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                color: Colors.white,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    DropdownButtonHideUnderline(
                                                      child: DropdownButton<int>(
                                                        isExpanded: true,
                                                        value: dashboardProvider.yearSelectedValue,
                                                        items: dashboardProvider.yearList.map((int value) {
                                                          return DropdownMenuItem<int>(
                                                            value: value,
                                                            child: Text(
                                                              value.toString(),
                                                              style: const TextStyle(
                                                                fontSize: Dimensions.sp14,
                                                                color: ColorResources.black,
                                                                fontWeight: FontWeight.w500,
                                                                fontFamily: 'Roboto',
                                                              ),
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onChanged: (int? newValue) {
                                                          dashboardProvider.updateYearSelectedValue(newValue);
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
                                SizedBox(
                                  height: 15,
                                ),
                                dashboardProvider.isLoading
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                            Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          Row(
                                            children: [
                                              BuildDayText(day: getTranslated("sun", context)!, color: ColorResources.mainColor), // colorPrimary
                                              BuildDayText(
                                                day: getTranslated("mon", context)!,
                                                color: Colors.black,
                                              ),
                                              BuildDayText(
                                                day: getTranslated("tue", context)!,
                                                color: Colors.black,
                                              ),
                                              BuildDayText(
                                                day: getTranslated("wed", context)!,
                                                color: Colors.black,
                                              ),
                                              BuildDayText(
                                                day: getTranslated("thu", context)!,
                                                color: Colors.black,
                                              ),
                                              BuildDayText(
                                                day: getTranslated("fri", context)!,
                                                color: Colors.black,
                                              ),
                                              BuildDayText(day: getTranslated("sat", context)!, color: ColorResources.mainColor),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          GridView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: dashboardProvider.calendarData.length,
                                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 7,
                                              mainAxisSpacing: 2,
                                              crossAxisSpacing: 2,
                                              childAspectRatio: 0.8,
                                            ),
                                            itemBuilder: (context, index) {
                                              final data = dashboardProvider.calendarData[index];
                                              final day = data['day'];
                                              final mood = data['mood'];
                                              final isWeekend = index % 7 == 0 || index % 7 == 6;
                                              final isNotWorkingDay = data['isNotWorkingDay'] ?? false;
                                              final date = data['date'];
                                              return CalendarItemWidget(
                                                day: day,
                                                isWeekend: isWeekend,
                                                mood: mood,
                                                isNotWorkingDay: isNotWorkingDay,
                                                date: date,
                                              );
                                            },
                                          )
                                        ],
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
          });
        }),
      ),
      bottomNavigationBar: SafeArea(
        child: InkWell(
          onTap: () {
            routePush(context, HPTMScreen());
          },
          child: Container(
            height: 50,
            alignment: Alignment.center,
            width: MediaQuery.sizeOf(context).width,
            color: ColorResources.mainColor,
            child: Text(
              getTranslated("hptm", context)!,
              style: const TextStyle(
                fontSize: Dimensions.sp18,
                color: ColorResources.white,
                fontWeight: FontWeight.w600,
                fontFamily: 'Roboto',
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showBottomMenuSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false, // for full height if needed
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    customShowDialog(context, ChangePasswordDialog());
                  },
                  child: Text(
                    textAlign: TextAlign.center,
                    getTranslated("change_password", context)!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: "Roboto",
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    customShowDialog(context, LogoutDialog());
                  },
                  child: Text(
                    textAlign: TextAlign.center,
                    getTranslated("logout", context)!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: "Roboto",
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: 0.5,
                  color: ColorResources.color9a9a9a,
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    textAlign: TextAlign.center,
                    getTranslated("cancel", context)!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: ColorResources.mainColor,
                      fontFamily: "Roboto",
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
