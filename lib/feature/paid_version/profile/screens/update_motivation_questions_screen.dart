
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/main.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../controllers/profile_controller.dart';
import '../widgets/motivation_build_question_update.dart';

class MotivationQuestionsUpdateScreen extends StatefulWidget {
  const MotivationQuestionsUpdateScreen({super.key});

  @override
  MotivationQuestionsUpdateScreenState createState() => MotivationQuestionsUpdateScreenState();
}

class MotivationQuestionsUpdateScreenState extends State<MotivationQuestionsUpdateScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  ProfileController profileController = Provider.of<ProfileController>(Get.context!, listen: false);

  @override
  void initState() {
    loadAPI();
    super.initState();
  }
  void loadAPI(){
    profileController.viewMotivationCompletedAnswerList( context);
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
                Container(
                  decoration: BoxDecoration(
                    color: ColorResources.white,
                    boxShadow: [
                      BoxShadow(
                        color: ColorResources.colorAAADC4,
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  width: MediaQuery.sizeOf(context).width,
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: Row(
                    children: [
                      InkWell(
                          onTap:() {
                            Navigator.of(context).pop();
                          },
                          child: Image.asset(
                            Images.imgCircleBackRed,
                            width: 24,
                            height: 24,
                          )),
                      Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              getTranslated("motivation_question", context)!,
                              style: TextStyle(
                                fontSize: Dimensions.sp18,
                                fontWeight: FontWeight.w600,
                                color: ColorResources.black,
                              ),
                            ),
                          )),
                      SizedBox(
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child:profileProvider.isLoading==true?
                  Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ):
                  Column(
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
                          itemCount: profileProvider.viewMotivationQuestionsCompletedList.length,
                          itemBuilder: (context, index) {
                            final question = profileProvider.viewMotivationQuestionsCompletedList[index];
                            return MotivationBuildQuestionUpdate(
                              question: question,
                              questionIndex: index,
                              onRatingChanged: (optionIndex, selectedRating) {
                                profileProvider.updateOptionRatingUpdate(
                                  question.questionId,
                                  optionIndex,
                                  selectedRating,
                                );
                              },
                            );
                          },
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
        return  profileProvider.isLoading==true?
        SizedBox.shrink():
            profileProvider.isLoadingBtn==true?
            Container(
              height: 70,
              color: ColorResources.white,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ) :
            Container(
          width: MediaQuery.sizeOf(context).width,
          height: 70,
          color: ColorResources.white,
          child: InkWell(
            onTap: () {
              profileProvider.validateAndSubmitUpdate(context);
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
                getTranslated("UPDATE", context)!,
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
