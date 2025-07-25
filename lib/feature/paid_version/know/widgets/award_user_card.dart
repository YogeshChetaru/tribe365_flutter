import 'package:flutter/material.dart';

import '../domain/models/view_kudos_award_response.dart';

class AwardUserCard extends StatelessWidget {
  final ViewKudosAwardData user;
  const AwardUserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.userImage!),
          radius: 18,
        ),
        title: Text(
          user.userName!,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}