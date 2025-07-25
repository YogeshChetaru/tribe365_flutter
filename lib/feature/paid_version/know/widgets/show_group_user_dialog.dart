import 'package:flutter/material.dart';

import '../../../../utill/color_resources.dart';
import '../domain/models/view_kudos_award_response.dart';
import 'award_user_card.dart';

void showGroupUserDialog(
    BuildContext context, String awardValue, List<ViewKudosAwardData> userList) {
  if (userList.isEmpty) return;

  userList.sort((a, b) => a.userName!.compareTo(b.userName!));

  showDialog(
    context: context,
    builder: (_) => Dialog(
      backgroundColor: Colors.transparent,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                awardValue,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorResources.mainColor,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                userList.first.awardDescription!,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                itemCount: userList.length,
                itemBuilder: (_, index) {
                  final user = userList[index];
                  return AwardUserCard(user: user);
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );
}