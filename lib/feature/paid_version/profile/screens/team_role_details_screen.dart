import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/profile/screens/team_role_cate_desc_screen.dart';
import 'package:tribe365_new/feature/paid_version/profile/screens/team_role_update_screen.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/custom_route.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../controllers/profile_controller.dart';

class TeamRoleDetailsScreen extends StatefulWidget {
  final String teamRoleName;

  const TeamRoleDetailsScreen({super.key, required this.teamRoleName});

  @override
  TeamRoleDetailsScreenState createState() => TeamRoleDetailsScreenState();
}

class TeamRoleDetailsScreenState extends State<TeamRoleDetailsScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    loadAPI();
  }
  void loadAPI() {
    ProfileController controller =
    Provider.of<ProfileController>(context, listen: false);
    controller.viewCOTindividualSummary();
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
                            Navigator.of(context).pop(true);
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
                      InkWell(
                          onTap: () {
                            routePush(
                                context,
                                TeamRoleCateDescScreen(
                                    teamRoleName: widget.teamRoleName));
                          },
                          child: Image.asset(
                            Images.imgCotDescriptionRed,
                            width: 24,
                            height: 24,
                          )),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: profileProvider.isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            Container(
                                margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                                child: preferenceGrid()),

                            profileProvider.getCotQuestionData == null
                                ? SizedBox()
                                : ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.all(15),
                                    itemCount: profileProvider.rolePairs.length,
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(height: 12),
                                    itemBuilder: (context, index) {
                                      final leftKey =
                                          profileProvider.rolePairs[index][0];
                                      final rightKey =
                                          profileProvider.rolePairs[index][1];

                                      final leftScore = profileProvider
                                          .getCotQuestionData!.scores[leftKey]
                                          .toString();
                                      final rightScore = profileProvider
                                          .getCotQuestionData!.scores[rightKey]
                                          .toString();

                                      final leftTitle = profileProvider
                                              .getCotQuestionData!
                                              .mappers[leftKey] ??
                                          leftKey;
                                      final rightTitle = profileProvider
                                              .getCotQuestionData!
                                              .mappers[rightKey] ??
                                          rightKey;

                                      final leftColor =
                                          getRoleColor(leftScore).background;
                                      final rightColor =
                                          getRoleColor(rightScore).background;

                                      return roleScoreCard(
                                        leftTitle: leftTitle,
                                        leftScore: leftScore,
                                        leftBoxText: leftScore,
                                        leftBoxColor: leftColor,
                                        rightTitle: rightTitle,
                                        rightScore: rightScore,
                                        rightBoxText: rightScore,
                                        rightBoxColor: rightColor,
                                      );
                                    },
                                  ),
                            InkWell(
                              onTap: (){
                                routePush(context, TeamRoleUpdateScreen());
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(15, 20, 15, 15),
                                width: MediaQuery.sizeOf(context).width,
                                padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                                decoration: BoxDecoration(
                                  color: ColorResources.mainColor,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                ),
                                child: Text(
                                  getTranslated("REDO_REVIEW_QUESTIONNAIRE", context)!,
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
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget preferenceGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: preferenceItem(
                  color: ColorResources.color6ba74b,
                  label: '1st Preference',
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: preferenceItem(
                  color: ColorResources.colorfdfd02,
                  label: '2nd Preference',
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: preferenceItem(
                  color: ColorResources.color0001fb,
                  label: '3rd Preference',
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: preferenceItem(
                  color: ColorResources.colorfc9802,
                  label: 'Reserve Role',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget preferenceItem({required Color color, required String label}) {
    return Row(
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontFamily: 'Roboto',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget roleScoreCard({
    required String leftTitle,
    required String leftScore,
    required String leftBoxText,
    required Color leftBoxColor,
    required String rightTitle,
    required String rightScore,
    required String rightBoxText,
    required Color rightBoxColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200, // Similar to @drawable/edittextback
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          // Left Block: Shaper
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Shaper Text + Score
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        leftTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            "Score: ",
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'Roboto',
                            ),
                          ),
                          Text(
                            leftScore,
                            style: const TextStyle(
                              fontSize: 10,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Colored Circle with Text
                Container(
                  width: 22,
                  height: 22,
                  margin: const EdgeInsets.only(right: 8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: leftBoxColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    leftBoxText,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Vertical Divider
          Container(
            width: 1,
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: Colors.grey,
          ),

          // Right Block: Coordinator
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Coordinator Text + Score
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rightTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            "Score: ",
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'Roboto',
                            ),
                          ),
                          Text(
                            rightScore,
                            style: const TextStyle(
                              fontSize: 10,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Colored Circle with Text
                Container(
                  width: 22,
                  height: 22,
                  margin: const EdgeInsets.only(right: 8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: rightBoxColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    rightBoxText,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}

/// Color helper
class RoleColor {
  final Color background;
  final Color text;

  const RoleColor({required this.background, required this.text});
}

RoleColor getRoleColor(String score) {
  switch (score) {
    case "0":
      return const RoleColor(background: Colors.white, text: Colors.black);
    case "1":
      return const RoleColor(background: ColorResources.color6ba74b, text: Colors.white);
    case "2":
      return const RoleColor(background: ColorResources.colorfdfd02, text: Colors.black);
    case "3":
      return const RoleColor(background: ColorResources.color0001fb, text: Colors.white);
    default:
      return const RoleColor(background: ColorResources.colorfc9802, text: Colors.white);
  }
}
