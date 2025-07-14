import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/profile/controllers/profile_controller.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/images.dart';
import '../screens/tribe_meter_question_list_screen.dart';
import '../screens/update_tribe_meter_question_list_screen.dart';
import 'build_tribe_meter_barchart.dart';
import 'build_tribe_meter_list.dart';

class BuildTribeMeterMain extends StatelessWidget {
  const BuildTribeMeterMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileController>(
      builder: (context, profileProvider, child) {
        return  Card(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: (){
                    profileProvider.updateTribeMeterVisibleStatus();
                  },
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,child: Text(getTranslated("tribeometer", context)!,
                          style:
                          const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Roboto', color: ColorResources.color333333)
                      ),
                      ),
                      Image.asset(profileProvider.isTribeMeterVisible==true?Images.imgUpArrowRed:Images.imgDownArrowRed,width: 20,height: 20,)
                    ],
                  ),
                ),
                if(profileProvider.isTribeMeterVisible)
                  profileProvider.getTribeMeterReportList!.isNotEmpty?
                Column(
                  children: [
                    const SizedBox(height: 25),
                    buildTribeMeterBarChart(profileProvider),
                    const SizedBox(height: 12),
                    buildTribeMeterList(profileProvider),
                    InkWell(
                      onTap: () async {
                        if (profileProvider.isTribeMeterAnsDone) {
                          final result = await Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 500),
                              reverseTransitionDuration: Duration(milliseconds: 500),
                              pageBuilder: (context, animation, secondaryAnimation) => UpdateTribeMeterQuestionListScreen(),
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
                            profileProvider.viewOrgDashboardReportWithFilter(false);
                          }
                        }
                        else {
                          final result = await Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 500),
                              reverseTransitionDuration: Duration(milliseconds: 500),
                              pageBuilder: (context, animation, secondaryAnimation) => TribeMeterQuestionListScreen(),
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
                            profileProvider.viewOrgDashboardReportWithFilter(false);
                          }
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                        decoration: BoxDecoration(
                          color: ColorResources.mainColor,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: ColorResources.colorAAADC4,
                              blurRadius: 2.0,
                            ),
                          ],
                        ),
                        width: MediaQuery.sizeOf(context).width,
                        padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                        child: Text(
                          getTranslated("REDO_REVIEW_QUESTIONNAIRE", context)!,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ):
                  Center(child: Text(getTranslated("no_data_available", context)!)),


              ],
            ),
          ),
        );
      },
    );
  }
}
