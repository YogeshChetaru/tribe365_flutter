import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../utill/color_resources.dart';
import '../../../../utill/images.dart';
import '../../../paid_version/profile/controllers/profile_controller.dart';
import '../controllers/hptm_controller.dart';

class PdfViewerPage extends StatelessWidget {
  final String url;

  const PdfViewerPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Consumer<HPTMController>(builder: (context, hptmProvider, _) {
          return Consumer<ProfileController>(builder: (context, profileProvider, _) {
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
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: ColorResources.mainColor, width: 1),
                            image: DecorationImage(
                              image: profileProvider.userProfileData!.organisationLogo == null
                                  ? AssetImage(Images.imgTribe365) as ImageProvider
                                  : NetworkImage(profileProvider.userProfileData!.organisationLogo!) as ImageProvider,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SfPdfViewer.network(url),
                  ),
                ],
              ),
            );
          });
        }),
      ),
    );
  }
}
