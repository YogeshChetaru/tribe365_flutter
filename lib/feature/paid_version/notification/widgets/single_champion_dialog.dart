import 'package:flutter/material.dart';

import '../../../../localization/language_constrants.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/images.dart';
import '../domain/models/view_unread_notification_list.dart';

class SingleChampionDialog extends StatelessWidget {
  final ViewUnreadNotificationData item;

  const SingleChampionDialog(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: ColorResources.mainColor, // Replace with your `dialog_bg_header`
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(
                children: [
                  SizedBox(width: 20,height: 20,),
                  Expanded(flex: 1,
                    child: Column(
                      children:  [
                        Text(
                          "${getTranslated("congratulations", context)}!",
                          style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.w600),
                        ),
                        Text(
                          getTranslated("kudos_champion", context)!,
                          style: TextStyle(color: Colors.white, fontSize: 13,fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, size: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      ClipOval(
                        child: Image.network(
                          item.mUserImage ?? '',
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(Icons.person, size: 90),
                        ),
                      ),
                      Positioned(
                        top: -8,
                        left: -8,
                        child: Image.asset(
                          Images.icCrown,
                          width: 40,
                          height: 30,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item.mUserName ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    item.mUserEmail ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item.description ?? '${getTranslated("you_have_earned_the_highest_kudos_this_month_well_done", context)}!',
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorResources.mainColor, // replace with `@drawable/roundedbutton` equivalent
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      item.description ?? '',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}