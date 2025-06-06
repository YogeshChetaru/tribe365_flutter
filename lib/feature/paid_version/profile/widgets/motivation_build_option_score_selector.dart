import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/dimensions.dart';
import '../controllers/profile_controller.dart';

class MotivationBuildOptionScoreSelector extends StatefulWidget {
 final int questionIndex;
 final int optionIndex;
  const MotivationBuildOptionScoreSelector({super.key,required this.questionIndex, required this.optionIndex});

  @override
  State<MotivationBuildOptionScoreSelector> createState() => _MotivationBuildOptionScoreSelectorState();
}

class _MotivationBuildOptionScoreSelectorState extends State<MotivationBuildOptionScoreSelector> {

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileController>(builder: (context, profileController, _) {
      return Row(
        children: List.generate(6, (score) {
          bool isSelected = profileController.selectedScores[widget.questionIndex]![widget.optionIndex] == score;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GestureDetector(
              onTap: () {
                profileController.updateSelectedScores(widget.questionIndex,widget.optionIndex,score);
              },
              child: Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? ColorResources.mainColor : Colors.transparent,
                  border: Border.all(color: ColorResources.color9a9a9a),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '$score',
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: Dimensions.sp14,
                    fontFamily: 'Roboto'
                  ),
                ),
              ),
            ),
          );
        }),
      );
    });
  }
}
