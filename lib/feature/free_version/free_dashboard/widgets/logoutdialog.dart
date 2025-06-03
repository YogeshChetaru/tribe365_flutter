import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/login/screens/login_screen.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/dimensions.dart';
import '../controllers/free_dashboard_controller.dart';

class LogoutDialog extends StatefulWidget {
  const LogoutDialog({super.key});

  @override
  State<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {

  @override
  Widget build(BuildContext context) {
    return Consumer<FreeDashboardController>(builder: (context, dashboardProvider, _) {
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
                   InkWell(
                     onTap: (){
                       Navigator.of(context).pushAndRemoveUntil(
                         PageRouteBuilder(
                           transitionDuration: const Duration(milliseconds: 500),
                           reverseTransitionDuration: const Duration(milliseconds: 500),
                           pageBuilder: (context, animation, secondaryAnimation) =>
                           const LoginScreen(),
                           transitionsBuilder: (context, animation, secondaryAnimation, child) {
                             const begin = Offset(1.0, 0.0); // Slide in from right
                             const end = Offset.zero;
                             const curve = Curves.easeInOut;

                             final tween =
                             Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                             final offsetAnimation = animation.drive(tween);

                             return SlideTransition(
                               position: offsetAnimation,
                               child: child,
                             );
                           },
                         ),
                             (route) => false,
                       );
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
