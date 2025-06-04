import 'package:flutter/material.dart';
import 'package:tribe365_new/feature/paid_version/offloading/screens/offloading_chat_details_screen.dart';
import 'package:tribe365_new/utill/color_resources.dart';

import '../../../../utill/dimensions.dart';

class RecentReflectionItem extends StatelessWidget {

  const RecentReflectionItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        route(context, OffLoadingChatDetailsScreen());
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: Colors.black12,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Test",
              style: TextStyle(
                fontFamily: 'roboto',
                fontSize: Dimensions.sp14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              "04 Jun 2025, 09:00 am",
              style: TextStyle(
                fontFamily: 'roboto',
                fontSize: Dimensions.sp14,
                fontWeight: FontWeight.w500,
                color: ColorResources.color9a9a9a,
              ),
            ),


          ],
        ),
      ),
    );
  }
  void route(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        reverseTransitionDuration: Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // from right
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          final offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }
}
