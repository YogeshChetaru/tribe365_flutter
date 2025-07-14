import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/home/controllers/home_controller.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/dimensions.dart';
import '../../../../common/basewidget/custom_header_back_widget.dart';
import '../../../../localization/language_constrants.dart';
import '../controllers/profile_controller.dart';

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({super.key});

  @override
  ProfileSettingScreenState createState() => ProfileSettingScreenState();
}

class ProfileSettingScreenState extends State<ProfileSettingScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    setData();
    super.initState();
  }
  void setData() {
    HomeController homeController = Provider.of<HomeController>(context,listen: false);
    ProfileController profileController = Provider.of<ProfileController>(context,listen: false);
    profileController.updateIsPushNotification(homeController.getPushNotificationStatus(),false);
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
                CustomHeaderBack(title: getTranslated("settings", context)!,),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                            color: ColorResources.white,
                            boxShadow: [
                              BoxShadow(
                                color: ColorResources.colorAAADC4,
                                blurRadius: 5.0,
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          padding: EdgeInsets.fromLTRB(15, 13, 15, 13),
                          margin: EdgeInsets.fromLTRB(15, 20, 15,0),
                          child: Row(
                            children: [
                              Expanded(flex: 1,child: Container(
                                width: MediaQuery.sizeOf(context).width,
                                margin: EdgeInsets.fromLTRB(0, 0, 10,0),
                                child: Text(getTranslated("push_notification", context)!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.sp16,
                                  color: ColorResources.black,
                                  fontFamily: 'roboto'
                                ),),
                              )),
                              Container(
                                width: 40,
                                height: 10,
                                alignment: Alignment.center,
                                child: Transform.scale(
                                  scale: 0.8,
                                  child: Switch(
                                    value:profileProvider.isPushNotification,
                                    onChanged: (value) {
                                      profileProvider.updateIsPushNotification(value,true);
                                    },
                                    activeColor: Colors.white,
                                    activeTrackColor: ColorResources.mainColor,
                                    inactiveThumbColor: Colors.white,
                                    inactiveTrackColor: Colors.grey,
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                       /* Container(
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                            color: ColorResources.white,
                            boxShadow: [
                              BoxShadow(
                                color: ColorResources.colorAAADC4,
                                blurRadius: 5.0,
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          padding: EdgeInsets.fromLTRB(15, 13, 15, 13),
                          margin: EdgeInsets.fromLTRB(15, 20, 15,0),
                          child: Row(
                            children: [
                              Expanded(flex: 1,child: Container(
                                width: MediaQuery.sizeOf(context).width,
                                margin: EdgeInsets.fromLTRB(0, 0, 10,0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(getTranslated("auto_start", context)!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Dimensions.sp16,
                                          color: ColorResources.black,
                                          fontFamily: 'roboto'
                                      ),),
                                    Text(getTranslated("please_enable_auto_start_if_you_dont_automatically_receive_notification", context)!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: Dimensions.sp12,
                                          color: ColorResources.black,
                                          fontFamily: 'roboto'
                                      ),)
                                  ],
                                ),
                              )),
                              InkWell(onTap: () async {
                              },child: Image.asset(Images.imgSettingRed,width: 24,height: 24,))
                            ],
                          ),
                        )*/
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
