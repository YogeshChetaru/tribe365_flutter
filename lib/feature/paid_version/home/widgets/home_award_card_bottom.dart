import 'package:flutter/material.dart';
import 'package:tribe365_new/feature/paid_version/home/controllers/home_controller.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/images.dart';
import 'package:tribe365_new/utill/utility.dart';

class HomeAwardCardBottom extends StatelessWidget {
  final HomeController controller;
  const HomeAwardCardBottom({super.key,required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(7),
          margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
          decoration: BoxDecoration(
            color: ColorResources.mainColor,
            borderRadius: BorderRadius.circular(60.0),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                child: Stack(
                  clipBehavior: Clip.none, // Allow overflow
                  alignment: Alignment.center,
                  children: [
                    controller.latestKudosAwardData!.kudoAwardCount > 0?
                    Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(Images.imgGroupCircleRed),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ):
                    controller.latestKudosAwardData!.userImage==""?
                    Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(Images.imgUserCircleGray),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ):
                    Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(controller.latestKudosAwardData!.userImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 6.0,
                      right: -7.0, // move it more outward
                      child: Image.asset(
                        Images.imgKudosAwards,
                        width: 14,
                        height: 14,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.latestKudosAwardData!.awardDescription!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white, fontSize: 12.0, fontFamily: 'Roboto', fontWeight: FontWeight.w400),
                    ),
                    Text(
                     controller.kudosValueTv,
                      style: TextStyle(color: Colors.white, fontSize: 12.0, fontFamily: 'Roboto', fontWeight: FontWeight.w500),
                    ),
                    Text(
                      Utility.convertDataIntoddMMMyyyyhhmma(controller.latestKudosAwardData!.awardDate!),
                      style: TextStyle(color: Colors.white, fontSize: 10.0, fontFamily: 'Roboto', fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
