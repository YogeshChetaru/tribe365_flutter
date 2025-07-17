import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/common/basewidget/custom_header_back_widget.dart';
import 'package:tribe365_new/feature/paid_version/notification/controllers/notification_controller.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import '../../../../utill/color_resources.dart';
import '../widgets/award_description_list.dart';

class NotificationKudosAwardsDetailsScreen extends StatefulWidget {
  final String kudosId;
  final String kudosName;

  const NotificationKudosAwardsDetailsScreen({super.key, required this.kudosId, required this.kudosName});

  @override
  NotificationKudosAwardsDetailsScreenState createState() => NotificationKudosAwardsDetailsScreenState();
}

class NotificationKudosAwardsDetailsScreenState extends State<NotificationKudosAwardsDetailsScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    loadAPI();
    super.initState();
  }

  void loadAPI() {
    NotificationController controller = Provider.of<NotificationController>(context, listen: false);
    controller.viewKudoAwardDetailAPI(widget.kudosId, "1");
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
                notificationProvider.notificationKudosAwardList == null
                    ? Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Text(
                            getTranslated("no_data_found", context)!,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black,
                              letterSpacing: 0,
                            ),
                          ),
                        ),
                      )
                    : Container(margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      width: MediaQuery.sizeOf(context).width,
                      padding: EdgeInsets.fromLTRB(15, 13, 15, 15),
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
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8), // layout_marginStart/End
                            child: Text(
                              widget.kudosName,
                              style: const TextStyle(
                                fontSize: 16, // text_size_medium
                                color: Colors.black,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w600
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          AdAwardDescriptionList(),
                        ],
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
