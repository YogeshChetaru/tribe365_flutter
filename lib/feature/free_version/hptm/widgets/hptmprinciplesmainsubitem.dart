import 'package:flutter/material.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/images.dart';

class HptmPrinciplesMainSubItem extends StatelessWidget {
 final int index;
  const HptmPrinciplesMainSubItem({super.key,required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                Images.imgCircleUnchecked,
                width: 24,
                height: 24,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      textAlign: TextAlign.start,
                      "HPTM Session 1 - Introduction",
                      style: const TextStyle(

                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'roboto',
                          color: ColorResources.color333333
                      ),
                    ),
                    Text(
                      "A Pre-recorded session on HPTM principles, techniques, and best practices.",
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'roboto',
                          color: ColorResources.color333333
                      ),
                    ),
                    SizedBox(height: 5,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          Images.imgWatchVideoRed,
                          width: 18,
                          height: 18,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                textAlign: TextAlign.start,
                                "Watch the video",
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'roboto',
                                    color: ColorResources.mainColor
                                ),
                              ),

                            ],
                          ),
                        ),

                      ],
                    ),

                  ],
                ),
              ),

            ],
          ),
          SizedBox(height: 5,),
          if(index!=1)
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: 0.5,
            color: ColorResources.color9a9a9a,
          )
        ],
      ),
    );
  }
}
