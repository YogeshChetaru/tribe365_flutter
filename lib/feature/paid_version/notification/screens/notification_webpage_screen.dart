import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/common/basewidget/custom_header_back_widget.dart';
import 'package:tribe365_new/feature/paid_version/notification/controllers/notification_controller.dart';

import '../../../../utill/color_resources.dart';

class NotificationWebpageScreen extends StatefulWidget {
  final String url;
  const NotificationWebpageScreen({super.key, required this.url});

  @override
  NotificationWebpageScreenState createState() => NotificationWebpageScreenState();
}

class NotificationWebpageScreenState extends State<NotificationWebpageScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  double _progress = 0;
  @override
  void initState() {

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
                  title: "",
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 1,
                  child: Stack(
                    children: [
                      InAppWebView(
                        initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse(widget.url))),
                        onWebViewCreated: (controller) {

                        },
                        onProgressChanged: (controller, progress) {
                          setState(() {
                            _progress = progress / 100;
                          });
                        },
                      ),
                      if (_progress < 1)
                        LinearProgressIndicator(value: _progress),
                    ],
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