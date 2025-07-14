import 'package:flutter/material.dart';
import 'package:tribe365_new/feature/paid_version/profile/controllers/profile_controller.dart';
import 'package:tribe365_new/feature/paid_version/profile/widgets/role_pair_row.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/images.dart';

class BuildTeamRoleMain extends StatelessWidget {
  final ProfileController profileProvider;

  const BuildTeamRoleMain({super.key, required this.profileProvider});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                profileProvider.updateTeamRoleStatus();
              },
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(getTranslated("team_role", context)!,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Roboto', color: ColorResources.color333333)),
                  ),
                  Image.asset(
                    profileProvider.isTeamRoleVisible == true ? Images.imgUpArrowRed : Images.imgDownArrowRed,
                    width: 20,
                    height: 20,
                  )
                ],
              ),
            ),

            if (profileProvider.isTeamRoleVisible == true)
              profileProvider.viewTeamRoles.isEmpty?
              Center(child: Text(getTranslated("no_data_available", context)!)):
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  // ORGANISATIONS
                  RolePairRow(
                    leftLabel: "Shaper",
                    leftValue: profileProvider.getTeamRolePercentage("shaper"),
                    rightLabel: "Coordinator",
                    rightValue: profileProvider.getTeamRolePercentage("coordinator"),
                  ),

                  // CONTROLLERS
                  RolePairRow(
                    leftLabel: "Implementer",
                    leftValue: profileProvider.getTeamRolePercentage("implementer"),
                    rightLabel: "Completer",
                    rightValue: profileProvider.getTeamRolePercentage("completerFinisher"),
                  ),

                  // ADVISERS
                  RolePairRow(
                    leftLabel: "Monitor Evaluator",
                    leftValue: profileProvider.getTeamRolePercentage("monitorEvaluator"),
                    rightLabel: "Team Worker",
                    rightValue: profileProvider.getTeamRolePercentage("teamworker"),
                  ),

                  // EXPLORERS
                  RolePairRow(
                    leftLabel: "Plant",
                    leftValue: profileProvider.getTeamRolePercentage("plant"),
                    rightLabel: "Resource Investigator",
                    rightValue: profileProvider.getTeamRolePercentage("resourceInvestigator"),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
