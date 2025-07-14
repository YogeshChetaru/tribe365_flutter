import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/main.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../controllers/profile_controller.dart';
import '../domain/models/get_update_question_list_response.dart';
import '../widgets/team_role_build_statement_update.dart';

class TeamRoleUpdateScreen extends StatefulWidget {
  const TeamRoleUpdateScreen({super.key});

  @override
  TeamRoleUpdateScreenState createState() => TeamRoleUpdateScreenState();
}

class TeamRoleUpdateScreenState extends State<TeamRoleUpdateScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  ProfileController profileController = Provider.of<ProfileController>(Get.context!,listen: false);

  @override
  void initState() {
    super.initState();

    loadAPI();

  }
  void loadAPI() {
    profileController.viewQuestionsListUpdate();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Consumer<ProfileController>(builder: (context, profileProvider, _) {
          GetUpdateQuestionListData? question;
          if(profileController.questionsUpdate.isNotEmpty){
          question = profileController.questionsUpdate[profileController.currentIndexUpdate];
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
                          onTap: (){
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
                          question!.question!,
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
                          itemCount:profileProvider.currentOptionsUpdate.length,
                          itemBuilder: (context, index) => TeamRoleBuildStatementUpdate(index: index),
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
                bool isLastQuestion = profileProvider.currentIndexUpdate ==
                    profileProvider.questionsUpdate.length - 1;
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
                      '${profileProvider.currentTotalUpdate}/10',
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
                 profileController.validateAndSubmitQuestionUpdate(profileProvider.currentIndexUpdate, context);
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
                  profileProvider.totalCountUpdate();
                  profileProvider.validateAnswersUpdate(context);
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
    );
  }


}
