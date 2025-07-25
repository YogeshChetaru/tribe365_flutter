import 'package:flutter/material.dart';

import '../screens/link_click_screen.dart';

void openLinkDialog(BuildContext context, {
  required String title,
  required String subTitle,
  required String description,
  required String videoURL,
}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        insetPadding: EdgeInsets.all(16),
        backgroundColor: Colors.transparent,
        child: LinkClickDialogContent(
          titleName: title,
          subTitleName: subTitle,
          description: description,
          videoURL: videoURL,
        ),
      );
    },
  );
}
