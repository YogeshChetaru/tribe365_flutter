import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../controllers/profile_controller.dart';
import '../widgets/personality_completed_question_item.dart';

class PersonalityQuestionsUpdateScreen extends StatefulWidget {
  const PersonalityQuestionsUpdateScreen({super.key});

  @override
  PersonalityQuestionsUpdateScreenState createState() =>
      PersonalityQuestionsUpdateScreenState();
}

class PersonalityQuestionsUpdateScreenState
    extends State<PersonalityQuestionsUpdateScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    loadAPI();
  }

  void loadAPI() {
    ProfileController controller =
        Provider.of<ProfileController>(context, listen: false);
    controller.viewPersonalityCompletedQuestionList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child:
            Consumer<ProfileController>(builder: (context, profileProvider, _) {
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
                          onTap: () {
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
                          getTranslated(
                              "update_personality_questions", context)!,
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
                profileProvider.isLoading == true
                    ? Expanded(
                        flex: 1,
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          height: MediaQuery.sizeOf(context).height,
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        flex: 1,
                        child: ListView.builder(
                          itemCount: profileProvider
                              .viewPersonalityCompletedAnswersList!.length,
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final question = profileProvider
                                .viewPersonalityCompletedAnswersList![index];
                            return PersonalityCompletedQuestionItem(
                              questionIndex: index,
                              questionText: question.question!,
                              optionLabels: question.options!
                                  .map((o) => o.optionName!)
                                  .toList(),
                              selectedOption: question.options!
                                  .indexWhere((o) => o.isChecked!),
                            );
                          },
                        ),
                      ),
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: SafeArea(child:
          Consumer<ProfileController>(builder: (context, profileProvider, _) {
        return profileProvider.isLoading == true
            ? SizedBox()
            : profileProvider.isLoadingBtn == true
                ? Container(
                    height: 70,
                    color: ColorResources.white,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  )
                : Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: 70,
                    color: ColorResources.white,
                    child: InkWell(
                      onTap: () {
                        profileProvider.sendPersonalityCompletedData();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.sizeOf(context).width,
                        margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
                        decoration: BoxDecoration(
                          color: ColorResources.mainColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
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
