import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/main.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/dimensions.dart';
import '../../../../common/basewidget/custom_header_back_widget.dart';
import '../../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/images.dart';
import '../../../../utill/utility.dart';
import '../controllers/profile_controller.dart';
import '../widgets/popupinfo.dart';

class ProfileEditProfileScreen extends StatefulWidget {
  const ProfileEditProfileScreen({super.key});

  @override
  ProfileEditProfileScreenState createState() => ProfileEditProfileScreenState();
}

class ProfileEditProfileScreenState extends State<ProfileEditProfileScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  ProfileController profileController = Provider.of<ProfileController>(Get.context!, listen: false);
  File? file;

  getImageData(File? data) {
    setState(() {
      file = data;
    });
  }

  @override
  void initState() {
    profileController.controllerInit(false);
    profileController.setUserDataController(false);
    super.initState();
  }

  @override
  void dispose() {
    profileController.disposeControllers();
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
                  title: getTranslated("profile", context)!,
                ),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            showImgPickerCustomDialog(context, getImageData);
                          },
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: ColorResources.mainColor, width: 1),
                                  image: DecorationImage(
                                    image: file != null
                                        ? FileImage(
                                            file!,
                                          )
                                        : profileProvider.userProfileData!.profileImage == ""
                                            ? AssetImage(Images.imgUserCircleGray) as ImageProvider
                                            : NetworkImage(profileProvider.userProfileData!.profileImage!) as ImageProvider,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 1,
                                right: 2,
                                child: Image.asset(
                                  Images.imgEditRed,
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 30, 15, 0),
                          decoration: BoxDecoration(
                              color: ColorResources.white,
                              boxShadow: [
                                BoxShadow(
                                  color: ColorResources.colorAAADC4,
                                  blurRadius: 5.0,
                                ),
                              ],
                              borderRadius: BorderRadius.all(Radius.circular(10))),
                          width: MediaQuery.sizeOf(context).width,
                          padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getTranslated("account_info", context)!,
                                style: TextStyle(
                                  fontSize: Dimensions.sp16,
                                  fontWeight: FontWeight.w600,
                                  color: ColorResources.color333333,
                                ),
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getTranslated("first_name", context)!,
                                      style: TextStyle(fontSize: Dimensions.sp14, color: ColorResources.color9a9a9a, fontWeight: FontWeight.w500, fontFamily: 'roboto'),
                                    ),
                                    TextField(
                                      controller: profileProvider.fNameController,
                                      focusNode: profileProvider.fNameFocus,
                                      textAlign: TextAlign.start,
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
                                        contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: ColorResources.mainColor, width: 1), // Focused underline color
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getTranslated("last_name", context)!,
                                      style: TextStyle(fontSize: Dimensions.sp14, color: ColorResources.color9a9a9a, fontWeight: FontWeight.w500, fontFamily: 'roboto'),
                                    ),
                                    TextField(
                                      controller: profileProvider.lNameController,
                                      focusNode: profileProvider.lNameFocus,
                                      textAlign: TextAlign.start,
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
                                        contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: ColorResources.mainColor, width: 1), // Focused underline color
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getTranslated("office_name", context)!,
                                      style: TextStyle(fontSize: Dimensions.sp14, color: ColorResources.color9a9a9a, fontWeight: FontWeight.w500, fontFamily: 'roboto'),
                                    ),
                                    TextField(
                                      controller: profileProvider.officeNameController,
                                      focusNode: profileProvider.officeNameFocus,
                                      enabled: false,
                                      textAlign: TextAlign.start,
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
                                        contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: ColorResources.mainColor, width: 1), // Focused underline color
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getTranslated("department_name", context)!,
                                      style: TextStyle(fontSize: Dimensions.sp14, color: ColorResources.color9a9a9a, fontWeight: FontWeight.w500, fontFamily: 'roboto'),
                                    ),
                                    TextField(
                                      controller: profileProvider.deptNameController,
                                      focusNode: profileProvider.deptNameFocus,
                                      enabled: false,
                                      textAlign: TextAlign.start,
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
                                        contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: ColorResources.mainColor, width: 1), // Focused underline color
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getTranslated("contact", context)!,
                                      style: TextStyle(fontSize: Dimensions.sp14, color: ColorResources.color9a9a9a, fontWeight: FontWeight.w500, fontFamily: 'roboto'),
                                    ),
                                    TextField(
                                      controller: profileProvider.contactController,
                                      focusNode: profileProvider.contactFocus,
                                      textAlign: TextAlign.start,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.done,
                                      style: const TextStyle(
                                        fontSize: Dimensions.sp14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Roboto',
                                      ),
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: ColorResources.mainColor, width: 1), // Focused underline color
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    getTranslated("make_my_data_private", context)!,
                                    style: TextStyle(fontSize: Dimensions.sp14, color: ColorResources.color9a9a9a, fontWeight: FontWeight.w500, fontFamily: 'roboto'),
                                  ),
                                  Container(
                                    width: 40,
                                    height: 10,
                                    alignment: Alignment.center,
                                    child: Transform.scale(
                                      scale: 0.8,
                                      child: Switch(
                                        value: profileProvider.userDataPrivateStatus,
                                        onChanged: (value) {
                                          profileProvider.updateUserDataPrivateStatus(value);
                                        },
                                        activeColor: Colors.white,
                                        activeTrackColor: ColorResources.mainColor,
                                        inactiveThumbColor: Colors.white,
                                        inactiveTrackColor: Colors.grey,
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        profileProvider.isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).primaryColor,
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () async {
                                  String fName = profileProvider.fNameController.text;
                                  String lName = profileProvider.lNameController.text;
                                  String contact = profileProvider.contactController.text;
                                  if (fName.isEmpty) {
                                    showCustomSnackBar(getTranslated('please_enter_first_name', context), context, isError: true);
                                  } else if (lName.isEmpty) {
                                    showCustomSnackBar(getTranslated('please_enter_last_name', context), context, isError: true);
                                  } else if (contact.isEmpty) {
                                    showCustomSnackBar(getTranslated('please_enter_contact', context), context, isError: true);
                                  } else {
                                    String personalData = "0";
                                    if(profileProvider.userDataPrivateStatus==true){
                                      personalData = "1";
                                    }
                                    else{
                                      personalData = "0";
                                    }
                                    String? base64Image = "";
                                    if(file!=null){
                                      base64Image = await Utility.imageToBase64(file!.path);
                                    }
                                    await profileProvider.updateUserInfo(
                                        profileProvider.userProfileData!.departmentId!.toString(),
                                        personalData,
                                        profileProvider.userProfileData!.officeId!.toString(),
                                        base64Image!,
                                        profileProvider.contactController.text.trim().toString(),
                                        profileProvider.userProfileData!.email!.toString(),
                                        profileProvider.lNameController.text.trim().toString(),
                                        profileProvider.fNameController.text.trim().toString());
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(40, 8, 40, 7),
                                  decoration: BoxDecoration(
                                    color: ColorResources.mainColor,
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                                  ),
                                  child: Text(
                                    getTranslated("save", context)!,
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
