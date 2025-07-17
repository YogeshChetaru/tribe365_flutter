import 'package:flutter/material.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/utility.dart';

import '../../../../utill/dimensions.dart';
import '../domain/models/view_support_history_list_response.dart';
import '../screens/support_chat_details_screen.dart';

class SupportHistoryItem extends StatelessWidget {
  final ViewSupportHistoryListData data;
  const SupportHistoryItem({super.key,required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        route(context, SupportChatDetailsScreen(supportData: data,));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
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
              data.message!,
              style: TextStyle(
                fontFamily: 'roboto',
                fontSize: Dimensions.sp14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 2,),
            Text(
              Utility.convertDataIntoddMMMyyyyhhmma(data.createdAt!),
              style: TextStyle(
                fontFamily: 'roboto',
                fontSize: Dimensions.sp14,
                fontWeight: FontWeight.w500,
                color: ColorResources.color9a9a9a,
              ),
            ),
            if (data.image != "")
              Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: Image.network(
                    data.image!,
                    width: 60,
                    height: 60,
                    fit: BoxFit.fill,
                  )
              ),
              SizedBox(height: 5,),
            Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              decoration: BoxDecoration(
                color: data.status=="Active"?ColorResources.colorFFF2BC: ColorResources.colorDFF5E4,
                borderRadius: BorderRadius.circular(10),
              ),
              child:
              Text(data.status=="Active"?getTranslated("active", context)!:getTranslated("complete", context)!,
                style: TextStyle(
                  color:data.status=="Active"?ColorResources.colorE1BE0D:ColorResources.color54B569,
                  fontFamily: 'roboto',
                  fontSize: Dimensions.sp14,
                  fontWeight: FontWeight.w500,
                ),),
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
