import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../controllers/profile_controller.dart';
import '../domain/models/view_diagnostic_question_list_response.dart';

class BuildDiagnosticQuestion extends StatelessWidget {
  final ViewDiagnosticQuestionListData question;
  final int index;

  const BuildDiagnosticQuestion({
    super.key,
    required this.question,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileController>(
      builder: (context, profileProvider, _) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${getTranslated("question", context)!} ${index + 1}: ${question.question ?? ""}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(
                    question.options?.length ?? 0,
                        (i) {
                      final option = question.options![i];
                      final isSelected = question.answer == "${i + 1}";

                      return InkWell(
                        onTap: () {
                          profileProvider.selectDiagnosticOption(index, i + 1);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 14,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? ColorResources.mainColor
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            option.optionName ?? "",
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
