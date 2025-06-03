import 'package:flutter/material.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/dimensions.dart';
import 'package:tribe365_new/utill/images.dart';

class AmazingUserItem extends StatelessWidget {
  const AmazingUserItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15, right: 15, left: 15),
      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
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
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorResources.mainColor, width: 1),
                  image: DecorationImage(
                    image: AssetImage(Images.imgUserCircleGray),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "user name",
                  style: const TextStyle(fontSize: Dimensions.sp14, fontWeight: FontWeight.w600, fontFamily: 'roboto', color: ColorResources.color333333),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
