import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../main.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../controllers/profile_controller.dart';

class UpdateTribeMeterQuestionListScreen extends StatefulWidget {

  const UpdateTribeMeterQuestionListScreen({super.key});

  @override
  UpdateTribeMeterQuestionListScreenState createState() => UpdateTribeMeterQuestionListScreenState();
}

class UpdateTribeMeterQuestionListScreenState extends State<UpdateTribeMeterQuestionListScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    loadAPI();
  }

  void loadAPI() {
    ProfileController controller = Provider.of<ProfileController>(context, listen: false);
    controller.viewTribeMeterQuestionCompleteListAPI();
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
                              getTranslated("tribeometer", context)!,
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
                profileProvider.viewTribeMeterQuestionCompleteList == null ?
                SizedBox() :
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      Expanded(
                        flex: 1, child: ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount:profileProvider.viewTribeMeterQuestionCompleteList!.length,
                        itemBuilder: (context, index) {
                          final question = profileProvider.viewTribeMeterQuestionCompleteList![index];
                          return Container(
                            padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
                            margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade300),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                )
                              ],
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${index + 1}. ${question.question ?? ""}',style:
                                TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),),
                                SizedBox(height: 10,),
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 2.5,
                                  ),
                                  itemCount: question.options?.length ?? 0,
                                  itemBuilder: (context, optIndex) {
                                    final option = question.options![optIndex];
                                    return GestureDetector(
                                      onTap: () {
                                       profileProvider.selectAnswerForQuestionComplete(questionIndex: index, optionIndex: optIndex);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(4),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: option.isChecked! ?
                                          ColorResources.mainColor : Colors.grey[300],
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Center(
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            option.optionName ?? '',
                                            style: TextStyle(
                                              color: option.isChecked! ?
                                              Colors.white : Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
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
              profileProvider.validateAndSubmitAnswersCompleteTribeMeter(context);
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

