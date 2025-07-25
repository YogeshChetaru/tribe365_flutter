import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/custom_route.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../controllers/home_controller.dart';
import 'home_play_screen.dart';

class LinkClickDialogContent extends StatelessWidget {
  final String titleName;
  final String subTitleName;
  final String description;
  final String videoURL;

  const LinkClickDialogContent({
    super.key,
    required this.titleName,
    required this.subTitleName,
    required this.description,
    required this.videoURL,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(15),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15,0),
              child: Row(
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                  ),
                  Expanded(
                    child: Text(
                      titleName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: ColorResources.mainColor,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      color: ColorResources.mainColor,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            if (subTitleName.isNotEmpty)
              Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 15,0),
                child: Text(
                  subTitleName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.grey, fontFamily: "Roboto", fontWeight: FontWeight.w500),
                ),
              ),
            Container(
              margin: EdgeInsets.only(top: 5),
              width: MediaQuery.sizeOf(context).width,
              height: 1,
              color: ColorResources.black.withAlpha(125),

            ),
            if (description.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  description,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: ColorResources.black, fontFamily: "Roboto"),
                ),
              ),
            if (videoURL.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    routePush(
                        context,
                        PlayScreen(
                          title: titleName,
                          subTitle: subTitleName,
                          description: description,
                          videoURL: videoURL,
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorResources.mainColor,
                    minimumSize: const Size(140, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    getTranslated("watch_video", context)!,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
