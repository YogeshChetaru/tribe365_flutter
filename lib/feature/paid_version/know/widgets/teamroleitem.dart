import 'package:flutter/material.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/dimensions.dart';

class TeamRoleItem extends StatelessWidget {
 final String name;

  const TeamRoleItem({super.key,required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
