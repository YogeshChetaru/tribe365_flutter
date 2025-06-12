import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/free_version/hptm/widgets/pdf_viewer_page.dart';
import 'package:tribe365_new/feature/free_version/hptm/widgets/video_webview_page.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/custom_route.dart';
import 'package:tribe365_new/utill/images.dart';

import '../controllers/hptm_controller.dart';
import '../domain/models/subchecklistitem.dart';

class HptmPrinciplesMainSubItem extends StatelessWidget {
  final String title;
  final int i;
  final List<SubChecklistItem> subItems;

  const HptmPrinciplesMainSubItem({super.key, required this.title, required this.i, required this.subItems});

  @override
  Widget build(BuildContext context) {
    return Consumer<HPTMController>(builder: (context, hptmProvider, _) {
      return Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    if (hptmProvider.subClickStatus[title]?[i] == true) {
                      hptmProvider.toggleSub(title, i, false);
                      hptmProvider.updateHPTMLearningCheckListStatus(subItems[i].checklistId.toString(), false);
                    } else {
                      hptmProvider.toggleSub(title, i, true);
                      hptmProvider.updateHPTMLearningCheckListStatus(subItems[i].checklistId.toString(), true);
                    }
                  },
                  child: Image.asset(
                    hptmProvider.subClickStatus[title]?[i] == true ? Images.imgCircleCheckedRed : Images.imgCircleUnchecked,
                    width: 24,
                    height: 24,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        textAlign: TextAlign.start,
                        subItems[i].checklistTitle,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'roboto', color: ColorResources.color333333),
                      ),
                      Text(
                        subItems[i].description,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'roboto', color: ColorResources.color333333),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: (){
                          if (subItems[i].link != "") {
                            routePush(context, YoutubePlayerPage(videoUrl: subItems[i].link));
                          } else if (subItems[i].document != "") {
                            routePush(context, PdfViewerPage(url: subItems[i].document));
                          }
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              subItems[i].link==""?Images.imgDocumentRed:Images.imgWatchVideoRed,
                              width: 18,
                              height: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    textAlign: TextAlign.start,
                                    subItems[i].link==""?getTranslated("view_attachment", context)!: getTranslated("watch_the_video", context)!,
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'roboto', color: ColorResources.mainColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            if (i != subItems.length - 1)
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: 0.5,
                color: ColorResources.color9a9a9a,
              )
          ],
        ),
      );
    });
  }
}
