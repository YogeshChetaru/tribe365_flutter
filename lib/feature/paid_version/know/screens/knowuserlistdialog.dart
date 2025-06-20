import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/home/controllers/home_controller.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/dimensions.dart';
import 'package:tribe365_new/utill/images.dart';

import '../controllers/know_controller.dart';
import '../widgets/selectactionuseritem.dart';


class KnowUserListDialog extends StatefulWidget {
  final String wayFrom;
  const KnowUserListDialog({super.key,required this.wayFrom});

  @override
  State<KnowUserListDialog> createState() => _KnowUserListDialogState();
}

class _KnowUserListDialogState extends State<KnowUserListDialog> {
  @override
  Widget build(BuildContext context) {
    return Consumer<KnowController>(builder: (context, knowProvider, _) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  SizedBox(width:15),
                  SizedBox(width:20,height: 20,),
                  Expanded(
                    flex: 1,child: Container(
                    alignment: Alignment.center,
                      width: MediaQuery.sizeOf(context).width,
                      child: Text(
                        getTranslated("select_actions", context)!,
                        style: TextStyle(
                          fontSize: Dimensions.sp14,
                          color: ColorResources.black, // Replace with ColorResources.mainColor
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                  ),
                  InkWell(onTap: (){
                    Navigator.pop(context);
                  },child: Image.asset(Images.imgCrossGray,width: 20,height: 20,)),
                  SizedBox(width:15),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: knowProvider.users.length,
                itemBuilder: (context, index) {
                  return SelectActionUserItem(userData: knowProvider.users[index],wayFrom: widget.wayFrom,);
                },
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );
    });
  }
}
