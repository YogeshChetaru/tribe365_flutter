import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/dimensions.dart';
import '../../../../common/basewidget/custom_header_back_widget.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/images.dart';
import '../controllers/profile_controller.dart';

class ProfileEditProfileScreen extends StatefulWidget {
  const ProfileEditProfileScreen({super.key});

  @override
  ProfileEditProfileScreenState createState() => ProfileEditProfileScreenState();
}

class ProfileEditProfileScreenState extends State<ProfileEditProfileScreen> {
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
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: ColorResources.mainColor, width: 1),
                                image: DecorationImage(
                                  image: AssetImage(Images.imgUserCircleGray),
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
                                        value:profileProvider.isPushNotification,
                                        onChanged: (value) {
                                          profileProvider.updateIsPushNotification(value);
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
                        InkWell(
                          onTap: (){

                          },child: Container(
                          padding: EdgeInsets.fromLTRB(40, 8, 40, 7),
                          decoration: BoxDecoration(
                            color: ColorResources.mainColor,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                          ),
                          child: Text(getTranslated("save", context)!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: Dimensions.sp16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Roboto',
                            ),),
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
