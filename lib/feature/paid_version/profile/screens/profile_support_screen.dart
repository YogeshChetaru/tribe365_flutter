import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/dimensions.dart';
import '../../../../common/basewidget/custom_header_back_widget.dart';
import '../../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../../helper/api_checker.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../main.dart';
import '../../../../utill/images.dart';
import '../../../../utill/utility.dart';
import '../controllers/profile_controller.dart';
import '../widgets/popupinfo.dart';
import '../widgets/support_history_item.dart';

class ProfileSupportScreen extends StatefulWidget {
  const ProfileSupportScreen({super.key});

  @override
  ProfileSupportScreenState createState() => ProfileSupportScreenState();
}

class ProfileSupportScreenState extends State<ProfileSupportScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  final TextEditingController tellUsController = TextEditingController();
  final FocusNode tellUsFocus = FocusNode();
  ProfileController profileController =  Provider.of<ProfileController>(Get.context!,listen: false);

  @override
  void initState() {
    profileController.initData();
    loadAPI();
    super.initState();
  }

  getImageData(File? data) {
    profileController.updateFileData(data!);
  }

  void loadAPI() {
    profileController.viewUserProfile().then((onValue){
      profileController.viewSupportHistoryListAPI();
    });

  }

  @override
  void dispose() {
    tellUsController.dispose();
    tellUsFocus.dispose();
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
                CustomHeaderBack(
                  title: getTranslated("support", context)!,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: ColorResources.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: ColorResources.colorAAADC4,
                              blurRadius: 3.0,
                            ),
                          ],
                        ),
                        margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      width: MediaQuery.sizeOf(context).width,
                                      child: Text(
                                        getTranslated("tell_us", context)!,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: ColorResources.black,
                                        ),
                                      ),
                                    )),
                                InkWell(onTap: (){
                                  showImgPickerCustomDialog(context, getImageData);
                                },
                                  child: Image.asset(
                                    Images.imgAttachmentBlack,
                                    width: 18,
                                    height: 18,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width,
                              decoration: BoxDecoration(
                                color: ColorResources.colorF8F8F8,
                                border: Border.all(color: ColorResources.colorF8F8F8, width: 0.5),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              padding: EdgeInsets.fromLTRB(15, 10, 5, 10),
                              child: TextField(
                                textAlign: TextAlign.start,
                                controller: profileProvider.tellUsController,
                                focusNode: profileProvider.tellUsFocus,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                maxLines: 7,
                                style: const TextStyle(
                                  fontSize: Dimensions.sp12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Roboto',
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  hintText: getTranslated("if_you_have_experienced_any_issues_with_the_app_please_report_them_here", context),
                                  hintStyle: const TextStyle(
                                    color: ColorResources.color9a9a9a,
                                    fontSize: Dimensions.sp10,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ),
                            ),
                            if (profileProvider.file != null)
                              Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                  child: Image.file(
                                    profileProvider.file!,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.fill,
                                  )
                              ),
                            SizedBox(
                              height: 15,
                            ),
                            profileProvider.isLoadingBtn?
                            Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor,
                                ),
                              ),
                            ):
                            InkWell(
                              onTap: () async {
                                String tellUs = profileProvider.tellUsController.text.toString().trim();
                                if(tellUs.isEmpty) {
                                  showCustomSnackBar(getTranslated('please_enter_description', context), context, isError: true);
                                }
                                else{
                                  String? base64Image = "";
                                  if(profileProvider.file!=null){
                                    base64Image = await Utility.imageToBase64(profileProvider.file!.path);
                                  }
                                  profileProvider.sendOffloadingData(tellUs, base64Image!).then((apiResponse){
                                    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
                                      Map<String, dynamic> map = apiResponse.response!.data;
                                      showCustomSnackBar(map["message"], Get.context!, isError: false);
                                      profileProvider.updateInitData();
                                      profileProvider.viewSupportHistoryListAPI();
                                    } else {
                                      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
                                      ApiChecker.checkApi(apiResponse);
                                    }
                                  });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.fromLTRB(60, 12, 60, 12),
                                decoration: BoxDecoration(
                                  color: ColorResources.mainColor,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                ),
                                child: Text(
                                  getTranslated("send", context)!,
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
                      Expanded(flex: 1,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                          width: MediaQuery.sizeOf(context).width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getTranslated("history", context)!,
                                style: TextStyle(
                                  fontSize: Dimensions.sp16,
                                  color: ColorResources.black,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                              SizedBox(height: 10,),
                              profileProvider.isLoading == true
                                  ? Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).primaryColor,
                                  ),
                                ),
                              )
                                  : profileProvider.supportHistoryData == null ||
                                  profileProvider.supportHistoryData!.isEmpty
                                  ? Container(
                                margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                                child: Text(
                                  getTranslated("no_submission_yet", context)!,
                                  style: TextStyle(
                                    fontSize: Dimensions.sp14,
                                    color: ColorResources.color9a9a9a,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              )
                                  : Expanded(
                                child: ListView.builder(
                                  itemCount: profileProvider.supportHistoryData!.length,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return SupportHistoryItem(
                                      data: profileProvider.supportHistoryData![index],
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
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  void showImgPickerCustomDialog(BuildContext context, Function getImageData) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Center(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorResources.white.withOpacity(0.01),
                ),
                height: 180,
                child: PopupInfo(
                  getImageDatasub: getImageData,
                )),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        }
        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }
}
