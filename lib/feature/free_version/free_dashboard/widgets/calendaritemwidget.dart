import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/free_version/free_dashboard/widgets/showsentimentdialog.dart';

import '../../../../utill/color_resources.dart';
import '../controllers/free_dashboard_controller.dart';

class CalendarItemWidget extends StatelessWidget {
  final String day;
  final String mood;
  final bool isWeekend;

  const CalendarItemWidget({super.key, required this.day, required this.isWeekend, required this.mood});

  @override
  Widget build(BuildContext context) {
    return Consumer<FreeDashboardController>(builder: (context, dashboardProvider, _) {
      return InkWell(
        onTap: () {
          showAnimatedDialog(context,mood);
        },
        child: Container(
          decoration: BoxDecoration(
            color: ColorResources.white,
            border: Border.all(color: Colors.white),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                day,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isWeekend ? ColorResources.mainColor : Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                dashboardProvider.getEmoji(mood),
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      );
    });
  }

  void showAnimatedDialog(BuildContext context,String moodData) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        barrierColor: Colors.black54,
        pageBuilder: (context, animation, secondaryAnimation) {
          return  Center(child: ShowSentimentDialog(mood: moodData,));
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // From right
          const end = Offset(-1.0, 0.0);  // To left when popping
          final tween = Tween(begin: begin, end: Offset.zero);
          final reverseTween = Tween(begin: Offset.zero, end: end);
          final offsetAnimation = animation.drive(tween);
          final reverseOffset = secondaryAnimation.drive(reverseTween);

          return SlideTransition(
            position: animation.status == AnimationStatus.reverse
                ? reverseOffset
                : offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }
}
