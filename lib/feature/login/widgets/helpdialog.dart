import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/app_constants.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/dimensions.dart';
import 'package:url_launcher/url_launcher.dart';



class HelpDialog extends StatelessWidget {
  const HelpDialog({super.key});

  @override
  Widget build(BuildContext context) {

    Future<void> launchURL() async {
      final Uri uri = Uri.parse(AppConstants.webSite);
      try {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } catch (e) {
        debugPrint('Error launching URL: $e');
      }
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              getTranslated("registering", context)!,
              style: TextStyle(
                fontSize: Dimensions.sp16,
                color: ColorResources.mainColor, // Replace with ColorResources.mainColor
                fontWeight: FontWeight.w600,
                fontFamily: 'Roboto',
              ),
            ),
            const SizedBox(height: 16),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style:  TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: Dimensions.sp12,
                  height: 1.5,
                  color: ColorResources.color333333,
                ),
                children: [
                   TextSpan(
                    text: '${getTranslated("organisations_should_use_Tribe365_to_get_actionable_data_around_the_people_in_the_organisation", context)!}\n\n',
                  ),
                   TextSpan(
                    text: '${getTranslated("logins_are_issued_after_organisations_have", context)} ',
                  ),
                   TextSpan(
                    text: '${getTranslated("signed_up_via", context)} ',
                  ),
                  TextSpan(
                    text: AppConstants.tribe365,
                    style: const TextStyle(
                      color: Color(0xFF0066CC),
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = launchURL,
                  ),
                  TextSpan(
                    text: '\n${getTranslated("organisations_can_range_from_1_10000_staff", context)}.',
                  ),
                  TextSpan(
                    text: '\n\n${getTranslated("by_using_tribe365_staff_will_be_able_to_interact_with_the_companies_beliefs_values_vision_mission_and_focus_and_understand_what_it_really_means_to_be_part_of_you_tribe_every_second_of_every_day", context)}.',
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
