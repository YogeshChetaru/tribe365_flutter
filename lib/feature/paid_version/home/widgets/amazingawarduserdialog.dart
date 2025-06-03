import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/home/controllers/home_controller.dart';
import 'package:tribe365_new/feature/paid_version/home/widgets/amazingyuseritem.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/dimensions.dart';


class AmazingAwardUserDialog extends StatefulWidget {
  const AmazingAwardUserDialog({super.key});

  @override
  State<AmazingAwardUserDialog> createState() => _AmazingAwardUserDialogState();
}

class _AmazingAwardUserDialogState extends State<AmazingAwardUserDialog> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(builder: (context, homeProvider, _) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                getTranslated("amazing2", context)!,
                style: TextStyle(
                  fontSize: Dimensions.sp16,
                  color: ColorResources.mainColor, // Replace with ColorResources.mainColor
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Tarun",
                style: TextStyle(
                  fontSize: Dimensions.sp14,
                  color: ColorResources.color333333, // Replace with ColorResources.mainColor
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, parentIndex) {
                  return AmazingUserItem();
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
