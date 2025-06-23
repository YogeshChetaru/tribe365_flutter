import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/common/basewidget/custom_header_back_widget.dart';
import 'package:tribe365_new/feature/paid_version/notification/controllers/notification_controller.dart';
import 'package:tribe365_new/feature/paid_version/notification/widgets/notificationitem.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../main.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../profile/controllers/profile_controller.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  ProfileController profileController = Provider.of<ProfileController>(Get.context!, listen: false);

  @override
  void initState() {
    loadAPI();
    super.initState();
  }

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
                CustomHeaderBack(
                  title: getTranslated("notifications", context)!,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            notificationProvider.viewUnReadNotificationList(profileController.userProfileData!.id.toString(), 1);
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
                            notificationProvider.viewNotificationList(profileController.userProfileData!.id.toString(), 1);
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
                Expanded(
                  flex: 1,
                  child: notificationProvider.isNotificationType == true
                      ? notificationProvider.listUnread.isEmpty
                          ? SizedBox.shrink()
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: notificationProvider.listUnread.length,
                              itemBuilder: (context, index) {
                                return NotificationItem(
                                  item: notificationProvider.listUnread[index],
                                );
                              },
                            )
                      : notificationProvider.archivedList==null?SizedBox():  ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: notificationProvider.archivedList!.length,
                          itemBuilder: (context, index) {
                            return NotificationItem(item: notificationProvider.archivedList![index],);
                          },
                        ),
                )
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: Consumer<NotificationController>(builder: (context, notificationProvider, _) {
        return notificationProvider.isNotificationType == true
            ? notificationProvider.archiveStatus == true
                ? InkWell(
                    onTap: () {
                      notificationProvider.readAllNotification(profileController.userProfileData!.id.toString());
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      decoration: BoxDecoration(
                        color: ColorResources.mainColor,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                      ),
                      child: Text(
                        getTranslated("archive_all", context)!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: Dimensions.sp16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                  )
                : SizedBox()
            : SizedBox();
      }),
    );
  }

  void loadAPI() {
    NotificationController controller = Provider.of<NotificationController>(context, listen: false);
    controller.viewUnReadNotificationList(profileController.userProfileData!.id.toString(), 1);
    controller.viewNotificationList(profileController.userProfileData!.id.toString(), 1);
  }
}
