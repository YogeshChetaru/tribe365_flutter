import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/custom_route.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../controllers/home_controller.dart';
import 'home_play_screen.dart';

class LinkClickScreen extends StatefulWidget {
  final String titleName;
  final String subTitleName;
  final String description;
  final String videoURL;
  const LinkClickScreen({super.key,
  required this.titleName,
    required this.subTitleName,
    required this.description,
    required this.videoURL,});

  @override
  LinkClickScreenState createState() => LinkClickScreenState();
}

class LinkClickScreenState extends State<LinkClickScreen> {

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    if (widget.description.isEmpty && widget.videoURL.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        routePush(context, PlayScreen(
          title: widget.titleName,
          subTitle: widget.subTitleName,
          description: widget.description,
          videoURL: widget.videoURL,
        ));
      });
    }
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
                      Expanded(child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "",
                          style: TextStyle(
                            fontSize: Dimensions.sp18,
                            fontWeight:FontWeight.w600,
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
                    child: Column(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              const Expanded(child: SizedBox()),

                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                  elevation: 0,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        // Header
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                const SizedBox(
                                                  width: 30,
                                                  height: 24,
                                                  child: Visibility(
                                                    visible: false,
                                                    child: Icon(Icons.arrow_back),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    widget.titleName.toUpperCase(),
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 30,
                                                  height: 15,
                                                  child: Visibility(
                                                    visible: false,
                                                    child: Icon(Icons.close),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            if (widget.subTitleName.isNotEmpty)
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                child: Text(
                                                  widget.subTitleName,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),

                                        const Divider(),

                                        // Description and Button
                                        SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              if (widget.description.isNotEmpty)
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    widget.description,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              if (widget.videoURL.isNotEmpty)
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      routePush(context, PlayScreen(
                                                        title: widget.titleName,
                                                        subTitle: widget.subTitleName,
                                                        description: widget.description,
                                                        videoURL: widget.videoURL,
                                                      ));
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: Colors.red,
                                                      minimumSize: const Size(140, 40),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(20),
                                                      ),
                                                    ),
                                                    child:  Text(
                                                      getTranslated("watch_video", context)!,
                                                      style: TextStyle(color: Colors.white),
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
                              ),

                              const Expanded(child: SizedBox()),
                            ],
                          ),
                        )
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
