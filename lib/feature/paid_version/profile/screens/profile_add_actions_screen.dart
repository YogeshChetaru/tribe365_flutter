import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/images.dart';
import '../../../../common/basewidget/custom_header_back_widget.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/dimensions.dart';
import '../controllers/profile_controller.dart';

class ProfileAddActionsScreen extends StatefulWidget {
  const ProfileAddActionsScreen({super.key});

  @override
  ProfileAddActionsScreenState createState() => ProfileAddActionsScreenState();
}

class ProfileAddActionsScreenState extends State<ProfileAddActionsScreen> {
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
                  title: getTranslated("add_actions", context)!,
                ),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
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
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                                ),
                                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: TextField(
                                  enabled: false,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
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
                        Container(
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
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                                ),
                                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: TextField(
                                  enabled: false,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
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
                        Container(
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
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                                ),
                                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: TextField(
                                  enabled: false,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
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
                        Container(
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
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                                ),
                                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: TextField(
                                  enabled: false,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
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
                        Container(
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
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                                ),
                                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: TextField(
                                  enabled: false,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
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
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: InkWell(
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
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: InkWell(
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
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                                ),
                                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: TextField(
                                  maxLines: 5,
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
                        InkWell(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
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
