import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/home/controllers/home_controller.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/dimensions.dart';

import '../../../../common/basewidget/show_custom_snakbar_widget.dart';
import 'amazingawardset2dialog.dart';


class AmazingAwardSetDialog extends StatefulWidget {
  final String name;
  const AmazingAwardSetDialog({super.key,required this.name});

  @override
  State<AmazingAwardSetDialog> createState() => _AmazingAwardSetDialogState();
}

class _AmazingAwardSetDialogState extends State<AmazingAwardSetDialog> {
  final TextEditingController textController = TextEditingController();
  final FocusNode textFocus = FocusNode();

  @override
  void dispose() {
    textController.dispose();
    textFocus.dispose();
    super.dispose();
  }
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
                "${widget.name} ${getTranslated("awards", context)!}",
                style: TextStyle(
                  fontSize: Dimensions.sp16,
                  color: ColorResources.mainColor,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(15, 0, 15, 20),
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  border: Border.all(color: ColorResources.color9a9a9a, width: 0.5),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                ),
                padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
                child: TextField(
                  maxLines: 5,
                  textAlign: TextAlign.start,
                  controller: textController,
                  focusNode: textFocus,
                  keyboardType: TextInputType.multiline,
                  textInputAction:TextInputAction.done,
                  style: const TextStyle(
                    fontSize: Dimensions.sp14,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto',
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    hintStyle: const TextStyle(
                      color: ColorResources.color9a9a9a,
                      fontSize: Dimensions.sp14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  String msg = textController.text.toString().trim();
                  if(msg.isEmpty){
                    showCustomSnackBar(getTranslated('please_enter_comment_first', context), context,isError: true);
                  }
                  else{
                    Navigator.of(context).pop();
                    showDialog(context, AmazingAwardSet2Dialog(name:widget.name,msg: msg,));
                  }

                },child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    color: ColorResources.mainColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        bottomLeft: Radius.circular(10),
                        topRight: Radius.circular(0),
                        bottomRight: Radius.circular(10)),
                  ),
                  padding: EdgeInsets.fromLTRB(0, 13, 0, 13),
                  child: Text(getTranslated("next", context)!,style: TextStyle(
                    color: ColorResources.white,
                    fontFamily: 'roboto',
                    fontWeight: FontWeight.w600,
                    fontSize: Dimensions.sp16
                  ),),
                ),
              ),

            ],
          ),
        ),
      );
    });
  }
  void showDialog(BuildContext context, Widget workNotDialog) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        barrierColor: Colors.black54,
        pageBuilder: (context, animation, secondaryAnimation) {
          return Center(child: workNotDialog);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // From right
          const end = Offset(-1.0, 0.0); // To left when popping
          final tween = Tween(begin: begin, end: Offset.zero);
          final reverseTween = Tween(begin: Offset.zero, end: end);
          final offsetAnimation = animation.drive(tween);
          final reverseOffset = secondaryAnimation.drive(reverseTween);

          return SlideTransition(
            position: animation.status == AnimationStatus.reverse ? reverseOffset : offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }
}
