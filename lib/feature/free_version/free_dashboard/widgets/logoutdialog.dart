import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/login/controllers/login_controller.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/dimensions.dart';

class LogoutDialog extends StatefulWidget {
  const LogoutDialog({super.key});

  @override
  State<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginController>(builder: (context, loginProvider, _) {
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
                getTranslated("logout", context)!,
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
                getTranslated("are_you_sure_you_want_to_logout", context)!,
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
                   loginProvider.isLoading
                       ? Center(
                     child: SizedBox(
                       height: 20,
                       width: 20,
                       child: CircularProgressIndicator(
                         strokeWidth: 2,
                         valueColor: AlwaysStoppedAnimation<Color>(
                           Theme.of(context).primaryColor,
                         ),
                       ),
                     ),
                   )
                       :  InkWell(
                     onTap: (){
                       loginProvider.logout();
                     },child: Text(
                       textAlign: TextAlign.end,
                       getTranslated("logout", context)!,
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
