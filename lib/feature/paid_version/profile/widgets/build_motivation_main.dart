import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/profile/controllers/profile_controller.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/images.dart';
import 'build_motivation_barchart.dart';
import 'build_motivation_list.dart';

class BuildMotivationMain extends StatelessWidget {
  final ProfileController profileProvider;

  const BuildMotivationMain({super.key, required this.profileProvider});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileController>(
      builder: (context, profileProvider, child) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    profileProvider.updateMotivationVisibleStatus();
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          getTranslated("motivation", context)!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Roboto',
                            color: ColorResources.color333333,
                          ),
                        ),
                      ),
                      Image.asset(
                        profileProvider.isMotivationVisible
                            ? Images.imgUpArrowRed
                            : Images.imgDownArrowRed,
                        width: 20,
                        height: 20,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                if(profileProvider.isMotivationVisible)
                  profileProvider.viewSOTMotivationReportList!.isNotEmpty?
                Column(
                  children: [
                    const SizedBox(height: 10),
                    buildMotivationBarChart(profileProvider),
                    const SizedBox(height: 12),
                    buildMotivationList(profileProvider),
                    const SizedBox(height: 10),
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
