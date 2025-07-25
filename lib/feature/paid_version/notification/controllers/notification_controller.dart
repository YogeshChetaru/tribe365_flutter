import 'package:flutter/material.dart';
import 'package:tribe365_new/helper/api_checker.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import '../../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../../data/model/api_response.dart';
import '../../../../main.dart';
import '../domain/models/view_home_kudos_count_response.dart';
import '../domain/models/view_individual_questionnaire_response.dart';
import '../domain/models/view_kudos_award_detail_response.dart';
import '../domain/models/view_notification_kudos_award_detail_response.dart';
import '../domain/models/view_team_feedback_user_answer_status_response.dart';
import '../domain/models/view_unread_notification_list.dart';
import '../domain/services/notification_service_interface.dart';

class NotificationController extends ChangeNotifier {
  final NotificationServiceInterface? notificationServiceInterface;

  NotificationController({required this.notificationServiceInterface});

  bool _isLoading = true;

  bool get isLoading => _isLoading;
  bool _isLoadingBtn = false;

  bool get isLoadingBtn => _isLoadingBtn;

  bool isNotificationType = true;
  bool archiveStatus = false;
  List<ViewUnreadNotificationData> archivedList = [];

  void updateIsNotificationType(String s) {
    if (s == 'notification') {
      isNotificationType = true;
    } else {
      isNotificationType = false;
    }
    notifyListeners();
  }

  List<ViewUnreadNotificationData> listUnread = [];
  int currentPageUR = 1;
  int unreadTotalPages = 1;
  bool isLastPageUR = false;
  bool archiveAll = false;

  ViewHomeKudosCountData kudosResponse = ViewHomeKudosCountData();
  List<ViewHomeKudosCountBelief>? totalKudosList;

  String amazingValueKey = "";
  int todayAwardCount = 0;
  int yesterdayAwardCount = 0;
  int thisWeekAwardCount = 0;
  int lastWeekAwardCount = 0;
  int thisMonthAwardCount = 0;
  int lastMonthAwardCount = 0;
  int totalAwardCount = 0;

  final List<String> titleList = [
    "Total",
    "Today",
    "Yesterday",
    "Last week",
    "This week",
    "Last month",
    "This month",
  ];

  final List<String> titleTopList = [
    "Kudos Values",
    "Kudos Awards",
  ];

  int currentTitleIndex = 0;
  int currentTopTitleIndex = 0;

  String amazingValue = "0";

  bool get isKudosAwards => titleTopList[currentTopTitleIndex] == "Kudos Awards";

  String get currentTitle => titleList[currentTitleIndex];

  String get currentTopTitle => titleTopList[currentTopTitleIndex];
  List<ViewKudosAwardDetailData>? viewKudosAwardDetailList;
  String teamTitle = "";
  bool teamQuestionStatus = false;
  List<ViewIndividualQuestionArr>? questionArrList;
  String userName = "";
  List<ViewNotificationKudosAwardDetailData>? notificationKudosAwardList;

  void notificationDataSet(Map<String, dynamic> response) {
    ViewUnreadNotificationList response1 = ViewUnreadNotificationList.fromJson(response);

    final List<ViewUnreadNotificationData> listUnreadTemp = response1.data!;

    final joAnsStatus = response['ansStatus'] ?? {};
    final reminderList = response['reminderList'] ?? {};
    final joToDoList = response['toDoList'] ?? {};

    unreadTotalPages = response1.totalPageCount!;
    listUnread.clear();

    for (var action in response1.actions!) {
      listUnread.add(ViewUnreadNotificationData(
        id: action.id,
        title: action.name,
        description: action.description,
        createdAt: action.dueDate,
        notificationType: 'actionList',
      ));
    }

    void addCheck(String key, String reminderText, String firstUseText) {
      final isCompleted = joAnsStatus[key] ?? true;
      final isReminder = reminderList[key] ?? false;
      if (!isCompleted) {
        listUnread.add(ViewUnreadNotificationData(
          title: isReminder ? 'Reminder!' : 'First Use Checklist',
          description: isReminder ? reminderText : firstUseText,
        ));
      }
    }

    addCheck('tribeValue', 'Evaluate yourself against Tribe Values.', 'Evaluate yourself against Tribe Values.');
    addCheck('functionalLens', 'Complete Personality Type Questionnaire.', 'Complete Personality Type Questionnaire.');
    addCheck('teamRoleAnswers', 'Complete Team Role Questionnaire.', 'Complete Team Role Questionnaire.');
    addCheck('cultureStructure', 'Complete Culture Structure Questionnaire.', 'Complete Culture Structure Questionnaire.');
    addCheck('motivation', 'Complete Motivation Questionnaire.', 'Complete Motivation Questionnaire.');
    addCheck('tribeometer', 'Complete Tribeometer Survey.', 'Complete Tribeometer Survey.');
    addCheck('diagnostic', 'Complete Diagnostic Survey.', 'Complete Diagnostic Survey.');

    bool allAnsDone = ['tribeValue', 'functionalLens', 'teamRoleAnswers', 'cultureStructure', 'motivation', 'tribeometer', 'diagnostic']
        .every((key) => joAnsStatus[key] ?? false);

    if (allAnsDone) {
      void addTodo(String key, String reminderText, String todoText) {
        final isDone = joToDoList[key] ?? true;
        final isReminder = reminderList[key] ?? false;
        if (!isDone) {
          listUnread.add(ViewUnreadNotificationData(
            title: isReminder ? 'Reminder To Do List!' : 'To Do List',
            description: isReminder ? reminderText : todoText,
          ));
        }
      }

      addTodo('tribeValue', 'Review your values Monthly.', 'Review your values Monthly.');
      addTodo('functionalLens', 'Review Personality Type Questionnaire.', 'Review Personality Type Questionnaire.');
      addTodo('teamRoleAnswers', 'Review Team Role Questionnaire.', 'Review Team Role Questionnaire.');
      addTodo('cultureStructure', 'Review Culture Structure Questionnaire.', 'Review Culture Structure Questionnaire.');
      addTodo('motivation', 'Review Motivation Questionnaire.', 'Review Motivation Questionnaire.');
      addTodo('tribeometer', 'Review Tribeometer Survey.', 'Review Tribeometer Survey.');
      addTodo('diagnostic', 'Review Diagnostic Survey.', 'Review Diagnostic Survey.');
      addTodo('bubbleRatings', 'Award green bubbles daily.', 'Award green bubbles daily.');
    }
    listUnread.addAll(listUnreadTemp);

    if (currentPageUR >= unreadTotalPages) isLastPageUR = true;
    notifyListeners();
  }

