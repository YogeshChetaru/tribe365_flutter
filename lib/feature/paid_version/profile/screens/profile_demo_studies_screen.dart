import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/profile/widgets/build_culture_structure_main.dart';
import 'package:tribe365_new/feature/paid_version/profile/widgets/build_diagnostics_main.dart';
import 'package:tribe365_new/feature/paid_version/profile/widgets/build_motivation_main.dart';
import 'package:tribe365_new/feature/paid_version/profile/widgets/build_sentiment_index_main.dart';
import 'package:tribe365_new/feature/paid_version/profile/widgets/build_tribe_meter_main.dart';
import 'package:tribe365_new/feature/paid_version/profile/widgets/culture_index_main.dart';
import 'package:tribe365_new/feature/paid_version/profile/widgets/engagement_index_main.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../../../../common/basewidget/custom_header_back_widget.dart';
import '../../../../utill/dimensions.dart';
import '../../../free_version/free_dashboard/domain/models/get_office_list_response.dart';
import '../../../free_version/free_dashboard/domain/models/view_department_list_response.dart';
import '../controllers/profile_controller.dart';
import '../widgets/build_personality_type_main.dart';
import '../widgets/build_team_role_main.dart';

class ProfileDemoStudiesScreen extends StatefulWidget {
  const ProfileDemoStudiesScreen({super.key});

  @override
  ProfileDemoStudiesScreenState createState() => ProfileDemoStudiesScreenState();
}

class ProfileDemoStudiesScreenState extends State<ProfileDemoStudiesScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  void loadAPI() {
    final ProfileController profileController = Provider.of<ProfileController>(context, listen: false);
    profileController.updateLoaderStatus(true);
    profileController.viewUserProfile().then((onValue) {
      profileController.updateOrgID(profileController.userProfileData);
      profileController.viewDepartmentList().then((value) {
        profileController.viewOfficeList().then((onValue) {
          profileController.viewOrgDashboardReportWithFilter(true);
        });
      });
    });
  }

  @override
  void initState() {
    loadAPI();
    super.initState();
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
                CustomHeaderBack(
                  title: "",
                ),
                SizedBox(
                  height: 20,
                ),
                profileProvider.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor,
                          ),
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Row(
                          children: [
                            profileProvider.officesList == null
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
                                              value: profileProvider.officeSelectedValue,
                                              items: profileProvider.officesList!.map((Offices value) {
                                                return DropdownMenuItem<Offices>(
                                                  value: value,
                                                  child: Text(
                                                    value.office!,
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
                                                profileProvider.updateOfficeSelectedValue(newValue);
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
                            profileProvider.departmentList == null
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
                                              value: profileProvider.departmentSelectedValue,
                                              items: profileProvider.departmentList!.map((ViewDepartmentListData value) {
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
                                                profileProvider.updateDepartmentSelectedValue(newValue);
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
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: SizedBox(
                      child:profileProvider.isLoadingBtn
                          ? Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor,
                          ),
                        ),
                      )
                          :  Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          if(profileProvider.cultureIndexList!=null)
                          CultureIndexMain(profileProvider: profileProvider),
                          if(profileProvider.cultureIndexList!=null)
                          SizedBox(
                            height: 15,
                          ),
                          if(profileProvider.engagementIndexList!=null)
                          EngagementIndexMain(profileProvider: profileProvider),
                          if(profileProvider.engagementIndexList!=null)
                          SizedBox(
                            height: 15,
                          ),
                          if(profileProvider.viewTeamRoles.isNotEmpty)
                          BuildTeamRoleMain(profileProvider: profileProvider,),
                          if(profileProvider.viewTeamRoles.isNotEmpty)
                          SizedBox(
                            height: 15,
                          ),
                          if(profileProvider.personalityTypes.isNotEmpty)
                          BuildPersonalityTypeMain(profileProvider: profileProvider),
                          if(profileProvider.personalityTypes.isNotEmpty)
                          SizedBox(
                            height: 15,
                          ),
                          if(profileProvider.cultureStructureItems!=null)
                          BuildCultureStructureMain(),
                          if(profileProvider.cultureStructureItems!=null)
                          SizedBox(
                            height: 15,
                          ),
                          if(profileProvider.viewSOTMotivationReportList!=null)
                          BuildMotivationMain(profileProvider: profileProvider),
                          if(profileProvider.viewSOTMotivationReportList!=null)
                          SizedBox(
                            height: 15,
                          ),
                          if(profileProvider.getDiagnosticReportList!=null)
                          BuildDiagnosticsMain(),
                          if(profileProvider.getDiagnosticReportList!=null)
                          SizedBox(
                            height: 15,
                          ),
                          if(profileProvider.getTribeMeterReportList!=null)
                          BuildTribeMeterMain(),
                          if(profileProvider.getTribeMeterReportList!=null)
                          SizedBox(
                            height: 15,
                          ),
                          if(profileProvider.viewHappyIndexMonthGraphList!=null)
                          BuildSentimentIndexMain(),
                          if(profileProvider.viewHappyIndexMonthGraphList!=null)
                          SizedBox(
                            height: 15,
                          ),


                          /*ValueAndBeliefMain(profileProvider: profileProvider,),
                          SizedBox(
                            height: 15,
                          ),*/
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
