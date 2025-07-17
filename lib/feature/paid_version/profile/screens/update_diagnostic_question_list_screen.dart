import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/profile/widgets/build_diagnostic_completed_question.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../controllers/profile_controller.dart';

class UpdateDiagnosticQuestionListScreen extends StatefulWidget {

  const UpdateDiagnosticQuestionListScreen({super.key});

  @override
  UpdateDiagnosticQuestionListScreenState createState() => UpdateDiagnosticQuestionListScreenState();
}

class UpdateDiagnosticQuestionListScreenState extends State<UpdateDiagnosticQuestionListScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    loadAPI();
  }

  void loadAPI() {
    ProfileController controller = Provider.of<ProfileController>(context, listen: false);
    controller.viewDiagnosticCompletedQuestionListAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme
          .of(context)
          .primaryColor,
      body: SafeArea(
        child: Consumer<ProfileController>(builder: (context, profileProvider, _) {
          return Container(
            width: MediaQuery
                .sizeOf(context)
                .width,
            height: MediaQuery
                .sizeOf(context)
                .height,
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
                  width: MediaQuery
                      .sizeOf(context)
                      .width,
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
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
                              getTranslated("culture_structure", context)!,
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
                    width: MediaQuery
                        .sizeOf(context)
                        .width,
                    height: MediaQuery
                        .sizeOf(context)
                        .height,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme
                              .of(context)
                              .primaryColor,
                        ),
                      ),
                    ),
                  ),
                ) :
                profileProvider.viewDiagnosticCompletedQuestionList == null ?
                SizedBox() :
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      Expanded(
                        flex: 1, child: ListView.builder(
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: profileProvider.viewDiagnosticCompletedQuestionList!.length,
                        itemBuilder: (context, index) {
                          final question = profileProvider.viewDiagnosticCompletedQuestionList![index];
                          return BuildDiagnosticCompletedQuestion(
                            question: question,
                            index: index,
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
      bottomNavigationBar: SafeArea(child:
      Consumer<ProfileController>(builder: (context, profileProvider, _) {
        return profileProvider.isLoading == true
            ? SizedBox()
            : profileProvider.isLoadingBtn == true ?
        Container(
          height: 70,
          color: ColorResources.white,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme
                    .of(context)
                    .primaryColor,
              ),
            ),
          ),
        ) :
        Container(
          width: MediaQuery
              .sizeOf(context)
              .width,
          height: 70,
          color: ColorResources.white,
          child: InkWell(
            onTap: () {
              profileProvider.validateAndSubmitAnswersCompletedDiagnostic(context);
            },
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery
                  .sizeOf(context)
                  .width,
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

