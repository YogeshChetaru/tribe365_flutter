import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/home/screens/amazing_award_your_list_screen.dart';
import 'package:tribe365_new/feature/paid_version/profile/controllers/profile_controller.dart';
import 'package:tribe365_new/main.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/custom_route.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../free_version/free_dashboard/widgets/showsentimentdialog.dart';
import '../../../free_version/hptm/screens/hptm_screen.dart';
import '../../notification/screens/notification_screen.dart';
import '../controllers/home_controller.dart';
import '../widgets/amazingawardsetdialog.dart';
import '../widgets/amazingawarduserdialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  ProfileController profileController = Provider.of<ProfileController>(Get.context!,listen: false);
  HomeController homeController = Provider.of<HomeController>(Get.context!,listen: false);

  void apiLoad() {
    profileController.viewUserProfile().then((onValue){
      homeController.getHomeData(profileController.userProfileData!.orgId.toString());
    });
  }
  @override
  void initState() {
    super.initState();
    apiLoad();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Consumer<HomeController>(builder: (context, homeProvider, _) {
          return Consumer<ProfileController>(builder: (context, profileProvider, _) {
            return Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              color: ColorResources.screenBg,
              child: Stack(
                children: [
                  Column(
                    children: [
                      profileProvider.userProfileData==null?
                      SizedBox.fromSize():
                      Container(
                        decoration: BoxDecoration(
                          color: ColorResources.white,
                          boxShadow: [
                            BoxShadow(
                              color: ColorResources.colorAAADC4,
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        width: MediaQuery.sizeOf(context).width,
                        padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
                        child: Row(
                          children: [
                            Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: ColorResources.mainColor, width: 1),
                                image: DecorationImage(
                                  image: profileProvider.userProfileData!.organisationLogo == null
                                      ? AssetImage(Images.imgTribe365) as ImageProvider
                                      : NetworkImage(profileProvider.userProfileData!.organisationLogo!) as ImageProvider,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                                width: MediaQuery.sizeOf(context).width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.fromLTRB(10, 6, 10, 6),
                                      decoration: BoxDecoration(
                                        color: ColorResources.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: ColorResources.colorAAADC4,
                                            blurRadius: 3.0,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5), topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            homeProvider.imagePath,
                                            width: 20,
                                            height: 20,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          TweenAnimationBuilder<double>(
                                            tween: Tween(begin: 150, end: homeProvider.animatedValue),
                                            duration: Duration(seconds: 5),
                                            builder: (context, value, child) {
                                              return Text(
                                                homeProvider.showEngValue, // You can also animate this number if you want
                                                style:TextStyle(fontSize: Dimensions.sp16, color: homeProvider.textColor, fontWeight: FontWeight.w500, fontFamily: 'roboto'),
                                              );
                                            },
                                          ),

                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    InkWell(
                                      onTap: (){
                                        routePush(context, NotificationScreen());
                                      },child: Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      width: 40,
                                      height: 36,
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        alignment: Alignment.center,
                                        children: [
                                          Positioned(
                                            top: 10,
                                            left: -10,
                                            child: Image.asset(
                                              Images.imgBellRed,
                                              width: 24,
                                              height: 24,
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            left: 3,
                                            child: Container(
                                              width: 20,
                                              height: 20,
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(2),
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.transparent, // background like bg_circle_hollow_red
                                                border: Border.fromBorderSide(
                                                  BorderSide(color: ColorResources.color17ba0a, width: 1.5),
                                                ),
                                              ),
                                              child: Text(
                                                '3', // Replace with dynamic count
                                                style: TextStyle(
                                                  color: ColorResources.mainColor,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Roboto',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                height: 80,
                                margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                                decoration: BoxDecoration(
                                  color: ColorResources.mainColor,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 20,
                                      child: InkWell(
                                        onTap: () {
                                          showDialog(context, AmazingAwardSetDialog());
                                        },
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                Images.imgAwardsKudosWhite,
                                                width: 30,
                                                height: 40,
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                getTranslated("amazing", context)!,
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontFamily: 'roboto',
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                  letterSpacing: 1.2,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: -30,
                                      top: 15,
                                      bottom: -10,
                                      child: InkWell(
                                        onTap: (){
                                          routePush(context, AmazingAwardYourListScreen());
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            '0',
                                            style: TextStyle(
                                              color: ColorResources.mainColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getTranslated("sentiment_index", context)!,
                                      style: TextStyle(
                                        fontSize: Dimensions.sp16,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'roboto',
                                        color: ColorResources.black,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 4,
                                            color: Colors.black12,
                                            offset: Offset(0, 2),
                                          )
                                        ],
                                      ),
                                      child: SizedBox(
                                        height: 100,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: homeProvider.weekData.length,
                                          itemBuilder: (context, index) {
                                            final day = homeProvider.weekData[index];
                                            final isWeekend = day.day == 'Sun' || day.day == 'Sat';
                                            return InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context,
                                                    ShowSentimentDialog(
                                                      mood: "sad",
                                                    ));
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      day.day,
                                                      style: TextStyle(
                                                        fontFamily: 'roboto',
                                                        fontSize: Dimensions.sp14,
                                                        fontWeight: FontWeight.w600,
                                                        color: isWeekend ? ColorResources.mainColor : ColorResources.black,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 6),
                                                    Text(
                                                      day.date,
                                                      style: TextStyle(
                                                        fontFamily: 'roboto',
                                                        fontSize: Dimensions.sp14,
                                                        fontWeight: FontWeight.w600,
                                                        color: day.day == 'Sun' ? ColorResources.mainColor : ColorResources.black,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 6),
                                                    day.mood != null
                                                        ? Icon(day.mood, color: Colors.red)
                                                        : day.date.isNotEmpty
                                                        ? Text("-", style: TextStyle(fontSize: 20))
                                                        : SizedBox.shrink(),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getTranslated("amazing_awards", context)!,
                                      style: TextStyle(
                                        fontSize: Dimensions.sp16,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'roboto',
                                        color: ColorResources.black,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showDialog(context, AmazingAwardUserDialog());
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4,
                                              color: Colors.black12,
                                              offset: Offset(0, 2),
                                            )
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Tarun",
                                              style: TextStyle(
                                                fontFamily: 'roboto',
                                                fontSize: Dimensions.sp14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              "Amazing",
                                              style: TextStyle(
                                                fontFamily: 'roboto',
                                                fontSize: Dimensions.sp14,
                                                fontWeight: FontWeight.w600,
                                                color: ColorResources.mainColor,
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  Images.imgGroupCircleRed,
                                                  width: 20,
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "Demo Lead & 3 more",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontFamily: 'roboto',
                                                    fontSize: Dimensions.sp14,
                                                    fontWeight: FontWeight.w400,
                                                    color: ColorResources.color333333,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: MediaQuery.sizeOf(context).width,
                                              child: Text(
                                                "29 apr 2025, 03:09 pm",
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontFamily: 'roboto',
                                                  fontSize: Dimensions.sp12,
                                                  fontWeight: FontWeight.w400,
                                                  color: ColorResources.color9a9a9a,
                                                ),
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
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        routePush(context, HPTMScreen());
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                        width: 20,
                        decoration: BoxDecoration(
                          color: ColorResources.mainColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          ),
                        ),
                        child: Text(
                          getTranslated("hptm", context)!,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'roboto',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        }),
      ),
    );
  }



  void showDialog(BuildContext context, Widget workNotDialog) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        barrierColor: Colors.black54,
        pageBuilder: (context, animation, secondaryAnimation) {
          return Center(child: workNotDialog);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // From right
          const end = Offset(-1.0, 0.0); // To left when popping
          final tween = Tween(begin: begin, end: Offset.zero);
          final reverseTween = Tween(begin: Offset.zero, end: end);
          final offsetAnimation = animation.drive(tween);
          final reverseOffset = secondaryAnimation.drive(reverseTween);

          return SlideTransition(
            position: animation.status == AnimationStatus.reverse ? reverseOffset : offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }
}
