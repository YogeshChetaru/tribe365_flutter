import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/utility.dart';
import '../../../../common/basewidget/custom_header_back_widget.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../main.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../controllers/profile_controller.dart';
import '../domain/models/view_comment_list_response.dart';

class ProfileActionsCommentsScreen extends StatefulWidget {
  // final ViewActionListData item;
  final String actionId;

  const ProfileActionsCommentsScreen({super.key, required this.actionId /*required this.item*/
      });

  @override
  ProfileActionsCommentsScreenState createState() => ProfileActionsCommentsScreenState();
}

class ProfileActionsCommentsScreenState extends State<ProfileActionsCommentsScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  ProfileController controller = Provider.of<ProfileController>(Get.context!, listen: false);

  @override
  void initState() {
    loadAPI();
    super.initState();
  }

  void loadAPI() {
    controller.viewActionComments(widget.actionId.toString());
    controller.viewActionDetail(widget.actionId.toString());
  }

  @override
  Widget build(BuildContext context) {
    String statusText = getTranslated("not_started", context)!;
    Color statusColor = ColorResources.colorED1C24;
    if (controller.viewActionDetailsData != null) {
      if (controller.viewActionDetailsData!.orgStatus?.toLowerCase() == "started") {
        statusText = getTranslated("started", context)!;
        statusColor = ColorResources.colorF6941D;
      } else if (controller.viewActionDetailsData!.orgStatus?.toLowerCase() == "completed") {
        statusText = getTranslated("completed", context)!;
        statusColor = ColorResources.color39B54A;
      }
    }
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
                  title: getTranslated("actions", context)!,
                ),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (profileProvider.viewActionDetailsData != null)
                          Container(
                            margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                            width: MediaQuery.sizeOf(context).width,
                            decoration: BoxDecoration(
                              color: ColorResources.white,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorResources.colorAAADC4,
                                  blurRadius: 1.0,
                                ),
                              ],
                            ),
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: ColorResources.mainColor, width: 1),
                                        image: DecorationImage(
                                          image: AssetImage(Images.imgUserCircleGray),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        profileProvider.viewActionDetailsData!.name!,
                                        style: TextStyle(
                                          fontSize: Dimensions.sp14,
                                          fontWeight: FontWeight.w600,
                                          color: ColorResources.color9a9a9a,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(profileProvider.viewActionDetailsData!.description!,
                                    style: TextStyle(
                                      fontSize: Dimensions.sp12,
                                      fontWeight: FontWeight.w500,
                                      color: ColorResources.color9a9a9a,
                                      fontFamily: 'Roboto',
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: MediaQuery.sizeOf(context).width,
                                  height: 0.5,
                                  color: ColorResources.color9a9a9a,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 30,
                                      child: Text(
                                        "${getTranslated("start_date", context)!}:",
                                        style: TextStyle(
                                          fontSize: Dimensions.sp13,
                                          fontWeight: FontWeight.w500,
                                          color: ColorResources.color9a9a9a,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 70,
                                      child: Text(
                                        profileProvider.viewActionDetailsData!.startedDate!,
                                        style: TextStyle(
                                          fontSize: Dimensions.sp14,
                                          fontWeight: FontWeight.w600,
                                          color: ColorResources.color9a9a9a,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 30,
                                      child: Text(
                                        "${getTranslated("due_date", context)!}:",
                                        style: TextStyle(
                                          fontSize: Dimensions.sp13,
                                          fontWeight: FontWeight.w500,
                                          color: ColorResources.color9a9a9a,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 70,
                                      child: Text(
                                        profileProvider.viewActionDetailsData!.dueDate!,
                                        style: TextStyle(
                                          fontSize: Dimensions.sp14,
                                          fontWeight: FontWeight.w600,
                                          color: ColorResources.color9a9a9a,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 30,
                                      child: Text(
                                        "${getTranslated("status", context)!}:",
                                        style: TextStyle(
                                          fontSize: Dimensions.sp13,
                                          fontWeight: FontWeight.w500,
                                          color: ColorResources.color9a9a9a,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 70,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 14,
                                            height: 14,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: statusColor,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            statusText,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: Dimensions.sp12,
                                              fontWeight: FontWeight.w500,
                                              color: statusColor,
                                              fontFamily: 'Roboto',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 30,
                                      child: Text(
                                        "${getTranslated("responsible", context)!}:",
                                        style: TextStyle(
                                          fontSize: Dimensions.sp13,
                                          fontWeight: FontWeight.w500,
                                          color: ColorResources.color9a9a9a,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 70,
                                      child: Text(
                                        profileProvider.viewActionDetailsData!.responsibleName!,
                                        style: TextStyle(
                                          fontSize: Dimensions.sp14,
                                          fontWeight: FontWeight.w600,
                                          color: ColorResources.color9a9a9a,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                            color: ColorResources.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: ColorResources.colorAAADC4,
                                blurRadius: 1.0,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  flex: 75,
                                  child: TextField(
                                    controller: profileProvider.commentController,
                                    maxLines: 1,
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
                                      hint: Text(
                                        getTranslated("type_your_comment", context)!,
                                        style: const TextStyle(
                                          color: ColorResources.color9a9a9a,
                                          fontSize: Dimensions.sp14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  flex: 25,
                                  child: InkWell(
                                    onTap: () {
                                      if (profileProvider.commentController.text.toString().trim().isEmpty) {
                                        showCustomSnackBar(getTranslated("please_enter_comment", context), context);
                                      } else {
                                        profileProvider.addActionComments(widget.actionId, profileProvider.commentController.text.toString().trim());
                                      }
                                    },
                                    child: profileProvider.isLoadingBtn == true
                                        ? SizedBox(
                                            height: 70,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                valueColor: AlwaysStoppedAnimation<Color>(
                                                  Theme.of(context).primaryColor,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(
                                            alignment: Alignment.center,
                                            height: 70,
                                            decoration: BoxDecoration(
                                              color: ColorResources.mainColor,
                                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), topRight: Radius.circular(10)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: ColorResources.colorAAADC4,
                                                  blurRadius: 1.0,
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              getTranslated("send", context)!,
                                              style: TextStyle(
                                                fontSize: Dimensions.sp16,
                                                fontWeight: FontWeight.w700,
                                                color: ColorResources.white,
                                                fontFamily: 'Roboto',
                                              ),
                                            ),
                                          ),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                          child: Text(
                            getTranslated("comments", context)!,
                            style: TextStyle(
                              fontSize: Dimensions.sp18,
                              fontWeight: FontWeight.w700,
                              color: ColorResources.color9a9a9a,
                              fontFamily: 'Roboto',
                            ),
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
                            : profileProvider.viewActionCommentList == null
                                ? Container(
                                    margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      getTranslated("no_comments_found", context)!,
                                      style: TextStyle(
                                        color: ColorResources.color9a9a9a,
                                        fontSize: Dimensions.sp14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                : profileProvider.viewActionCommentList!.isEmpty
                                    ? Container(
                                        margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          getTranslated("no_comments_found", context)!,
                                          style: TextStyle(
                                            color: ColorResources.color9a9a9a,
                                            fontSize: Dimensions.sp14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                        width: MediaQuery.sizeOf(context).width,
                                        decoration: BoxDecoration(
                                          color: ColorResources.white,
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: ColorResources.colorAAADC4,
                                              blurRadius: 1.0,
                                            ),
                                          ],
                                        ),
                                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics: AlwaysScrollableScrollPhysics(),
                                          itemCount: profileProvider.viewActionCommentList!.length,
                                          itemBuilder: (context, index) {
                                            ViewCommentListData commentData = profileProvider.viewActionCommentList![index];
                                            return Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: 20,
                                                      height: 20,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(color: ColorResources.mainColor, width: 1),
                                                        image: DecorationImage(
                                                          image: AssetImage(Images.imgUserCircleGray),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        commentData.name!,
                                                        style: TextStyle(
                                                          fontSize: Dimensions.sp12,
                                                          fontWeight: FontWeight.w600,
                                                          color: ColorResources.color9a9a9a,
                                                          fontFamily: 'Roboto',
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        textAlign: TextAlign.end,
                                                        Utility.convertDataIntoddMMMyyyyhhmma(commentData.createdAt!),
                                                        style: TextStyle(
                                                          fontSize: Dimensions.sp10,
                                                          fontWeight: FontWeight.w400,
                                                          color: ColorResources.color9a9a9a,
                                                          fontFamily: 'Roboto',
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(commentData.comment!,
                                                    style: TextStyle(
                                                      fontSize: Dimensions.sp12,
                                                      fontWeight: FontWeight.w500,
                                                      color: ColorResources.color9a9a9a,
                                                      fontFamily: 'Roboto',
                                                    )),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  width: MediaQuery.sizeOf(context).width,
                                                  height: 0.5,
                                                  color: ColorResources.color9a9a9a,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            );
                                          },
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
}
