import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../controllers/profile_controller.dart';
import '../domain/models/view_personality_type_question_list_response.dart';

class BuildQuestion extends StatefulWidget {
  final ViewPersonalityTypeQuestionListData itemData;
  final int index;
  const BuildQuestion({super.key,required this.itemData,required this.index});

  @override
  State<BuildQuestion> createState() => _BuildQuestionState();
}

class _BuildQuestionState extends State<BuildQuestion> {

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileController>(builder: (context, profileProvider, _) {
      return Card(
        margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "${widget.index + 1}     ${widget.itemData.question ?? ""}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Options Buttons
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(widget.itemData.options?.length ?? 0, (optIndex) {
                  final option = widget.itemData.options![optIndex];
                  final isSelected = widget.itemData.answer == (optIndex + 1).toString();

                  return GestureDetector(
                    onTap: () {
                      profileProvider.setPersonalityTypeQuestionListAnswer(widget.index, (optIndex + 1).toString());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? ColorResources.mainColor : Colors.grey[200],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        option.optionName ?? "",
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      );
    });
  }
}
