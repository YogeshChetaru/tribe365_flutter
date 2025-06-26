import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/main.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../controllers/profile_controller.dart';
import '../domain/models/get_question_list_response.dart';
import '../widgets/team_role_build_statement.dart';

class TeamRoleScreen extends StatefulWidget {
  const TeamRoleScreen({super.key});

  @override
  TeamRoleScreenState createState() => TeamRoleScreenState();
}

class TeamRoleScreenState extends State<TeamRoleScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  ProfileController profileController = Provider.of<ProfileController>(Get.context!,listen: false);

  @override
  void initState() {
    super.initState();
    profileController.initCounters();
    loadAPI();

  }
  void loadAPI() {
    profileController.viewQuestionsList();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:  _onBackPressed,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: Consumer<ProfileController>(builder: (context, profileProvider, _) {
            GetQuestionListData? question;
            if(profileController.questions.isNotEmpty){
            question = profileController.questions[profileController.currentIndex];
           }
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
                            onTap: _onBackPressed,
                            child: Image.asset(
                              Images.imgCircleBackRed,
                              width: 24,
                              height: 24,
                            )),
                        Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                getTranslated("team_role", context)!,
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
                    child:profileProvider.isLoading?
                    Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                    ):
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                          child: Text(
                            question!.questionName!,
                            style: TextStyle(
                              fontSize: Dimensions.sp16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Roboto',
                              color: ColorResources.color333333
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: ListView.builder(
                            itemCount:profileProvider.currentOptions.length,
                            itemBuilder: (context, index) => TeamRoleBuildStatement(index: index),
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
        bottomNavigationBar: SafeArea(
            child: Consumer<ProfileController>(
                builder: (context, profileProvider, _) {
                  bool isLastQuestion = profileProvider.currentIndex ==
                      profileProvider.questions.length - 1;
          return profileProvider.isLoading?
          SizedBox():
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: 120,
            color: ColorResources.white,
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
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  width: MediaQuery.sizeOf(context).width,
                  margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                  padding: EdgeInsets.fromLTRB(15, 7, 15, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                        getTranslated("total", context)!,
                        style: TextStyle(fontSize: Dimensions.sp16, fontWeight: FontWeight.w600,
                        fontFamily: 'Roboto', color: ColorResources.color9a9a9a),
                      ),
                      Text(
                        '${profileProvider.currentTotal}/10',
                        style:TextStyle(fontSize: Dimensions.sp16, fontWeight: FontWeight.w600,
                            fontFamily: 'Roboto', color: ColorResources.color333333),
                      ),
                    ],
                  ),
                ),
                //submit btn
                if (isLastQuestion)
                InkWell(
                  onTap: () {
                   profileController.validateAndSubmitQuestion(profileProvider.currentIndex, context);
                  },
                  child: Container(
                    height: 50,
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

                //next btn
                if (!isLastQuestion)
                InkWell(
                  onTap: () {
                    profileProvider.totalCount();
                    profileProvider.validateAnswers(context);
                  },
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    width: MediaQuery.sizeOf(context).width,
                    margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
                    decoration: BoxDecoration(
                      color: ColorResources.mainColor,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                    ),
                    child: Text(
                      getTranslated("next_question", context)!,
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
              ],
            ),
          );
        })),
      ),
    );
  }



  Future<bool> _showSaveDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text(
          "Do you want to save the answers?",
          style: TextStyle(color: Color(0xFF515050)),
        ),
        actions: [
          TextButton(
            child: const Text("No", style: TextStyle(color: Colors.grey)),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            child: const Text("Yes", style: TextStyle(color: ColorResources.mainColor)),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    ) ??
        false;
  }



  Future<bool> _onBackPressed() async {
    final profileProvider = Provider.of<ProfileController>(context, listen: false);

    // Step 1: Check if any answer exists in the main question list
    bool hasAnsweredAnything = profileProvider.questions.any((question) {
      return question.option?.any((opt) {
        final answer = int.tryParse(opt.answer ?? "0") ?? 0;
        return answer > 0;
      }) ?? false;
    });


    // Step 2: If answered, show save dialog
    if (hasAnsweredAnything) {
      bool shouldSave = await _showSaveDialog(context);
      if (shouldSave) {
        profileProvider.saveUserTeamRoleData(
          jsonEncode(profileProvider.questions.map((q) => q.toJson()).toList()),
          Get.context!,
        );
      }
      return true; // Always allow screen to pop
    } else {
      return true; // No answers → just pop
    }
  }

}
