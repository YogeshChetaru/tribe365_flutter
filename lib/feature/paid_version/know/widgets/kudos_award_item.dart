import 'package:flutter/material.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/utility.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../home/widgets/amazingawarduserdialog.dart';
import '../domain/models/view_know_organisation_response.dart';

class KudosAwardItem extends StatelessWidget {
 final LatestKudosAward data;
 final int index;
 final List<LatestKudosAward>? latestKudosAwardMainList;
  const KudosAwardItem({super.key,required this.data,required this.latestKudosAwardMainList,required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(context, AmazingAwardUserDialog(data: data,));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.userName!,
              style: TextStyle(
                fontFamily: 'roboto',
                fontSize: Dimensions.sp14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Text(
             data.awardValue!,
              style: TextStyle(
                fontFamily: 'roboto',
                fontSize: Dimensions.sp14,
                fontWeight: FontWeight.w600,
                color: ColorResources.mainColor,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Images.imgGroupCircleRed,
                  width: 20,
                  height: 20,
                ),
                SizedBox(
                  width: 5,
                ),
               data.viewMoreUsers!.length==1?
                  Text(
                    data.viewMoreUsers![0].userName!,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'roboto',
                      fontSize: Dimensions.sp14,
                      fontWeight: FontWeight.w400,
                      color: ColorResources.color333333,
                    ),
                  ):
                  Text(
                    "${ data.viewMoreUsers![0].userName!} & ${data.viewMoreUsers!.length-1} ${getTranslated("more", context)!}",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'roboto',
                      fontSize: Dimensions.sp14,
                      fontWeight: FontWeight.w400,
                      color: ColorResources.color333333,
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Text(
                Utility.convertDataIntoddMMMyyyyhhmma(data.awardDate!),
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontFamily: 'roboto',
                  fontSize: Dimensions.sp12,
                  fontWeight: FontWeight.w400,
                  color: ColorResources.color9a9a9a,
                ),
              ),
            ),
            SizedBox(height: 10,),
            if(latestKudosAwardMainList!.length-1!=index)
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: 0.5,
              color: ColorResources.color333333,
            )
          ],
        ),
      ),
    );
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
