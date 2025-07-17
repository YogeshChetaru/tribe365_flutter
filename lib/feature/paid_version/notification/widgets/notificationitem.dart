import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/home/screens/dot_details_screen.dart';
import 'package:tribe365_new/feature/paid_version/notification/controllers/notification_controller.dart';
import 'package:tribe365_new/feature/paid_version/notification/screens/notification_kudos_awards_details_screen.dart';
import 'package:tribe365_new/feature/paid_version/notification/screens/notification_team_feedback_screen.dart';
import 'package:tribe365_new/feature/paid_version/notification/screens/notification_webpage_screen.dart';
import 'package:tribe365_new/feature/paid_version/notification/widgets/single_champion_dialog.dart';
import 'package:tribe365_new/feature/paid_version/profile/controllers/profile_controller.dart';
import 'package:tribe365_new/feature/paid_version/profile/screens/diagnostic_question_list_screen.dart';
import 'package:tribe365_new/feature/paid_version/profile/screens/motivation_questions_screen.dart';
import 'package:tribe365_new/feature/paid_version/profile/screens/personality_type_screen.dart';
import 'package:tribe365_new/feature/paid_version/profile/screens/profile_actions_comments_screen.dart';
import 'package:tribe365_new/feature/paid_version/profile/screens/sot_questionlist_screen.dart';
import 'package:tribe365_new/feature/paid_version/profile/screens/team_role_screen.dart';
import 'package:tribe365_new/feature/paid_version/profile/screens/tribe_meter_question_list_screen.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/custom_route.dart';
import 'package:tribe365_new/utill/images.dart';
import '../../../../utill/color_resources.dart';
import '../domain/models/view_unread_notification_list.dart';
import 'dialog_desc_full.dart';
import 'kudos_filter_dialog.dart';
import 'multi_champion_dialog.dart';

class NotificationItem extends StatelessWidget {
  final ViewUnreadNotificationData? item;

