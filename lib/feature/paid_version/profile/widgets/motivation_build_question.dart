import 'package:flutter/material.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../domain/models/get_motivation_list_response.dart';

class MotivationBuildQuestion extends StatelessWidget {
  final SOTMotivationQuestion question;
  final int questionIndex;
  final void Function(int optionIndex, String selectedRating) onRatingChanged;

  const MotivationBuildQuestion({
    super.key,
    required this.question,
    required this.questionIndex,
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question text
            Text(
              'Question ${questionIndex + 1}: ${question.questionName ?? ''}' ,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                fontFamily: 'Roboto',
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 0.5,
              color: const Color(0xFF9A9A9A),
            ),
            const SizedBox(height: 10),
            // Option blocks
            ...List.generate(question.option?.length ?? 0, (optIndex) {
              final option = question.option![optIndex];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.option ?? '',
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF333333),
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: List.generate(6, (score) {
                      final isSelected = option.rating == score.toString();
                      return GestureDetector(
                        onTap: () {
                          onRatingChanged(optIndex, score.toString());
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          margin: const EdgeInsets.only(right: 8),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.red : Colors.white,
                            border: Border.all(color: ColorResources.colorAAADC4,width: 0.5),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '$score',
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontSize: 14,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
