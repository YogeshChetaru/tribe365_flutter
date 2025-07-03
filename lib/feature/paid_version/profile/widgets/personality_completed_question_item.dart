import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/profile/controllers/profile_controller.dart';
import 'package:tribe365_new/utill/color_resources.dart';

class PersonalityCompletedQuestionItem extends StatelessWidget {
  final int questionIndex;
  final String questionText;
  final List<String> optionLabels;
  final int? selectedOption; // 0-4

  const PersonalityCompletedQuestionItem({
    super.key,
    required this.questionIndex,
    required this.questionText,
    required this.optionLabels,
    required this.selectedOption,
  });

  @override
  Widget build(BuildContext context) {
    // Helper: build one option button
    Widget buildOption(String text, int optionIndex) {
      final isSelected = selectedOption == optionIndex;

      return GestureDetector(
        onTap: () {
          /// ✅ Corrected call to provider method
          Provider.of<ProfileController>(context, listen: false)
              .setPersonalityCompletedQuestionListAnswer(
              questionIndex, optionIndex);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected
                ? ColorResources.mainColor
                : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: isSelected
                  ? ColorResources.mainColor
                  : Colors.grey.shade400,
            ),
          ),
          child: Text(
            text.toUpperCase(),
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Question header
            Text(
              "${questionIndex + 1}    $questionText",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 10),

            /// First row of 3 options
            Wrap(
              children: [
                buildOption(optionLabels[0], 0),
                buildOption(optionLabels[1], 1),
                buildOption(optionLabels[2], 2),
              ],
            ),

            const SizedBox(height: 6),

            /// Second row of 2 options
            Wrap(
              children: [
                buildOption(optionLabels[3], 3),
                buildOption(optionLabels[4], 4),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
