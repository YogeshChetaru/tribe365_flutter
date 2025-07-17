import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/profile/controllers/profile_controller.dart';
import 'package:tribe365_new/feature/paid_version/profile/screens/team_role_details_screen.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/dimensions.dart';

import '../../../../main.dart';

class TeamRoleItem extends StatelessWidget {
 final String name;

  const TeamRoleItem({super.key,required this.name});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
       bool status = await Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 500),
            reverseTransitionDuration: Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondaryAnimation) => TeamRoleDetailsScreen(teamRoleName: name,),
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
        if(status){
          Provider.of<ProfileController>(Get.context!,listen: false).viewUserProfile();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: ColorResources.mainColor,
          boxShadow: [
            BoxShadow(
              color: ColorResources.colorAAADC4,
              blurRadius: 2.0,
            ),
          ],
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Text(
               name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: Dimensions.sp14,
                  color: ColorResources.white,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
