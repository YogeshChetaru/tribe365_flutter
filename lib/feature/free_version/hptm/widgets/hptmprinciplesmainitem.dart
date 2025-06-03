import 'package:flutter/material.dart';
import 'package:tribe365_new/feature/free_version/hptm/widgets/hptmprinciplesmainsubitem.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/images.dart';

class HptmPrinciplesMainItem extends StatelessWidget {
  const HptmPrinciplesMainItem(Map<String, dynamic> category, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
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
                child: Text(
                  "Module Coaching Video",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'roboto',
                      color: ColorResources.color333333
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Image.asset(
                Images.imgDownArrowRed,
                width: 20,
                height: 20,
              ),
            ],
          ),
          const SizedBox(height: 10),
          ListView.builder(
            itemCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, childIndex) {
              return HptmPrinciplesMainSubItem(index: childIndex,);
            },
          ),
        ],
      ),
    );
  }
}
