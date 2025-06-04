import 'package:flutter/material.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/dimensions.dart';

class SelectActionUserItem extends StatelessWidget {
  const SelectActionUserItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.only(top: 10) ,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 0, right: 15, left: 15),
            child: Text(
              "user name",
              style: const TextStyle(fontSize: Dimensions.sp14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'roboto',
                  color: ColorResources.black),
            ),
          ),
          Container(
            margin:EdgeInsets.only(top: 10) ,
            width: MediaQuery.of(context).size.width,
            height: 0.5,
            color: ColorResources.color9a9a9a,
          )
        ],
      ),
    );
  }
}
