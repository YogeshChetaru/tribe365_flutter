import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/custom_route.dart';
import 'package:tribe365_new/utill/images.dart';
import '../../../../common/basewidget/custom_header_back_widget.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/dimensions.dart';
import '../controllers/profile_controller.dart';
import '../domain/models/view_action_list_response.dart';
import '../domain/models/view_action_tier_list_response.dart';
import '../domain/models/view_user_by_type_list_response.dart';
import '../widgets/responsible_person_dialog.dart';
import '../widgets/risks_dialog.dart';
import '../widgets/select_tier_dialog.dart';

class ProfileAddActionsScreen extends StatefulWidget {
  final String wayFrom;
 final ViewActionListData? actionListData;
  const ProfileAddActionsScreen({super.key,required this.wayFrom,this.actionListData});

  @override
  ProfileAddActionsScreenState createState() => ProfileAddActionsScreenState();
}

class ProfileAddActionsScreenState extends State<ProfileAddActionsScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  TextEditingController descController = TextEditingController();
  FocusNode descFocus = FocusNode();

  @override
  void initState() {
    loadAPI();
    editDataAdd();
    super.initState();
  }

  @override
  void dispose() {
    descController.dispose();
    descFocus.dispose();
    super.dispose();
  }

  void editDataAdd() {
    ProfileController controller = Provider.of<ProfileController>(context,listen: false);
    if(widget.wayFrom=="edit"){
      ViewActionListData data =  widget.actionListData!;
      descController.text = data.description!;
      ViewActionTierListData actionTierListData = ViewActionTierListData(name:data.tier ,id:int.parse(data.tierId!)) ;
      controller.updateFilteredActionTierList(actionTierListData);
      ViewUserByTypeListData userdata = ViewUserByTypeListData(id: int.parse(data.responsibleUserId.toString()),name: data.responsibleName!) ;
      controller.updateFilteredUserList(userdata);
      controller.updateSelectedData("startDate", data.startedDate!);
      controller.updateSelectedData("dueData", data.dueDate!);
      if (data.orgStatus == "" ||data.orgStatus =="NOT STARTED") {
        controller.addActionStatus("notStarted");
      }
     else if (data.orgStatus?.toLowerCase() == "started") {
        controller.addActionStatus("started");
      } else if (data.orgStatus?.toLowerCase() == "completed") {
        controller.addActionStatus("complete");
      }
    }
  }

  void loadAPI() {
    ProfileController controller = Provider.of<ProfileController>(context, listen: false);
    controller.viewActionTierListApi();
    controller.viewThemeList(controller.userProfileData!.orgId.toString());
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
                  title: widget.wayFrom=="edit"?getTranslated("edit_actions", context)!: getTranslated("add_actions", context)!,
                ),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            customShowDialog(context, SelectTierDialog());
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getTranslated("select_tier", context)!,
                                  style: TextStyle(
                                    fontSize: Dimensions.sp16,
                                    color: ColorResources.color9a9a9a,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: MediaQuery.sizeOf(context).width,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: ColorResources.color9a9a9a, width: 0.5),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                  child: Text(
                                    profileProvider.selectedActionTierListData == null ? "" : profileProvider.selectedActionTierListData!.name!,
                                    style: const TextStyle(
                                      fontSize: Dimensions.sp14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        profileProvider.showDepartment == true
                            ? InkWell(
                                onTap: () {
                                  if (profileProvider.selectedActionTierListData!.name!.toString() == "OFFICE") {
                                    // dialogResponsibleDepartment("OFFICE");
                                  }
                                  if (profileProvider.selectedActionTierListData!.name!.toString() == "DEPARTMENT") {
                                    // dialogResponsibleDepartment("DEPARTMENT");
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        profileProvider.departmentLabel,
                                        style: TextStyle(
                                          fontSize: Dimensions.sp16,
                                          color: ColorResources.color9a9a9a,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        width: MediaQuery.sizeOf(context).width,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: ColorResources.color9a9a9a, width: 0.5),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                        ),
                                        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                        child: Text(
                                          "",
                                          style: const TextStyle(
                                            fontSize: Dimensions.sp14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox.shrink(),
                        InkWell(
                          onTap: () {
                            if (profileProvider.userList == null || profileProvider.userList!.isEmpty) {
                              showCustomSnackBar(getTranslated("no_staff_found", context)!, context);
                            } else {
                              customShowDialog(context, ResponsiblePersonDialog(name: profileProvider.selectedActionTierListData!.name!));
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getTranslated("responsible_person", context)!,
                                  style: TextStyle(
                                    fontSize: Dimensions.sp16,
                                    color: ColorResources.color9a9a9a,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: MediaQuery.sizeOf(context).width,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: ColorResources.color9a9a9a, width: 0.5),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                  child: Text(
                                    profileProvider.selectedUserListData == null ? "" : profileProvider.selectedUserListData!.name!,
                                    style: const TextStyle(
                                      fontSize: Dimensions.sp14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            customShowDialog(context, RisksDialog());
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getTranslated("risks", context)!,
                                  style: TextStyle(
                                    fontSize: Dimensions.sp16,
                                    color: ColorResources.color9a9a9a,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: MediaQuery.sizeOf(context).width,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: ColorResources.color9a9a9a, width: 0.5),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                  child: Text(
                                    profileProvider.selectedThemeData == null ? "" : profileProvider.selectedThemeData!.title!,
                                    style: const TextStyle(
                                      fontSize: Dimensions.sp14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            profileProvider.getDate(context, "startDate");
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getTranslated("start_date", context)!,
                                  style: TextStyle(
                                    fontSize: Dimensions.sp16,
                                    color: ColorResources.color9a9a9a,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: MediaQuery.sizeOf(context).width,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: ColorResources.color9a9a9a, width: 0.5),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                  child: Text(
                                    profileProvider.selectedStartData,
                                    style: const TextStyle(
                                      fontSize: Dimensions.sp14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            profileProvider.getDate(context, "dueData");
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getTranslated("due_date", context)!,
                                  style: TextStyle(
                                    fontSize: Dimensions.sp16,
                                    color: ColorResources.color9a9a9a,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: MediaQuery.sizeOf(context).width,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: ColorResources.color9a9a9a, width: 0.5),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                  child: Text(
                                    profileProvider.selectedDueData,
                                    style: const TextStyle(
                                      fontSize: Dimensions.sp14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getTranslated("status", context)!,
                                style: TextStyle(
                                  fontSize: Dimensions.sp16,
                                  color: ColorResources.color9a9a9a,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: () {
                                          profileProvider.addActionStatus("notStarted");
                                        },
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              profileProvider.actionStatus == "notStarted"
                                                  ? Images.imgActionCircleCheckRed
                                                  : Images.imgActionCircleUncheckRed,
                                              width: 20,
                                              height: 20,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(getTranslated("not_started", context)!,
                                                style: TextStyle(
                                                  fontSize: Dimensions.sp14,
                                                  color: ColorResources.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Roboto',
                                                ))
                                          ],
                                        ),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: () {
                                          profileProvider.addActionStatus("started");
                                        },
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              profileProvider.actionStatus == "started"
                                                  ? Images.imgActionCircleCheckYellow
                                                  : Images.imgActionCircleUncheckYellow,
                                              width: 20,
                                              height: 20,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(getTranslated("started", context)!,
                                                style: TextStyle(
                                                  fontSize: Dimensions.sp14,
                                                  color: ColorResources.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Roboto',
                                                ))
                                          ],
                                        ),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: () {
                                          profileProvider.addActionStatus("complete");
                                        },
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              profileProvider.actionStatus == "complete"
                                                  ? Images.imgActionCircleCheckGreen
                                                  : Images.imgActionCircleUncheckGreen,
                                              width: 20,
                                              height: 20,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(getTranslated("complete", context)!,
                                                style: TextStyle(
                                                  fontSize: Dimensions.sp14,
                                                  color: ColorResources.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Roboto',
                                                ))
                                          ],
                                        ),
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getTranslated("description", context)!,
                                style: TextStyle(
                                  fontSize: Dimensions.sp16,
                                  color: ColorResources.color9a9a9a,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width,
                                decoration: BoxDecoration(
                                  border: Border.all(color: ColorResources.color9a9a9a, width: 0.5),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                ),
                                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: TextField(
                                  maxLines: 5,
                                  controller: descController,
                                  focusNode: descFocus,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  style: const TextStyle(
                                    fontSize: Dimensions.sp14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto',
                                  ),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    border: InputBorder.none,
                                    hintStyle: const TextStyle(
                                      color: ColorResources.color9a9a9a,
                                      fontSize: Dimensions.sp14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        profileProvider.isLoading
                            ? Container(
                                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  onSaveClick();
                                },
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                  width: MediaQuery.sizeOf(context).width,
                                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                  decoration: BoxDecoration(
                                    color: ColorResources.mainColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  child: Text(
                                    getTranslated("submit", context)!,
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
              ],
            ),
          );
        }),
      ),
    );
  }

  void onSaveClick() {
    ProfileController controller = Provider.of<ProfileController>(context, listen: false);
    if (controller.selectedActionTierListData == null) {
      showCustomSnackBar(getTranslated("please_select_one_tier", context), context, isError: true);
    }
    /*else if (tierText.contains("OFFICE") && responsibleText.isEmpty) {
      showToast("Please select responsible");
      return;
    } else if (tierText.contains("DEPARTMENT") && responsibleText.isEmpty) {
      showToast("Please select responsible");
      return;
    }*/
    else if (controller.selectedActionTierListData!.name!.contains("INDIVIDUAL") && controller.selectedUserListData == null) {
      showCustomSnackBar(getTranslated("please_select_responsible", context), context, isError: true);
    } else if (controller.selectedStartData.isEmpty) {
      showCustomSnackBar(getTranslated("please_enter_start_date", context), context, isError: true);
    } else if (controller.selectedDueData.isEmpty) {
      showCustomSnackBar(getTranslated("please_enter_due_date", context), context, isError: true);
    } else if (controller.actionStatus.isEmpty) {
      showCustomSnackBar(getTranslated("please_select_status", context), context, isError: true);
    } else if (descController.text.trim().isEmpty) {
      showCustomSnackBar(getTranslated("please_enter_description", context), context, isError: true);
    } else {
      if(widget.wayFrom=="edit"){
        List<String> themeIdArray = [];
        if (controller.selectedThemeData != null) {
          themeIdArray.add(controller.selectedThemeData!.id.toString());
        }
        controller.updateActionData(
          widget.actionListData!.id.toString(),
            controller.selectedActionTierListData!,
            controller.selectedUserListData!,
            themeIdArray,
            controller.selectedStartData,
            controller.selectedDueData,
            controller.actionStatus,
            descController.text.trim().toString());
      }
      else{
        List<String> themeIdArray = [];
        if (controller.selectedThemeData != null) {
          themeIdArray.add(controller.selectedThemeData!.id.toString());
        }
        controller.addActionData(
            controller.selectedActionTierListData!,
            controller.selectedUserListData!,
            themeIdArray,
            controller.selectedStartData,
            controller.selectedDueData,
            controller.actionStatus,
            descController.text.trim().toString());
      }

    }
  }


}
