import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/dimensions.dart';
import '../controllers/free_dashboard_controller.dart';

class ShowSentimentDialog extends StatelessWidget {
  final String mood;
  const ShowSentimentDialog({super.key,required this.mood});

  @override
  Widget build(BuildContext context) {
    return Consumer<FreeDashboardController>(builder: (context, dashboardProvider, _) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                getTranslated("sentiment_index", context)!,
                style: TextStyle(
                  fontSize: Dimensions.sp16,
                  color: ColorResources.mainColor, // Replace with ColorResources.mainColor
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                ),
              ),
              Text(
                "Thu, 01 May 2025",
                style: TextStyle(
                  fontSize: Dimensions.sp14,
                  color: ColorResources.color9a9a9a, // Replace with ColorResources.mainColor
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    dashboardProvider.getEmoji(mood),
                    style: const TextStyle(fontSize: 24),
                  ),
                  SizedBox(width: 3,),
                  Text(
                    "33.33%",
                    style: TextStyle(
                      fontSize: Dimensions.sp16,
                      color: ColorResources.mainColor, // Replace with ColorResources.mainColor
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}


