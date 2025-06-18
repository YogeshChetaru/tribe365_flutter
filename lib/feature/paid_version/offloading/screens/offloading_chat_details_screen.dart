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
import '../domain/models/view_offloading_list_response.dart';
import '../domain/models/view_reflection_list_response.dart';
import '../widgets/offloading_chat_item.dart';

class OffLoadingChatDetailsScreen extends StatefulWidget {
  final ViewReflectionListData? reflectionData;
  final ViewOffLoadingListData? offLoadingData;

  const OffLoadingChatDetailsScreen({super.key, this.reflectionData, this.offLoadingData});

  @override
  OffLoadingChatDetailsScreenState createState() => OffLoadingChatDetailsScreenState();
}

class OffLoadingChatDetailsScreenState extends State<OffLoadingChatDetailsScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  ProfileController profileController = Provider.of<ProfileController>(Get.context!, listen: false);
  OffloadingController offloadingController = Provider.of<OffloadingController>(Get.context!, listen: false);

  void apiLoad() {
    profileController.viewUserProfile().then((onValue) {
      offloadingController.updateData(profileController.userProfileData);
      if (widget.offLoadingData == null) {
        offloadingController.viewChatMessages(widget.reflectionData!.id!);
      } else {
        offloadingController.viewChatMessages(widget.offLoadingData!.id!);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    offloadingController.initData();
    apiLoad();
  }

  getImageData(File? data) async {
    String? base64Image = "";
    if(data!=null){
      base64Image = await Utility.imageToBase64(data.path);
      if (widget.offLoadingData == null) {
        offloadingController.sendChatMessages(
          "img",
          base64Image!,
          widget.reflectionData!.id!.toString(),
        );
      }
      else {
        offloadingController.sendChatMessages(
          "img",
          base64Image!,
          widget.offLoadingData!.id!.toString(),
        );
      }
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
                        Utility.convertDataIntoddMMMyyyyhhmma(widget.reflectionData == null ? widget.offLoadingData!.createdAt! : widget.reflectionData!.createdAt!),
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: ColorResources.mainColor, fontFamily: 'roboto'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.reflectionData == null ? widget.offLoadingData!.message! : widget.reflectionData!.message!,
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: ColorResources.color333333, fontFamily: 'roboto'),
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
                                itemCount: offloadingController.messagesList!.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return OffloadingChatItem(
                                    data: offloadingController.messagesList![index],
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
        child: Padding(
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
                      controller: offloadingController.tellUsController,
                      focusNode: offloadingController.tellUsFocus,
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
                offloadingController.isLoadingData == true
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
                          String msg = offloadingController.tellUsController.text.trim().toString();
                          if (msg.isEmpty) {
                            showCustomSnackBar(getTranslated('please_enter_massage', context), context, isError: true);
                          } else {
                            if (widget.offLoadingData == null) {
                              offloadingController.sendChatMessages(
                                "msg",
                                msg,
                                widget.reflectionData!.id!.toString(),
                              );
                            }
                            else {
                              offloadingController.sendChatMessages(
                                "msg",
                                msg,
                                widget.offLoadingData!.id!.toString(),
                              );
                            }
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
        ),
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
