import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/common/basewidget/custom_header_back_widget.dart';
import 'package:tribe365_new/feature/paid_version/notification/controllers/notification_controller.dart';
import 'package:tribe365_new/feature/paid_version/notification/widgets/notification_kudos_award_item.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import '../../../../utill/color_resources.dart';

class NotificationAwardsScreen extends StatefulWidget {
  const NotificationAwardsScreen({super.key});

  @override
  NotificationAwardsScreenState createState() => NotificationAwardsScreenState();
}

class NotificationAwardsScreenState extends State<NotificationAwardsScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    loadAPI();
    super.initState();
  }

  void loadAPI() {
    NotificationController controller = Provider.of<NotificationController>(context, listen: false);
    controller.viewKudosAwardDetailAPI();
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
                  title: getTranslated("awards", context)!,
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(flex: 1,
                  child: notificationProvider.viewKudosAwardDetailList==null?SizedBox.shrink(): ListView.builder(
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount:notificationProvider.viewKudosAwardDetailList!.length,
                    itemBuilder: (context, index) {
                      final item = notificationProvider.viewKudosAwardDetailList![index];
                      return NotificationKudosAwardItem(
                        award: item,
                      );
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
