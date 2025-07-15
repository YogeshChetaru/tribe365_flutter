import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../domain/models/view_unread_notification_list.dart';


class NotificationItem extends StatelessWidget {
  final ViewUnreadNotificationData? item;
  const NotificationItem({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => handleNotificationClick(context, item!),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              getIcon(item!),
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item!.title ?? "",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  if (item!.description != null && item!.description!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        item!.description!,
                        style:Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  if (item!.createdAt != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        item!.createdAt!,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  if (item!.lastMessage != null)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          launchUrl(Uri.parse(item!.lastMessage!));
                        },
                        child: const Text("Open Link"),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getIcon(ViewUnreadNotificationData item) {
    if (item.title?.contains("Checklist") == true || item.title == "To Do List") {
      return "assets/img_checklist_uncheck.png";
    } else if (item.notificationType == "actionList") {
      return "assets/img_action_image_noti.png";
    } else if (item.title?.contains("Reminder") == true) {
      return "assets/img_reminder.png";
    } else if (item.notificationType == "chat" ||
        item.notificationType?.contains("support") == true ||
        item.notificationType == "reflectionChat") {
      return "assets/img_chat_hollow_blue.png";
    } else if (item.title?.contains("Kudos Champion") == true) {
      return "assets/img_cup.png";
    } else if (item.notificationType?.contains("kudoAward") == true) {
      return "assets/img_awards_kudos_orange.png";
    } else if (item.notificationType?.contains("custom notification") == true) {
      return "assets/img_direct.png";
    } else if (item.notificationType?.contains("teamFeedback") == true) {
      return "assets/img_team_feedback.png";
    } else {
      return "assets/img_like_hollow_green.png";
    }
  }

  void handleNotificationClick(BuildContext context, ViewUnreadNotificationData item) {
    final nav = Navigator.of(context);

    if (item.notificationType == "actionList") {
      nav.pushNamed('/action-comment', arguments: item.id);
    } else if (item.notificationType == "chat") {
      nav.pushNamed('/history-detail', arguments: item.feedbackId);
    } else if (item.notificationType == "support") {
      nav.pushNamed('/support-detail', arguments: item.supportId);
    } else if (item.notificationType == "reflectionChat") {
      nav.pushNamed('/reflection-detail', arguments: item.reflectionId);
    } else if (item.notificationType == "teamFeedback") {
      nav.pushNamed('/team-feedback-question', arguments: {
        "userId": item.fromUserId,
        "date": item.createdAt,
        "teamId": item.teamFeedbackId,
      });
    } else if (item.title?.contains("Kudos Champion") == true) {
      if (item.multiple!) {
        showDialog(context: context, builder: (_) => MultipleChampionDialog(item));
      } else {
        showDialog(context: context, builder: (_) => SingleChampionDialog(item));
      }
    } else {
      handleChecklistOrTodoClick(context, item);
    }
  }

  void handleChecklistOrTodoClick(BuildContext context, ViewUnreadNotificationData item) {
    final desc = item.description ?? "";
    final nav = Navigator.of(context);

    if (desc.contains("evaluate yourself")) {
      nav.pushNamed('/dot-details', arguments: "noti");
    } else if (desc.contains("Personality Type Questionnaire")) {
      nav.pushNamed('/personality-type-list', arguments: "checklist");
    } else if (desc.contains("Team Role Questionnaire")) {
      nav.pushNamed('/cot-new-question', arguments: "checklist");
    } else if (desc.contains("Culture Structure Questionnaire")) {
      nav.pushNamed('/sot-questionlist', arguments: "checklist");
    } else if (desc.contains("Motivation Questionnaire")) {
      nav.pushNamed('/sot-motivation-question', arguments: "checklist");
    } else if (desc.contains("Tribeometer Survey")) {
      nav.pushNamed('/tribeometer-list', arguments: "checklist");
    } else if (desc.contains("Diagnostic Survey")) {
      nav.pushNamed('/diagnostics-list', arguments: "checklist");
    } else if (desc.contains("Award Green Bubbles")) {
      nav.pushNamed('/home', arguments: "noti");
    }
  }
}

class SingleChampionDialog extends StatelessWidget {
  final ViewUnreadNotificationData item;
  const SingleChampionDialog(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (item.mUserImage != null)
              ClipOval(
                child: Image.network(
                  item.mUserImage!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 12),
            Text(item.mUserName ?? "",
                style: Theme.of(context).textTheme.titleMedium),
            Text(item.mUserEmail ?? "",
                style: Theme.of(context).textTheme.labelSmall),
            const SizedBox(height: 8),
            Text(item.description ?? ""),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            )
          ],
        ),
      ),
    );
  }
}

class MultipleChampionDialog extends StatelessWidget {
  final ViewUnreadNotificationData item;
  const MultipleChampionDialog(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    final names = item.mUserName?.split(",") ?? [];
    final emails = item.mUserEmail?.split(",") ?? [];
    final images = item.mUserImage?.split(",") ?? [];

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: names.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: ClipOval(
                child: Image.network(
                  images[index],
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(names[index]),
              subtitle: Text(emails[index]),
              trailing: Text(item.description ?? ""),
            );
          },
        ),
      ),
    );
  }
}