  void goPreviousTop() {
    if (currentTopTitleIndex == 0) {
      currentTopTitleIndex = titleTopList.length - 1;
    } else {
      currentTopTitleIndex--;
    }
    notifyListeners();
  }

  void goNextTop() {
    if (currentTopTitleIndex == titleTopList.length - 1) {
      currentTopTitleIndex = 0;
    } else {
      currentTopTitleIndex++;
    }
    notifyListeners();
  }

  void goPreviousTitle() {
    if (currentTitleIndex == 0) {
      currentTitleIndex = titleList.length - 1;
    } else {
      currentTitleIndex--;
    }
    notifyListeners();
  }

  void goNextTitle() {
    if (currentTitleIndex == titleList.length - 1) {
      currentTitleIndex = 0;
    } else {
      currentTitleIndex++;
    }
    notifyListeners();
  }

  void selectOption(int questionIndex, int optionIndex) {
    for (var i = 0; i < questionArrList![questionIndex].options!.length; i++) {
      questionArrList![questionIndex].options![i].answerFlag = i == optionIndex;
    }
    questionArrList![questionIndex].mAnswer = questionArrList![questionIndex].options![optionIndex].optionName!;
    notifyListeners();
  }

  void validateAndSubmit(BuildContext context, String fromUserId, String mDate, String teamId) {
    int count = 0;

    for (int i = 0; i < questionArrList!.length; i++) {
      if ((questionArrList![i].mAnswer).isEmpty) {
        count = 0;

        showCustomSnackBar("${getTranslated("please_select_answer", context)} ${questionArrList![i].questionId}", context);
        return;
      } else {
        count++;
      }
    }

    if (count == questionArrList!.length) {
      sendIndividualQuestionnaireAPI(fromUserId, mDate, teamId);
    }
  }

  //API calling----------------

