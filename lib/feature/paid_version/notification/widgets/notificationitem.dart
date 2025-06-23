import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../utill/images.dart';
import '../../../../utill/utility.dart';
import '../domain/models/view_unread_notification_list.dart';

class NotificationItem extends StatelessWidget {
 final ViewUnreadNotificationData? item;
  const NotificationItem({super.key,this.item});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      enabled: false,
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) {
              // Edit / Delete logic here
            },
            icon: Icons.edit,
            backgroundColor: ColorResources.mainColor,
            label: 'Edit',
          ),
        ],
      ),
      child: ListTile(
        leading: Image.asset(getIcon(item!),width: 30,height: 30,),
        title: Text(item!.title!),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item!.description!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(item!.description!),
              ),
           /* if (item!.notificationType! == "actionList")
              Text("Due Date: ${Utility.convertDataIntoddMMMyyyyhhmma(item!.createdAt!)}")
            else
              Text(Utility.convertDataIntoddMMMyyyyhhmma(item!.createdAt!)),*/
          ],
        ),
        trailing: item!.lastMessage != null
            ? TextButton(
          onPressed: () {
            launchUrl(Uri.parse(item!.lastMessage!));
          },
          child: const Text("Open Link"),
        )
            : null,
        onTap: () => handleNotificationClick(context, item!),
      ),
    );
  }

 String getIcon(ViewUnreadNotificationData item) {
   if (item.title!.contains("Checklist") || item.title == "To Do List") {
     return Images.imgChecklistUncheck;
   } else if (item.notificationType == "actionList") {
     return Images.imgActionImageNoti;
   } else if (item.title!.contains("Reminder")) {
     return Images.imgReminder;
   } else if (item.notificationType == "chat" || item.notificationType!.contains("support") || item.notificationType == "reflectionChat") {
     return Images.imgChatHollowBlue;
   } else if (item.title!.contains("Kudos Champion")) {
     return Images.imgCup;
   } else if (item.notificationType!.contains("kudoAward")) {
     return Images.imgAwardsKudosOrange;
   } else if (item.notificationType!.contains("custom notification")) {
     return Images.imgDirect;
   } else if (item.notificationType!.contains("teamFeedback")) {
     return Images.imgTeamFeedback;
   } else {
     return Images.imgLikeHollowGreen;
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
   } else if (item.title!.contains("Kudos Champion")) {
     /*if (item.multiple) {
       showDialog(context: context, builder: (_) => MultipleChampionDialog(item));
     } else {
       showDialog(context: context, builder: (_) => SingleChampionDialog(item));
     }*/
   } else {
     handleChecklistOrTodoClick(context, item);
   }
 }

 void handleChecklistOrTodoClick(BuildContext context, ViewUnreadNotificationData item) {
   final desc = item.description!;
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
   } else {
     // fallback
   }
 }
}

