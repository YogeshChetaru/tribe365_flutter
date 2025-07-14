import 'package:flutter/material.dart';
import '../../utill/color_resources.dart';
import '../../utill/dimensions.dart';
import '../../utill/images.dart';

class CustomHeaderBack extends StatelessWidget {
 final String title;

 const CustomHeaderBack({super.key, required this.title});

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
      ),
      width: MediaQuery.sizeOf(context).width,
      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: Row(
        children: [
          InkWell(
              onTap: () {
                Navigator.pop(context,true);
              },
              child: Image.asset(
                Images.imgCircleBackRed,
                width: 24,
                height: 24,
              )),
          Expanded(
              child: Container(
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(
                fontSize: Dimensions.sp18,
                fontWeight: FontWeight.w600,
                color: ColorResources.black,
              ),
            ),
          )),
          SizedBox(
            width: 24,
            height: 24,
          ),
        ],
      ),
    );
  }
}
