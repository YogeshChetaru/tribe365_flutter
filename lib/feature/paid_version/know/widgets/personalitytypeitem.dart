import 'package:flutter/material.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/dimensions.dart';
import '../../../../utill/custom_route.dart';
import '../../profile/domain/models/viewuserprofileresponse.dart';
import '../../profile/screens/personality_type_result_screen.dart';

class PersonalityTypeItem extends StatelessWidget {
  final PersonalityTypeDetailsArr? personalityTypeDetails;
  const PersonalityTypeItem({super.key,required this.personalityTypeDetails});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        routePush(context, PersonalityTypeResultScreen());
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
                personalityTypeDetails!.cateName!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: Dimensions.sp14,
                  color: ColorResources.white,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Text(
                personalityTypeDetails!.score!.toString(),
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
