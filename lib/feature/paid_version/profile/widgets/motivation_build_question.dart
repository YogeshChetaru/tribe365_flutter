import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utill/color_resources.dart';
import '../controllers/profile_controller.dart';
import 'motivation_build_option_score_selector.dart';

class MotivationBuildQuestion extends StatefulWidget {
  final int index;

  const MotivationBuildQuestion({super.key, required this.index});

  @override
  State<MotivationBuildQuestion> createState() => _MotivationBuildQuestionState();
}

class _MotivationBuildQuestionState extends State<MotivationBuildQuestion> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileController>(builder: (context, profileController, _) {
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question ${widget.index + 1} : ',
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, fontFamily: 'Roboto', color: ColorResources.color333333),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '${profileController.motivationQuestions[widget.index]['question']}',
                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, fontFamily: 'Roboto', color: ColorResources.color333333),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: 0.5,
                color: ColorResources.color9a9a9a,
              ),
              const SizedBox(height: 10),
              ...List.generate(profileController.motivationQuestions[widget.index]['options'].length, (optionIndex) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profileController.motivationQuestions[widget.index]['options'][optionIndex],
                      style: const TextStyle(
                        fontSize: 15,
                        color: ColorResources.color333333,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    MotivationBuildOptionScoreSelector(questionIndex: widget.index, optionIndex: optionIndex),
                    const SizedBox(height: 16),
                  ],
                );
              }),
            ],
          ),
        ),
      );
    });
  }
}
