import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/profile/controllers/profile_controller.dart';
import 'package:tribe365_new/feature/paid_version/profile/domain/models/view_action_list_response.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/dimensions.dart';

class ActionDeleteDialog extends StatefulWidget {
  final ViewActionListData data;
   const ActionDeleteDialog({super.key,required this.data});

  @override
  State<ActionDeleteDialog> createState() => _ActionDeleteDialogState();
}

class _ActionDeleteDialogState extends State<ActionDeleteDialog> {

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileController>(builder: (context, profileProvider, _) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textAlign: TextAlign.start,
                getTranslated("delete_action", context)!,
                style: TextStyle(
                  fontSize: Dimensions.sp18,
                  color: ColorResources.black, // Replace with ColorResources.mainColor
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 0.5,
                color: ColorResources.color9a9a9a,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                textAlign: TextAlign.start,
                getTranslated("are_you_sure_you_want_to_delete_this_action", context)!,
                style: TextStyle(
                  fontSize: Dimensions.sp14,
                  color: ColorResources.color9a9a9a, // Replace with ColorResources.mainColor
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerRight,
                width: MediaQuery.of(context).size.width,
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   InkWell(
                     onTap: (){
                       Navigator.pop(context);
                     },child: Text(
                       textAlign: TextAlign.end,
                       getTranslated("cancel", context)!,
                       style: TextStyle(
                         fontSize: Dimensions.sp14,
                         color: ColorResources.black, // Replace with ColorResources.mainColor
                         fontWeight: FontWeight.w600,
                         fontFamily: 'Roboto',
                       ),
                     ),
                   ),
                   SizedBox(width: 20,),
                   InkWell(
                     onTap: (){
                       Navigator.pop(context);
                       profileProvider.deleteActionItemStatus(widget.data.id!);
                     },child: Text(
                       textAlign: TextAlign.end,
                       getTranslated("ok", context)!,
                       style: TextStyle(
                         fontSize: Dimensions.sp14,
                         color: ColorResources.mainColor, // Replace with ColorResources.mainColor
                         fontWeight: FontWeight.w600,
                         fontFamily: 'Roboto',
                       ),
                     ),
                   ),
                   SizedBox(width: 10,),
                 ],
               ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
