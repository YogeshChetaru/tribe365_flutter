import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/profile/screens/profile_actions_comments_screen.dart';
import 'package:tribe365_new/feature/paid_version/profile/screens/profile_add_actions_screen.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/custom_route.dart';
import '../../../../common/basewidget/custom_header_back_widget.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../controllers/profile_controller.dart';
import '../widgets/actiondeletedialog.dart';

class ProfileActionsScreen extends StatefulWidget {
  const ProfileActionsScreen({super.key});

  @override
  ProfileActionsScreenState createState() => ProfileActionsScreenState();
}

class ProfileActionsScreenState extends State<ProfileActionsScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

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
                  title: getTranslated("view_actions", context)!,
                ),
                Expanded(
                  flex: 1,
                  child: /*Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height,
                    alignment: Alignment.center,
                    child: Text(
                      getTranslated("no_action_found", context)!,
                      style: TextStyle(
                        color: ColorResources.color9a9a9a,
                        fontSize: Dimensions.sp18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )*/
                      SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
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
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: profileProvider.tierSelectedValue,
                                  items: profileProvider.tierList.map((String value) {
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
                                    profileProvider.updateTierSelectedValue(newValue);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Slidable(
                                startActionPane: ActionPane(
                                  motion: const DrawerMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (_) {
                                        routePush(context, ProfileAddActionsScreen());
                                      },
                                      backgroundColor: ColorResources.mainColor,
                                      foregroundColor: Colors.white,
                                      icon: Icons.edit,
                                      label: getTranslated("edit", context)!,
                                    ),
                                  ],
                                ),
                                endActionPane: ActionPane(
                                  motion: const DrawerMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (_) {
                                        customShowDialog(context, ActionDeleteDialog());
                                      },
                                      backgroundColor: ColorResources.mainColor,
                                      foregroundColor: ColorResources.white,
                                      icon: Icons.delete,
                                      label: getTranslated("delete", context)!,
                                    ),
                                  ],
                                ),
                                child: Container(
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
                                              "Alex",
                                              style: TextStyle(
                                                fontSize: Dimensions.sp14,
                                                fontWeight: FontWeight.w600,
                                                color: ColorResources.color9a9a9a,
                                                fontFamily: 'Roboto',
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: (){
                                              routePush(context, ProfileActionsCommentsScreen());
                                            },child: Image.asset(
                                              Images.imgCommentRed,
                                              width: 24,
                                              height: 24,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Test",
                                          style: TextStyle(
                                            fontSize: Dimensions.sp12,
                                            fontWeight: FontWeight.w500,
                                            color: ColorResources.color9a9a9a,
                                            fontFamily: 'Roboto',
                                          )),
                                      SizedBox(height: 5,),
                                      Container(
                                        width: MediaQuery.sizeOf(context).width,
                                        height: 0.5,
                                        color: ColorResources.color9a9a9a,
                                      ),
                                      SizedBox(height: 10,),
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
                                              "05-06-2025",
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
                                      SizedBox(height: 10,),
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
                                              "30-09-2025",
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
                                      SizedBox(height: 10,),
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
                                                    color: ColorResources.mainColor,
                                                  ),

                                                ),
                                                SizedBox(width: 5,),
                                                Text("not started",textAlign: TextAlign.center,style: TextStyle(
                                                  fontSize: Dimensions.sp12,
                                                  fontWeight: FontWeight.w500,
                                                  color: ColorResources.mainColor,
                                                  fontFamily: 'Roboto',
                                                ),),
                                                SizedBox(width: 10,),
                                                InkWell(onTap: (){
                                                  showBottomMenuSheet(context);
                                                },child: Image.asset(Images.imgEditRed,width: 20,height: 20,)),
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                      SizedBox(height: 10,),
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
                                              "yogesh",
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
                              );
                            },
                          ),
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
      floatingActionButton: RawMaterialButton (
        onPressed: () {
          routePush(context, ProfileAddActionsScreen());
        },
        fillColor: ColorResources.mainColor,
        shape: CircleBorder(),
        constraints: BoxConstraints.tightFor(
          width: 56.0,
          height: 56.0,
        ),
        child: Icon(Icons.add, size: 40, color: Colors.white),
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
        return Consumer<ProfileController>(builder: (context, profileProvider, _) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          profileProvider.updateActionStatus("notStarted");
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              profileProvider.actionStatus == "notStarted" ? Images.imgActionCircleCheckRed : Images.imgActionCircleUncheckRed,
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
                      ),
                      SizedBox(height: 15),
                      InkWell(
                        onTap: () {
                          profileProvider.updateActionStatus("started");
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              profileProvider.actionStatus == "started" ? Images.imgActionCircleCheckYellow : Images.imgActionCircleUncheckYellow,
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
                      ),
                      SizedBox(height: 15),
                      InkWell(
                        onTap: () {
                          profileProvider.updateActionStatus("complete");
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              profileProvider.actionStatus == "complete" ? Images.imgActionCircleCheckGreen : Images.imgActionCircleUncheckGreen,
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
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          width: MediaQuery.sizeOf(context).width,
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                          decoration: BoxDecoration(
                            color: ColorResources.mainColor,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
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
                  )

                ],
              ),
            ),
          );
        });
      },
    );
  }
}




