import 'package:flutter/material.dart';

import '../domain/models/view_home_kudos_count_response.dart';

class HomeBeliefItem extends StatelessWidget {
  final ViewHomeKudosCountBelief item;
  final String showText;
  final String topTitle;

  const HomeBeliefItem({
    super.key,
    required this.item,
    required this.showText,
    required this.topTitle,
  });

  @override
  Widget build(BuildContext context) {
    String displayValue = "";

    if (topTitle == "Kudos Values") {
      if (showText == "Today") {
        displayValue = item.todayKudosCount.toString();
      } else if (showText == "Yesterday") {
        displayValue = item.yesterdayKudosCount.toString();
      } else if (showText == "This week") {
        displayValue = item.thisWeekKudosCount.toString();
      } else if (showText == "Last week") {
        displayValue = item.lastWeekKudosCount.toString();
      } else if (showText == "This month") {
        displayValue = item.thisMonthKudosCount.toString();
      } else if (showText == "Last month") {
        displayValue = item.lastMonthKudosCount.toString();
      } else {
        displayValue = item.totalKudosCount.toString();
      }
    } else {
      if (showText == "Today") {
        displayValue = item.todayDotValueKudoAwardCount.toString();
      } else if (showText == "Yesterday") {
        displayValue = item.yesterdayDotValueKudoAwardCount.toString();
      } else if (showText == "This week") {
        displayValue = item.thisWeekDotValueKudoAwardCount.toString();
      } else if (showText == "Last week") {
        displayValue = item.lastWeekDotValueKudoAwardCount.toString();
      } else if (showText == "This month") {
        displayValue = item.thisMonthDotValueKudoAwardCount.toString();
      } else if (showText == "Last month") {
        displayValue = item.lastMonthDotValueKudoAwardCount.toString();
      } else {
        displayValue = item.totalDotValueKudoAwardCount.toString();
      }
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  item.name!,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                displayValue,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 0.5, color: Colors.grey),
      ],
    );
  }
}