  const NotificationItem({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => handleNotificationClick(context, item!),
      child: Container(
        margin: EdgeInsets.fromLTRB(15, 5, 15, 10),
        decoration: BoxDecoration(
            color: ColorResources.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: ColorResources.colorAAADC4,
                blurRadius: 5.0,
              ),
            ]),
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
                    style: TextStyle(color: ColorResources.color333333, fontSize: 14, fontFamily: 'Roboto', fontWeight: FontWeight.w500),
                  ),
                  if (item!.description != null && item!.description!.isNotEmpty)
                    Text(
                      item!.description!,
                      style: TextStyle(fontWeight: FontWeight.w400, color: ColorResources.color333333, fontSize: 12, fontFamily: 'Roboto'),
                    ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      if (item!.lastMessage != null && item!.lastMessage!.isNotEmpty)
                        InkWell(
                          onTap: () {
                            routePush(context, NotificationWebpageScreen(url: item!.lastMessage!));
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(12, 5, 12, 5),
                            decoration: BoxDecoration(
                              color: ColorResources.mainColor,
                              border: Border.all(color: ColorResources.mainColor, width: 0.5),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(7),
                                  bottomLeft: Radius.circular(7),
                                  topRight: Radius.circular(7),
                                  bottomRight: Radius.circular(7)),
                            ),
                            child: Text(
                              getTranslated("open_link", context)!,
                              style: TextStyle(color: ColorResources.white, fontSize: 10, fontWeight: FontWeight.w500, fontFamily: "Roboto"),
                            ),
                          ),
                        ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerRight,
                          width: MediaQuery.sizeOf(context).width,
                          child: Text(
                            item!.createdAt!,
                            style: TextStyle(fontFamily: 'Roboto', fontSize: 12, color: ColorResources.color333333, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
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
      return Images.imgChecklistUncheck;
    } else if (item.notificationType == "actionList") {
      return Images.imgActionImageNoti;
    } else if (item.title?.contains("Reminder") == true) {
      return Images.imgReminder;
    } else if (item.notificationType == "chat" || item.notificationType?.contains("support") == true || item.notificationType == "reflectionChat") {
      return Images.imgChatHollowBlue;
    } else if (item.title?.contains("Kudos Champion") == true) {
      return Images.imgCup;
    } else if (item.notificationType?.contains("kudoAward") == true) {
      return Images.imgAwardsKudosOrange;
    } else if (item.notificationType?.contains("custom notification") == true) {
      return Images.imgDirect;
    } else if (item.notificationType?.contains("teamFeedback") == true) {
      return Images.imgTeamFeedback;
    } else {
      return Images.imgLikeHollowGreen;
    }
  }

  void handleNotificationClick(BuildContext context, ViewUnreadNotificationData item) {
    final nav = Navigator.of(context);

    if (item.notificationType == "actionList") {
      routePush(context, ProfileActionsCommentsScreen(actionId: item.id.toString()));
    } else if (item.notificationType == "chat") {
      nav.pushNamed('/history-detail', arguments: item.feedbackId);
    } else if (item.notificationType == "support") {
      nav.pushNamed('/support-detail', arguments: item.supportId);
    } else if (item.notificationType == "reflectionChat") {
      nav.pushNamed('/reflection-detail', arguments: item.reflectionId);
    } else if (item.notificationType == "teamFeedback") {
      routePush(
          context,
          NotificationTeamFeedbackScreen(
            userId: item.fromUserId!,
            date: item.createdAt!,
            teamId: item.teamFeedbackId!,
          ));
    } else if (item.title?.contains("Kudos Champion") == true) {
      if (item.multiple!) {
        showMultiChampionDialog(context, item);
      } else {
        showChampionDialog(context, item);
      }
    } else if (item.notificationType == "kudoAward") {
      ProfileController controller = Provider.of<ProfileController>(context, listen: false);
      NotificationController noController = Provider.of<NotificationController>(context, listen: false);

      if (controller.userProfileData!.role == 3) {
        routePush(
            context,
            NotificationKudosAwardsDetailsScreen(
              kudosId: "0",
              kudosName: "Amazing Awards",
            ));
      } else {
        //kudos popup open
        showDialog(
          context: context,
          builder: (_) => KudosFilterDialog(
            kudosList: noController.totalKudosList!,
            amazingValueKey: noController.amazingValueKey,
            todayAwardCount: noController.todayAwardCount,
            yesterdayAwardCount: noController.yesterdayAwardCount,
            thisWeekAwardCount: noController.thisWeekAwardCount,
            lastWeekAwardCount: noController.lastWeekAwardCount,
            thisMonthAwardCount: noController.thisMonthAwardCount,
            lastMonthAwardCount: noController.lastMonthAwardCount,
            totalAwardCount: noController.totalAwardCount,
          ),
        );
      }
    } else if (item.notificationType == "custom notification") {
      showDiscDialog(context, item);
    } else {
      handleChecklistOrTodoClick(context, item);
    }
  }

  void handleChecklistOrTodoClick(BuildContext context, ViewUnreadNotificationData item) {
    final desc = item.description ?? "";

    if (desc.contains(getTranslated("evaluate_yourself_against_tribe_values", context)!)) {
      routePush(context, DotDetailsScreen());
    } else if (desc.contains(getTranslated("complete_personality_type_questionnaire", context)!)) {
      routePush(context, PersonalityTypeScreen());
    } else if (desc.contains(getTranslated("complete_team_role_questionnaire", context)!)) {
      routePush(context, TeamRoleScreen());
    } else if (desc.contains(getTranslated("complete_culture_structure_questionnaire", context)!)) {
      routePush(context, SotQuestionListScreen(checklistMain: "checklist"));
    } else if (desc.contains(getTranslated("complete_motivation_questionnaire", context)!)) {
      routePush(context, MotivationQuestionsScreen());
    } else if (desc.contains(getTranslated("complete_tribeometer_survey", context)!)) {
      routePush(context, TribeMeterQuestionListScreen());
    } else if (desc.contains(getTranslated("complete_diagnostic_survey", context)!)) {
      routePush(context, DiagnosticQuestionListScreen());
    } else if (desc.contains(getTranslated("award_kudos_to_your_colleagues_daily", context)!)) {
      Navigator.pop(context, true);
    }
  }

  void showDiscDialog(BuildContext context, ViewUnreadNotificationData item) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(), // dismiss if background tapped
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              child: DialogDescFull(notiList: item),
            ),
          ),
        );
      },
    );
  }

  void showChampionDialog(BuildContext context, ViewUnreadNotificationData item) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => SingleChampionDialog(item),
    );
  }
}

/*class MultipleChampionDialog extends StatelessWidget {
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
}*/

void showMultiChampionDialog(BuildContext context, ViewUnreadNotificationData item) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => MultiChampionDialog(item: item),
  );
}
