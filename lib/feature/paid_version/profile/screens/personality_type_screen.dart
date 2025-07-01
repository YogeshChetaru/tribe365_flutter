import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/profile/widgets/buildquestion.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../main.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../controllers/profile_controller.dart';
class PersonalityTypeScreen extends StatefulWidget {
  const PersonalityTypeScreen({super.key});

  @override
  PersonalityTypeScreenState createState() => PersonalityTypeScreenState();
}

class PersonalityTypeScreenState extends State<PersonalityTypeScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    loadAPI();
  }

  void loadAPI() {
    ProfileController controller = Provider.of<ProfileController>(context, listen: false);
    String userData = controller.getUserPersonalityTypeData();
    controller.viewPersonalityTypeQuestionList(userData);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
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
                            onTap:() async => await _onBackPressed(context),
                            child: Image.asset(
                              Images.imgCircleBackRed,
                              width: 24,
                              height: 24,
                            )),
                        Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                getTranslated("personality_type_questions", context)!,
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
                            itemCount:
                                profileProvider.personalityQuestionList!.length,
                            itemBuilder: (context, index) => BuildQuestion(
                              itemData:
                                  profileProvider.personalityQuestionList![index],
                              index: index,
                            ),
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
              :profileProvider.isLoadingBtn==true?
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
          )
          :
          Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: 70,
                  color: ColorResources.white,
                  child: InkWell(
                    onTap: () {
                      profileProvider.validateAndSubmitPersonalityType(context);
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
      ),
    );
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    final provider = Provider.of<ProfileController>(context, listen: false);
    final count = provider.getAnsweredCount();

    if (count > 0) {
      final shouldSave = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(
            getTranslated("do_you_want_to_save_the_answers", context)!,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, true); // Yes
              },
              child: Text(
                getTranslated("yes", context)!,
                style: TextStyle(color: ColorResources.mainColor),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, false); // No
              },
              child: Text(
                getTranslated("no", context)!,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      );

      if (shouldSave == true) {
        await provider.saveUserPersonalityTypeData();
        Navigator.of(Get.context!).pop();
        return true; // allow back navigation
      } else {
        Navigator.of(Get.context!).pop();
        return true; // allow back navigation without saving
      }
    } else {
      Navigator.of(context).pop();
      return true; // nothing to save, allow back navigation
    }
  }

}
