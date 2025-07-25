import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/common/basewidget/custom_header_back_widget.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/utility.dart';
import '../../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../main.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../profile/widgets/popupinfo.dart';
import '../controllers/offloading_controller.dart';
import '../widgets/offloading_chat_item.dart';

class OffLoadingChatDetailsScreen extends StatefulWidget {
  final String feedbackId;

  const OffLoadingChatDetailsScreen({super.key, required this.feedbackId});

  @override
  OffLoadingChatDetailsScreenState createState() => OffLoadingChatDetailsScreenState();
}

class OffLoadingChatDetailsScreenState extends State<OffLoadingChatDetailsScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  ProfileController profileController = Provider.of<ProfileController>(Get.context!, listen: false);
  OffloadingController controller = Provider.of<OffloadingController>(Get.context!, listen: false);

  void apiLoad() {
    profileController.viewUserProfile().then((onValue) {
      controller.updateData(profileController.userProfileData);
      controller.viewChatMessages(int.parse(widget.feedbackId.toString()));
    });
  }

  @override
  void initState() {
    super.initState();
    controller.initData();
    apiLoad();
  }

  getImageData(File? data) async {
    String? base64Image = "";
    if(data!=null){
      base64Image = await Utility.imageToBase64(data.path);
      controller.sendChatMessages(
        "img",
        base64Image!,
        widget.feedbackId.toString(),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Consumer<OffloadingController>(builder: (context, offloadingProvider, _) {
          return Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            color: ColorResources.screenBg,
            child: Column(
              children: [
                CustomHeaderBack(title: ""),
                if(offloadingProvider.feedbackData!=null)
                Container(
                  margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: ColorResources.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: ColorResources.colorAAADC4,
                        blurRadius: 3.0,
                      ),
                    ],
                  ),
                  padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getTranslated("details", context)!,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: ColorResources.mainColor, fontFamily: 'roboto'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        Utility.convertDataIntoddMMMyyyyhhmma(
                            offloadingProvider.feedbackData!.initialMsgDate!),
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: ColorResources.mainColor, fontFamily: 'roboto'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        offloadingProvider.feedbackData!.initialMessage!,
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: ColorResources.color333333, fontFamily: 'roboto'),
                      ),
                      if (offloadingProvider.feedbackData!.msgImageUrl != "")
                        Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Image.network(
                              offloadingProvider.feedbackData!.msgImageUrl!,
                              width: 60,
                              height: 60,
                              fit: BoxFit.fill,
                            )
                        ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: offloadingProvider.messagesList == null || offloadingProvider.messagesList!.isEmpty
                          ? Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                              child: Text(
                                getTranslated("no_chat_available", context)!,
                                style: TextStyle(
                                  fontSize: Dimensions.sp14,
                                  color: ColorResources.color9a9a9a,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: ListView.builder(
                                itemCount: offloadingProvider.messagesList!.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return OffloadingChatItem(
                                    data: offloadingProvider.messagesList![index],
                                  );
                                },
                              ),
                            ),
                    ))
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: SafeArea(
        child: Consumer<OffloadingController>(builder: (context, offloadingProvider, _) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom, // Moves it up when keyboard shows
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              width: MediaQuery.of(context).size.width,
              height: 70,
              decoration: BoxDecoration(
                color: ColorResources.white,
                boxShadow: [
                  BoxShadow(
                    color: ColorResources.colorAAADC4,
                    blurRadius: 3.0,
                  ),
                ],
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      showImgPickerCustomDialog(context, getImageData);
                    },
                    child: Image.asset(
                      Images.imgAttachmentBlack,
                      width: 20,
                      height: 20,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                        color: ColorResources.color808080.withAlpha(51),
                        border: Border.all(color: ColorResources.color808080.withAlpha(51), width: 0.5),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                      ),
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: TextField(
                        controller: offloadingProvider.tellUsController,
                        focusNode: offloadingProvider.tellUsFocus,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        style: const TextStyle(
                          fontSize: Dimensions.sp14,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Roboto',
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          hintText: getTranslated("new_massage", context),
                          hintStyle: const TextStyle(
                            color: ColorResources.color9a9a9a,
                            fontSize: Dimensions.sp14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  offloadingProvider.isLoadingData == true
                      ? Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  )
                      : InkWell(
                    onTap: () {
                      String msg = offloadingProvider.tellUsController.text.trim().toString();
                      if (msg.isEmpty) {
                        showCustomSnackBar(getTranslated('please_enter_massage', context), context, isError: true);
                      } else {
                        offloadingProvider.sendChatMessages(
                          "msg",
                          msg,
                          widget.feedbackId.toString(),
                        );
                      }
                    },
                    child: Text(
                      getTranslated("send", context)!,
                      style: TextStyle(fontFamily: 'roboto', fontSize: Dimensions.sp18, color: ColorResources.black, fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
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
      barrierColor: Colors.black.withAlpha(128),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Center(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorResources.white.withAlpha(3),
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


