import 'package:flutter/material.dart';
import 'package:tribe365_new/feature/paid_version/offloading/screens/offloading_chat_details_screen.dart';
import 'package:tribe365_new/feature/paid_version/offloading/screens/reflection_chat_details_screen.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/custom_route.dart';
import 'package:tribe365_new/utill/utility.dart';

import '../../../../utill/dimensions.dart';
import '../domain/models/view_reflection_list_response.dart';

class RecentReflectionItem extends StatelessWidget {
  final ViewReflectionListData data;
  const RecentReflectionItem({super.key,required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        routePush(context, ReflectionChatDetailsScreen(reflectionId: data.id.toString(),));
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
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
              data.message!,
              style: TextStyle(
                fontFamily: 'roboto',
                fontSize: Dimensions.sp14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              Utility.convertDataIntoddMMMyyyyhhmma(data.createdAt!),
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
}
