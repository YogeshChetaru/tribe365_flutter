import 'package:flutter/material.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/dimensions.dart';
import 'package:tribe365_new/utill/images.dart';

class AmazingAwardUserItem extends StatelessWidget {
  final String userName;
  final bool isSelected;

  const AmazingAwardUserItem({required this.userName, required this.isSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10,),
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            children: [
              Image.asset(isSelected ? Images.imgCircleCheckedRed : Images.imgCircleUnchecked,width: 20,height: 20,),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: Text(
                  userName,
                  style: const TextStyle(fontSize: Dimensions.sp14, fontWeight: FontWeight.w600, fontFamily: 'roboto', color: ColorResources.color333333),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10,),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: ColorResources.color9a9a9a,
        )
      ],
    );
  }
}
