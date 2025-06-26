import 'package:flutter/material.dart';
import 'package:tribe365_new/feature/paid_version/home/screens/dot_details_screen.dart';
import 'package:tribe365_new/feature/paid_version/home/screens/link_click_screen.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/custom_route.dart';

class HomeVisionCardView extends StatelessWidget {
  final String visionText;
  final String subTitleName;
  final String description;
  final String videoURL;

  const HomeVisionCardView({
    super.key,
    required this.visionText,
    required this.subTitleName,
    required this.description,
    required this.videoURL
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                visionText,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      routePush(context, LinkClickScreen(
                        description: description,
                        subTitleName: subTitleName,
                        titleName: visionText,
                        videoURL: videoURL,

                      ));
                    },
                    child: Card(
                      elevation: 5,
                      margin: const EdgeInsets.all(6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        child: Text(
                          getTranslated("Vision", context)!,
                          // Replace with localized string
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  InkWell(
                    onTap: (){
                      routePush(context, DotDetailsScreen());
                    },child: Card(
                      elevation: 5,
                      margin: const EdgeInsets.all(6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        child: Text(
                          getTranslated("vision_map", context)!,
                          // Replace with localized string
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
