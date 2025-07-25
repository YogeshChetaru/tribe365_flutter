import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/localization/language_constrants.dart';

import '../../../../main.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../controllers/home_controller.dart';
import '../widgets/belief_horizontal_list.dart';
import '../widgets/open_link_dialog.dart';

class DotDetailsScreen extends StatefulWidget {
  const DotDetailsScreen({super.key});

  @override
  DotDetailsScreenState createState() => DotDetailsScreenState();
}

class DotDetailsScreenState extends State<DotDetailsScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    apiLoad();
    super.initState();
  }

  void apiLoad() {
    HomeController homeController = Provider.of<HomeController>(Get.context!, listen: false);
    homeController.getDotDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Consumer<HomeController>(builder: (context, homeProvider, _) {
          return Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            color: ColorResources.screenBg,
            child: Column(
              children: [
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
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            Images.imgCircleBackRed,
                            width: 24,
                            height: 24,
                          )),
                      Expanded(
                          child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "",
                          style: TextStyle(
                            fontSize: Dimensions.sp18,
                            fontWeight: FontWeight.w600,
                            color: ColorResources.black,
                          ),
                        ),
                      )),
                      SizedBox(
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: homeProvider.isPopupLoading
                        ? SizedBox(
                            height: MediaQuery.sizeOf(context).height / 1.5,
                            width: MediaQuery.sizeOf(context).width,
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  openLinkDialog(
                                    context,
                                    title: getTranslated("vision", context)!,
                                    subTitle: homeProvider.dotDetailsData!.vision!,
                                    description: homeProvider.dotDetailsData!.visionDesc!,
                                    videoURL: homeProvider.dotDetailsData!.visionUrl!,
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getTranslated("vision", context)!,
                                      style: const TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                                      margin: const EdgeInsets.only(top: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.grey.shade300),
                                      ),
                                      child: Text(
                                        homeProvider.dotDetailsData!.vision!,
                                        style: const TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black87),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: () {
                                  openLinkDialog(
                                    context,
                                    title: getTranslated("mission", context)!,
                                    subTitle: homeProvider.dotDetailsData!.mission!,
                                    description: homeProvider.dotDetailsData!.missionDesc!,
                                    videoURL: homeProvider.dotDetailsData!.missionUrl!,
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getTranslated("mission", context)!,
                                      style: const TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                                      margin: const EdgeInsets.only(top: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.grey.shade300),
                                      ),
                                      child: Text(
                                        homeProvider.dotDetailsData!.mission!,
                                        style: const TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black87),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: () {
                                  openLinkDialog(
                                    context,
                                    title: getTranslated("focus", context)!,
                                    subTitle: homeProvider.dotDetailsData!.focus!,
                                    description: homeProvider.dotDetailsData!.focusDesc!,
                                    videoURL: homeProvider.dotDetailsData!.focusUrl!,
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getTranslated("focus", context)!,
                                      style: const TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                                      margin: const EdgeInsets.only(top: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.grey.shade300),
                                      ),
                                      child: Text(
                                        homeProvider.dotDetailsData!.focus!,
                                        style: const TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black87),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(getTranslated("belief", context)!,
                                  style: const TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500)),
                              homeProvider.beliefList == null
                                  ? Text(
                                      getTranslated("belief_and_values_are_not_available", context)!,
                                      style: TextStyle(fontFamily: 'Roboto', fontSize: 14),
                                    )
                                  : homeProvider.beliefList!.isEmpty
                                      ? Text(
                                          getTranslated("belief_and_values_are_not_available", context)!,
                                          style: TextStyle(fontFamily: 'Roboto', fontSize: 14),
                                        )
                                      : Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 10),
                                            BeliefHorizontalList(
                                              beliefs: homeProvider.beliefList!,
                                              controller: homeProvider,
                                            ),
                                          ],
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
