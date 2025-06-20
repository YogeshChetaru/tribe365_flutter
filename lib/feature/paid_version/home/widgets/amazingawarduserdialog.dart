import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/home/controllers/home_controller.dart';
import 'package:tribe365_new/feature/paid_version/home/widgets/amazingyuseritem.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/dimensions.dart';

import '../../know/domain/models/view_know_organisation_response.dart';


class AmazingAwardUserDialog extends StatefulWidget {
  final LatestKudosAward data;
  const AmazingAwardUserDialog({super.key,required this.data});

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
                widget.data.awardValue!,
                style: TextStyle(
                  fontSize: Dimensions.sp16,
                  color: ColorResources.mainColor,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                widget.data.userName!,
                style: TextStyle(
                  fontSize: Dimensions.sp14,
                  color: ColorResources.color333333,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.data.viewMoreUsers!.length,
                itemBuilder: (context, parentIndex) {
                  return AmazingUserItem(data: widget.data.viewMoreUsers![parentIndex],);
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
