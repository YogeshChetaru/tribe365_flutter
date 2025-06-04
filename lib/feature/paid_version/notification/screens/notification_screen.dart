import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/common/basewidget/custom_header_back_widget.dart';
import 'package:tribe365_new/feature/paid_version/notification/controllers/notification_controller.dart';
import 'package:tribe365_new/feature/paid_version/notification/widgets/notificationitem.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Consumer<NotificationController>(builder: (context, notificationProvider, _) {
          return Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            color: ColorResources.screenBg,
            child: Column(
              children: [
               CustomHeaderBack(title: getTranslated("notifications", context)!,),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            notificationProvider.updateIsNotificationType("notification");
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.fromLTRB(0, 13, 0, 15),
                            width: MediaQuery.sizeOf(context).width,
                            decoration: BoxDecoration(
                              color: notificationProvider.isNotificationType == true ? ColorResources.mainColor : ColorResources.white,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorResources.colorAAADC4,
                                  blurRadius: 3.0,
                                ),
                              ],
                            ),
                            child: Text(
                              getTranslated("notifications", context)!,
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: Dimensions.sp14,
                                  fontWeight: FontWeight.w600,
                                  color: notificationProvider.isNotificationType == true ? ColorResources.white : ColorResources.black),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            notificationProvider.updateIsNotificationType("archived");
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.fromLTRB(0, 13, 0, 15),
                            width: MediaQuery.sizeOf(context).width,
                            decoration: BoxDecoration(
                              color: notificationProvider.isNotificationType != true ? ColorResources.mainColor : ColorResources.white,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorResources.colorAAADC4,
                                  blurRadius: 3.0,
                                ),
                              ],
                            ),
                            child: Text(
                              getTranslated("archived", context)!,
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: Dimensions.sp14,
                                  fontWeight: FontWeight.w600,
                                  color: notificationProvider.isNotificationType != true ? ColorResources.white : ColorResources.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(flex: 1,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount:5,
                    itemBuilder: (context, parentIndex) {
                      return NotificationItem();
                    },
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
