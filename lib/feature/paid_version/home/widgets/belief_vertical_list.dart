import 'package:flutter/material.dart';
import 'package:tribe365_new/feature/paid_version/home/controllers/home_controller.dart';
import 'package:tribe365_new/feature/paid_version/home/widgets/rating_dialog.dart';
import 'package:tribe365_new/utill/color_resources.dart';

import '../../../../localization/language_constrants.dart';
import '../domain/models/view_dot_details_response.dart';
import 'open_link_dialog.dart';

class BeliefVerticalList extends StatelessWidget {
  final List<BeliefValue> beliefValues;
  final String role;
  final HomeController controller;

   const BeliefVerticalList({
    required this.beliefValues,
    required this.role,
    required this.controller,
    super.key,

  });

  Color getColorByRating(String? rating) {
    switch (rating) {
      case "0":
        return ColorResources.colorb2b2b2;
      case "1":
        return ColorResources.colorb2b2b2;
      case "2":
        return ColorResources.colorffa3a6;
      case "3":
        return ColorResources.colorff8085;
      case "4":
        return ColorResources.colorff454b;
      case "5":
        return ColorResources.coloreb1c24;
      default:
        return ColorResources.color999896;
    }
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: beliefValues.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final value = beliefValues[index];
        final isLeader = role == "1";
        return GestureDetector(
          onTap: () {
            if (role=="3") {
              showDialog(
                context: context,
                builder: (context) => RatingDialog(
                  value: value,
                  dotId: value.dotId.toString(),
                  beliefId: value.beliefId.toString(),
                  valueId: value.id.toString() ,
                  onSubmit: (selectedRating) {
                   controller.addRatingsToDotValues(
                       controller.userId,
                       value.dotId.toString(),
                       value.beliefId.toString(),
                       value.id.toString(),
                       selectedRating.toString());
                  },
                ),
              );
            }
          },
          onLongPress: (){
            if (value.valueUrl !="" || value.valueDesc!="" ) {
              openLinkDialog(
                context,
                title: getTranslated("value", context)!,
                subTitle: value.name! ,
                description: value.valueDesc!,
                videoURL: value.valueUrl!,
              );
            }
          },
          child: Container(
            height: 70,
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isLeader ? Colors.white : getColorByRating(value.ratings),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              textAlign: TextAlign.center,
              value.ratings != null && value.ratings!.isNotEmpty
                  ? "${value.name}\n${value.ratings}"
                  : value.name ?? '',
              style: const TextStyle(fontSize: 12,fontFamily: "Roboto",fontWeight: FontWeight.w400,color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}