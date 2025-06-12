import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/free_version/free_dashboard/widgets/showsentimentdialog.dart';

import '../../../../utill/color_resources.dart';
import '../controllers/free_dashboard_controller.dart';

class CalendarItemWidget extends StatelessWidget {
  final String day;
  final bool isWeekend;
  final dynamic mood;
  final bool isNotWorkingDay;
  final dynamic date;

  const CalendarItemWidget({
    super.key,
    required this.day,
    required this.isWeekend,
    this.mood,
    this.date,
    this.isNotWorkingDay = false,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      color: isWeekend ? Colors.red : Colors.black,
      fontWeight: FontWeight.w600,
    );

    return Consumer<FreeDashboardController>(builder: (context, dashboardProvider, _) {
      return InkWell(
        onTap: () {
          showAnimatedDialog(context,mood,date);
        },
        child: Container(
          decoration: day!=""? BoxDecoration(
            color: ColorResources.white,
            border: Border.all(color: Colors.white),
          ):null,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                day,
                style: textStyle,
              ),
              const SizedBox(height: 4),
              if(day!="")
              isNotWorkingDay?
              SizedBox(width: 20,
                  height: 20,
                  child: Center(child: Container(width: 10,height: 2,color: ColorResources.black,))):
              Image.asset(
               dashboardProvider.getMoodImage(mood),
                width: 20,
                height: 20,
              ),
            ],
          ),
        ),
      );
    });
  }

  void showAnimatedDialog(BuildContext context,dynamic moodData,dynamic date1) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        barrierColor: Colors.black54,
        pageBuilder: (context, animation, secondaryAnimation) {
          return  Center(child: ShowSentimentDialog(mood: moodData,date: date1,));
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
/*class CalendarItemWidget extends StatelessWidget {
  final String day;
  final bool isWeekend;
  final dynamic mood;
  final bool isNotWorkingDay;

  const CalendarItemWidget({
    super.key,
    required this.day,
    required this.isWeekend,
    this.mood,
    this.isNotWorkingDay = false,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor = isNotWorkingDay ? Colors.grey[300]! : Colors.white;
    TextStyle textStyle = TextStyle(
      color: isWeekend ? Colors.red : Colors.black,
      fontWeight: FontWeight.w600,
    );

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: Colors.grey),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(day, style: textStyle),
            if (mood != null)
              Text(mood.toString(), style: TextStyle(fontSize: 18)), // emoji/score
          ],
        ),
      ),
    );
  }
}*/
