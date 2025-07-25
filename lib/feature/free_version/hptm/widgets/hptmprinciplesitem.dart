import 'package:flutter/material.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/dimensions.dart';

import '../domain/models/view_hptm_principles_list.dart';

class HptmPrinciplesItem extends StatelessWidget {
  final int indexMain;
  final PrincipleData principleData;

  const HptmPrinciplesItem({super.key, required this.indexMain,required this.principleData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorResources.white,
        boxShadow: [
          BoxShadow(
            color: ColorResources.colorAAADC4,
            blurRadius: 5.0,
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
              principleData.title!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: Dimensions.sp16,
                color: ColorResources.mainColor,
                fontWeight: FontWeight.w600,
                fontFamily: 'Roboto',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Text(
              principleData.description!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: Dimensions.sp14,
                color: ColorResources.color333333,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            width: MediaQuery.sizeOf(context).width,
          height: 1,
            color: ColorResources.mainColor,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: Text(
              "${getTranslated("completion", context)} - ${principleData.completionPercent}%",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: Dimensions.sp16,
                color: ColorResources.color333333,
                fontWeight: FontWeight.w600,
                fontFamily: 'Roboto',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
