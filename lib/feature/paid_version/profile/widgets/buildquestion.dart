import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../controllers/profile_controller.dart';

class BuildQuestion extends StatefulWidget {
  final int index;
  const BuildQuestion({super.key,required this.index});

  @override
  State<BuildQuestion> createState() => _BuildQuestionState();
}

class _BuildQuestionState extends State<BuildQuestion> {

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileController>(builder: (context, profileProvider, _) {
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.index + 1}  ${profileProvider.questions[widget.index]}',
                style: const TextStyle(
                    fontSize: Dimensions.sp14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Roboto',
                    color: ColorResources.color333333
                ),
              ),
              const SizedBox(height: 15),
              Wrap(
                spacing: 10,
                runSpacing: 13,
                children: profileProvider.options.map((option) {
                  final isSelected = profileProvider.selectedAnswers[widget.index] == option;
                  return InkWell(
                    onTap: (){
                      profileProvider.updateSelectedAnswers(option, widget.index);
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 5, 10,5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color:isSelected?ColorResources.mainColor : ColorResources.color808080.withAlpha(80),
                      ),
                      child: Text(option,style: TextStyle(
                        fontSize: Dimensions.sp13,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto',
                        color: isSelected? ColorResources.white : ColorResources.color333333,
                      ),),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      );
    });
  }
}
