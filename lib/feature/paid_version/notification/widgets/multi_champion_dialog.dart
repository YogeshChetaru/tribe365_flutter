import 'package:flutter/material.dart';

import '../../../../localization/language_constrants.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/images.dart';
import '../domain/models/view_unread_notification_list.dart';

class MultiChampionDialog extends StatelessWidget {
  final ViewUnreadNotificationData item;
  const MultiChampionDialog({super.key, required this.item});

  List<ViewUnreadNotificationData> _parseUsers() {
    final names = item.mUserName?.split(',') ?? [];
    final emails = item.mUserEmail?.split(',') ?? [];
    final images = item.mUserImage?.split(',') ?? [];
    final List<ViewUnreadNotificationData> list = [];

    if (names.isEmpty || (names.length == 1 && names[0].trim().isEmpty)) {
      // Provide fallback demo data
      return [
        ViewUnreadNotificationData(
          mUserName: 'Demo User 1',
          mUserEmail: 'demo1@mail.com',
          mUserImage: 'https://i.pravatar.cc/150?img=10',
        ),
        ViewUnreadNotificationData(
          mUserName: 'Demo User 2',
          mUserEmail: 'demo2@mail.com',
          mUserImage: 'https://i.pravatar.cc/150?img=11',
        ),
        ViewUnreadNotificationData(
          mUserName: 'Demo User 3',
          mUserEmail: 'demo3@mail.com',
          mUserImage: 'https://i.pravatar.cc/150?img=12',
        ),
      ];
    }

    for (int i = 0; i < names.length; i++) {
      list.add(ViewUnreadNotificationData(
        mUserName: names[i],
        mUserEmail: i < emails.length ? emails[i] : '',
        mUserImage: i < images.length ? images[i] : '',
        description: item.description,
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final users = _parseUsers();

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              decoration: BoxDecoration(
                color: ColorResources.mainColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(8),
                    topRight: Radius.circular(8)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 32),
                  Column(
                    children:  [
                      Text("${getTranslated("congratulations", context)}!", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(getTranslated("kudos_champion", context)!, style: TextStyle(color: Colors.white, fontSize: 14))
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.close, size: 20, color: Colors.black),
                  )
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Text(
                getTranslated("you_have_earned_the_highest_kudos_this_month_well_done", context)!,
                style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: ListView.builder(
                itemCount: users.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              ClipOval(
                                child: Image.network(
                                  user.mUserImage ?? '',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, size: 50),
                                ),
                              ),
                              Positioned(
                                top: -4,
                                left: -4,
                                child: Image.asset(
                                  Images.icCrown,
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.mUserName ?? '',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  user.mUserEmail ?? '',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            user.description ?? '',
                            style: const TextStyle(color: ColorResources.mainColor),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}