  Future<void> viewUnReadNotificationList(String userId, int page) async {
    _isLoading = true;
    Map<String, dynamic> requestData = {"userId": userId, "page": page};
    ApiResponse apiResponse = await notificationServiceInterface!.viewUnReadNotificationList(requestData);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewUnreadNotificationList response = ViewUnreadNotificationList.fromJson(map);
      if (response.data == null) {
        archiveStatus = false;
      } else if (response.data!.isNotEmpty) {
        archiveStatus = true;
      } else {
        archiveStatus = false;
      }
      notificationDataSet(apiResponse.response!.data);
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> viewNotificationList(String userId, int page) async {
    Map<String, dynamic> requestData = {"userId": userId, "page": page};
    ApiResponse apiResponse = await notificationServiceInterface!.viewNotificationList(requestData);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewUnreadNotificationList response = ViewUnreadNotificationList.fromJson(map);
      archivedList = [];
      archivedList = response.data!;
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> readAllNotification(String userId) async {
    Map<String, dynamic> requestData = {
      "userId": userId,
    };
    ApiResponse apiResponse = await notificationServiceInterface!.readAllNotification(requestData);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      archiveStatus = true;
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> updateNotificationStatus(String notificationId) async {
    Map<String, dynamic> requestData = {
      "notificationId": notificationId,
    };
    ApiResponse apiResponse = await notificationServiceInterface!.updateNotificationStatus(requestData);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  void updateAmazingValue({
    required int today,
    required int yesterday,
    required int thisWeek,
    required int lastWeek,
    required int thisMonth,
    required int lastMonth,
    required int total,
  }) {
    switch (currentTitle) {
      case "Today":
        amazingValue = today.toString();
        break;
      case "Yesterday":
        amazingValue = yesterday.toString();
        break;
      case "This week":
        amazingValue = thisWeek.toString();
        break;
      case "Last week":
        amazingValue = lastWeek.toString();
        break;
      case "This month":
        amazingValue = thisMonth.toString();
        break;
      case "Last month":
        amazingValue = lastMonth.toString();
        break;
      default:
        amazingValue = total.toString();
    }
    notifyListeners();
  }

  Future<void> viewHomeKudosCountAPI(String orgId) async {
    Map<String, dynamic> requestData = {
      "orgId": orgId,
    };
    ApiResponse apiResponse = await notificationServiceInterface!.viewHomeKudosCount(requestData);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewHomeKudosCountResponse response = ViewHomeKudosCountResponse.fromJson(map);
      kudosResponse = response.data!;
      totalKudosList = response.data!.belief!;
      amazingValueKey = kudosResponse.kudoAwardKey!;
      todayAwardCount = kudosResponse.todayKudosAwardCount!;
      yesterdayAwardCount = kudosResponse.yesterdayKudosAwardCount!;
      thisWeekAwardCount = kudosResponse.thisWeekKudosAwardCount!;
      lastWeekAwardCount = kudosResponse.lastWeekKudosAwardCount!;
      thisMonthAwardCount = kudosResponse.thisMonthKudosAwardCount!;
      lastMonthAwardCount = kudosResponse.lastMonthKudosAwardCount!;
      totalAwardCount = kudosResponse.totalKudosAwardCount!;
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> viewKudosAwardDetailAPI() async {
    ApiResponse apiResponse = await notificationServiceInterface!.viewKudosAwardDetail();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewKudosAwardDetailResponse response = ViewKudosAwardDetailResponse.fromJson(map);
      viewKudosAwardDetailList = response.data;
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> getFeedbackUserAnswerStatus(String fromUserId, String date) async {
    _isLoading = true;
    Map<String, dynamic> requestData = {"fromUserId": fromUserId, "date": date};
    ApiResponse apiResponse = await notificationServiceInterface!.viewTeamFeedbackUserAnswerStatus(requestData);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewTeamFeedbackUserAnswerStatusResponse response = ViewTeamFeedbackUserAnswerStatusResponse.fromJson(map);
      teamTitle = response.message!;
      if (!response.status!) {
        viewIndividualQuestionnaireAPI(fromUserId);
      } else {
        _isLoading = false;
        teamQuestionStatus = false;
      }
    } else {
      _isLoading = false;
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> viewIndividualQuestionnaireAPI(String fromUserId) async {
    Map<String, dynamic> requestData = {"fromUserId": fromUserId};
    ApiResponse apiResponse = await notificationServiceInterface!.viewIndividualQuestionnaireList(requestData);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewIndividualQuestionnaireResponse response = ViewIndividualQuestionnaireResponse.fromJson(map);
      teamQuestionStatus = true;
      userName = response.data!.userName!;
      questionArrList = response.data!.questionArr;
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> sendIndividualQuestionnaireAPI(String fromUserId, String mDate, String teamId) async {
    _isLoadingBtn = true;
    List<Map<String, dynamic>> answers = [];

    for (var question in questionArrList!) {
      Map<String, dynamic> answerItem = {
        "questionId": question.questionId,
      };

      final selectedOptions = question.options?.where((o) => o.answerFlag).toList();
      final selectedOption = (selectedOptions != null && selectedOptions.isNotEmpty) ? selectedOptions.first : null;

      if (selectedOption != null) {
        answerItem["optionId"] = selectedOption.optionId;
      }
      answers.add(answerItem);
    }

    Map<String, dynamic> payload = {
      "fromUserId": fromUserId.toString(),
      "date": mDate,
      "teamFeedbackId": teamId,
      "answer": answers,
    };

    ApiResponse apiResponse = await notificationServiceInterface!.sendIndividualQuestionnaireList(payload);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      showCustomSnackBar(map["message"], Get.context!);
      Navigator.pop(Get.context!, true);
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    _isLoadingBtn = false;
    notifyListeners();
  }

  Future<void> viewKudoAwardDetailAPI(String dotValueId, String page) async {
    _isLoading = true;
    Map<String, dynamic> payload = {"page": page.toString(), "dotValueId": dotValueId};

    ApiResponse apiResponse = await notificationServiceInterface!.viewKudoAwardDetail(payload);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewNotificationKudosAwardDetailResponse response = ViewNotificationKudosAwardDetailResponse.fromJson(map);
      notificationKudosAwardList = response.data;
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    _isLoading = false;
    notifyListeners();
  }
}
