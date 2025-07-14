import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/images.dart';
import '../controllers/profile_controller.dart';
import '../domain/models/view_sot_question_answers_list_response.dart';

class BuildCultureStructureQuestionCompleted extends StatefulWidget {
   final ViewSotQuestionAnswersListData question;
  final List<ViewSotQuestionAnswersListOption> options;
  final int index;
  const BuildCultureStructureQuestionCompleted({super.key,required this.question,required this.options,required this.index});

  @override
  State<BuildCultureStructureQuestionCompleted> createState() => _BuildCultureStructureQuestionCompletedState();
}

class _BuildCultureStructureQuestionCompletedState extends State<BuildCultureStructureQuestionCompleted> {

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileController>(builder: (context, profileProvider, _) {
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
                "${getTranslated("question", context)!} ${widget.index + 1} : ${widget.question.question}",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10,),
              ...List.generate(widget.options.length, (i) {
                final option = widget.options[i];
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10,right: 10),
                      child: InkWell(
                        onTap: (){
                          profileProvider.selectOptionCompleted(widget.index, i);
                        },child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                option.question ?? "",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            Image.asset(option.isChecked!?Images.imgCircleCheckedRed :Images.imgCircleUnchecked,width: 20,height: 20,)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,)
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
