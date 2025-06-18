import 'package:flutter/material.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/custom_route.dart';

import '../../../../utill/dimensions.dart';
import '../../../../utill/utility.dart';
import '../domain/models/view_offloading_list_response.dart';
import '../screens/offloading_chat_details_screen.dart';

class OffloadingHistoryItem extends StatelessWidget {
  final ViewOffLoadingListData data;
  const OffloadingHistoryItem({super.key,required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        routePush(context, OffLoadingChatDetailsScreen(offLoadingData: data,));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
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
            if (data.image != "")
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
}
