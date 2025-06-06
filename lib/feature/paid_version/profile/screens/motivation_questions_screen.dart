import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/main.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../../../../common/basewidget/custom_header_back_widget.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/dimensions.dart';
import '../controllers/profile_controller.dart';
import '../widgets/motivation_build_question.dart';

class MotivationQuestionsScreen extends StatefulWidget {
  const MotivationQuestionsScreen({super.key});

  @override
  MotivationQuestionsScreenState createState() => MotivationQuestionsScreenState();
}

class MotivationQuestionsScreenState extends State<MotivationQuestionsScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  ProfileController profileController = Provider.of<ProfileController>(Get.context!, listen: false);

  @override
  void initState() {
    profileController.initMotivationQuestions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Consumer<ProfileController>(builder: (context, profileProvider, _) {
          return Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            color: ColorResources.screenBg,
            child: Column(
              children: [
                CustomHeaderBack(
                  title: getTranslated("motivation_question", context)!,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                       Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          getTranslated("in_each_section_select_the_most_applicable_sentence_to_your_organisation", context)!,
                          style: TextStyle(
                              fontSize: Dimensions.sp16,
                              color: ColorResources.black,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: profileProvider.motivationQuestions.length,
                          itemBuilder: (context, index) => MotivationBuildQuestion(index: index),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: SafeArea(child: Consumer<ProfileController>(builder: (context, profileProvider, _) {
        return Container(
          width: MediaQuery.sizeOf(context).width,
          height: 70,
          color: ColorResources.white,
          child: InkWell(
            onTap: () {
              profileController.selectedScores.forEach((qIndex, optionsMap) {
                optionsMap.forEach((oIndex, score) {
                  debugPrint('Q${qIndex + 1} - Option ${oIndex + 1}: Score = ${score == -1 ? "Not selected" : score}');
                });
              });
            },
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.sizeOf(context).width,
              margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
              decoration: BoxDecoration(
                color: ColorResources.mainColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
              ),
              child: Text(
                getTranslated("submit", context)!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: Dimensions.sp16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          ),
        );
      })),
    );
  }
}
