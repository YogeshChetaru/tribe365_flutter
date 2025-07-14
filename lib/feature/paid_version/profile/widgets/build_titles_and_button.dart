import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/profile/screens/sot_questionlist_screen.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/color_resources.dart';
import '../controllers/profile_controller.dart';
import '../screens/sot_questionlist_update_screen.dart';

Widget buildTitlesAndButton(ProfileController profileProvider, BuildContext context) {
  void loadAPI() {
    ProfileController controller = Provider.of<ProfileController>(context, listen: false);
    controller.viewOrgDashboardReportWithFilter(false);
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Text(
          getTranslated("organisation_culture_structure", context)!,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ),
      const SizedBox(height: 20),
      if (profileProvider.sotSummaries.isNotEmpty)
        ...profileProvider.sotSummaries.expand((summary) => [
              const SizedBox(height: 8),
              Text(
                summary.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              ...summary.summaries.map(
                (s) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("• ", style: TextStyle(fontSize: 14)),
                      Expanded(
                        child: Text(
                          s,
                          style: const TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ])
      else
        Text(
          getTranslated("summary_of_organisation_culture_structure", context)!,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
          textAlign: TextAlign.center,
        ),
      const SizedBox(height: 20),
      GestureDetector(
        onTap: () async {
          if (profileProvider.isUserFilledAnswer) {
            final result = await Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                reverseTransitionDuration: Duration(milliseconds: 500),
                pageBuilder: (context, animation, secondaryAnimation) => SotQuestionListUpdateScreen(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0); // from right
                  const end = Offset.zero;
                  const curve = Curves.easeInOut;
                  final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                  final offsetAnimation = animation.drive(tween);
                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ),
            );
            if (result == true) {
              loadAPI();
            }
          } else {
            final result = await Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                reverseTransitionDuration: Duration(milliseconds: 500),
                pageBuilder: (context, animation, secondaryAnimation) => SotQuestionListScreen(
                  checklistMain: "checklist",
                ),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0); // from right
                  const end = Offset.zero;
                  const curve = Curves.easeInOut;
                  final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                  final offsetAnimation = animation.drive(tween);
                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ),
            );
            if (result == true) {
              loadAPI();
            }
          }
        },
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 15),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          decoration: BoxDecoration(
            color: ColorResources.mainColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: ColorResources.mainColor.withOpacity(0.3),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          width: MediaQuery.sizeOf(context).width,
          child: Text(
            getTranslated("REDO_REVIEW_QUESTIONNAIRE", context)!,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ],
  );
}
