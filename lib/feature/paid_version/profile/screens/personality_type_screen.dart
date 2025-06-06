import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/profile/widgets/buildquestion.dart';
import 'package:tribe365_new/main.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../../../../common/basewidget/custom_header_back_widget.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/dimensions.dart';
import '../controllers/profile_controller.dart';

class PersonalityTypeScreen extends StatefulWidget {
  const PersonalityTypeScreen({super.key});

  @override
  PersonalityTypeScreenState createState() => PersonalityTypeScreenState();
}

class PersonalityTypeScreenState extends State<PersonalityTypeScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  ProfileController profileController = Provider.of<ProfileController>(Get.context!,listen: false);

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
                  title: getTranslated("personality_type_questions", context)!,
                ),
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    itemCount: profileProvider.questions.length,
                    itemBuilder: (context, index) => BuildQuestion(index: index),
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
              handleSubmit();
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

  void handleSubmit() {
   profileController.selectedAnswers.forEach((index, answer) {
      debugPrint('Q${index + 1}: $answer');
    });
  }
}

