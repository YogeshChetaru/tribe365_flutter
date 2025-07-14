import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/profile/controllers/profile_controller.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/images.dart';
import 'build_culture_grid.dart';
import 'build_titles_and_button.dart';

class BuildCultureStructureMain extends StatelessWidget {


  const BuildCultureStructureMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileController>(
      builder: (context, profileProvider, child) {
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
                    profileProvider.updateCultureStructureVisibleStatus();
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          getTranslated("culture_structure", context)!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Roboto',
                            color: ColorResources.color333333,
                          ),
                        ),
                      ),
                      Image.asset(
                        profileProvider.isCultureStructureVisible
                            ? Images.imgUpArrowRed
                            : Images.imgDownArrowRed,
                        width: 20,
                        height: 20,
                      )
                    ],
                  ),
                ),

                if (profileProvider.isCultureStructureVisible)
                  Column(
                    children: [
                      buildCultureGrid(profileProvider),
                      const SizedBox(height: 8),
                      buildTitlesAndButton(profileProvider, context),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
