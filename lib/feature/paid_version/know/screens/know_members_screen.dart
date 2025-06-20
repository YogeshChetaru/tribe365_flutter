import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/custom_route.dart';
import '../../../../common/basewidget/custom_header_back_widget.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/dimensions.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/know_controller.dart';
import '../domain/models/view_know_member_details_response.dart';
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
  void initState() {
    super.initState();
    loadAPI();
  }
  void loadAPI() {
    KnowController knowController = Provider.of<KnowController>(context,listen: false);
    final ProfileController profileController = Provider.of<ProfileController>(context, listen: false);
    knowController.viewKnowMemberList();
    profileController.viewUserProfile().then((onValue) {
      knowController.intiUserMemberData(profileController.userProfileData);
    });
  }
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
                    child: knowProvider.isLoadingMember
                        ? SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    )
                        : Column(
                      children: [
                        InkWell(
                          onTap: () {
                            customShowDialog(context, KnowUserListDialog(wayFrom: "member",));
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
                              knowProvider.selectedMemberName,
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
                                  child: Image.asset(knowProvider.engagementKMImagePath,width: 50,height: 50,),
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
                                          color: ColorResources.color9a9a9a,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                      Text(
                                        knowProvider.engagementKMDisplayValue,
                                        style: TextStyle(
                                          fontSize: Dimensions.sp14,
                                          color: knowProvider.engagementKMScoreColor,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                      Text(
                                        knowProvider.engagementKMStatus,
                                        style: TextStyle(
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
                            ],
                          ),
                        ),
                        knowProvider.kudosCountCardStatus==true?
                        knowProvider.kudosCountList==null?
                        SizedBox.shrink():
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: const EdgeInsets.all(16),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: SizedBox(
                                height: 300,
                                child: ListView.builder(
                                  itemCount: knowProvider.kudosCountList!.length,
                                  itemBuilder: (context, index) {
                                    KudosCount item = knowProvider.kudosCountList![index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              item.name ?? '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              (item.kudosCount ?? 0).toString(),
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),

                        ):
                        SizedBox.shrink(),
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
                              knowProvider.personalityTypeList==null?
                              SizedBox.shrink():
                              knowProvider.personalityTypeList!.isEmpty?
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                                child: Text(
                                  knowProvider.personalityTypeDetailsMsg!,
                                  style: TextStyle(
                                    fontSize: Dimensions.sp12,
                                    color: ColorResources.black, // Replace with ColorResources.mainColor
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ):
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                child: GridView.builder(
                                  itemCount: knowProvider.personalityTypeList!.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 3 / 1,
                                  ),
                                  itemBuilder: (context, index) {
                                    return PersonalityTypeItem(personalityTypeDetails:knowProvider.personalityTypeList![index] ,);
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
                              knowProvider.teamRoleList==null?
                              SizedBox.shrink():
                              knowProvider.teamRoleList!.isEmpty?
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                                child: Text(
                                 knowProvider.teamRoleDetailsMsg!,
                                  style: TextStyle(
                                    fontSize: Dimensions.sp12,
                                    color: ColorResources.black, // Replace with ColorResources.mainColor
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ):
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                child: GridView.builder(
                                  itemCount: knowProvider.teamRoleList!.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 3 / 1,
                                  ),
                                  itemBuilder: (context, index) {
                                    return TeamRoleItem(name:knowProvider.teamRoleList![index] ,);
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
                              knowProvider.motivationList==null?
                              SizedBox.shrink():
                              knowProvider.motivationList!.isEmpty?
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                                child: Text(
                                  knowProvider.motivationDetails!,
                                  style: TextStyle(
                                    fontSize: Dimensions.sp12,
                                    color: ColorResources.black, // Replace with ColorResources.mainColor
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ):
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                child: GridView.builder(
                                  itemCount: knowProvider.motivationList!.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 3 / 1,
                                  ),
                                  itemBuilder: (context, index) {
                                    return MotivationItem(name: knowProvider.motivationList![index],);
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
}