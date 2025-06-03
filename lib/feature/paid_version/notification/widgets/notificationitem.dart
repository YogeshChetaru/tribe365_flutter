import 'package:flutter/material.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/images.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Row(
              children: [
                Image.asset(
                  Images.imgChecklistUncheck,
                  width: 35,
                  height: 35,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "First Use checklist",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'roboto', color: ColorResources.color333333),
                    ),
                    Text(
                      "Complete Personality Type Questionnaire",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'roboto', color: ColorResources.color333333),
                    ),
                  ],
                ))
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: ColorResources.color9a9a9a,
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          ),
        ],
      ),
    );
  }
}
