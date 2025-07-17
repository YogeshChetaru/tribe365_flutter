import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utill/color_resources.dart';
import '../controllers/notification_controller.dart';

class TeamFeedbackListScreen extends StatelessWidget {
  const TeamFeedbackListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationController>(
      builder: (context, provider, _) {
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: provider.questionArrList!.length,
          itemBuilder: (context, qIndex) {
            final question = provider.questionArrList![qIndex];
            final replacedText = question.question!.replaceAll('<Name>', provider.userName);
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorResources.mainColor,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            question.questionId.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            replacedText,
                            style: TextStyle(
                              color: Colors.red.shade800,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    itemCount: question.options!.length,
                    itemBuilder: (context, oIndex) {
                      final option = question.options![oIndex];
                      final isSelected = option.answerFlag;

                      return GestureDetector(
                        onTap: () {
                          provider.selectOption(qIndex, oIndex);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                          decoration: BoxDecoration(
                            color: isSelected ? ColorResources.mainColor : Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Text(
                            option.optionName!,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}