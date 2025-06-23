import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tribe365_new/helper/api_checker.dart';
import '../../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../../data/model/api_response.dart';
import '../../../../main.dart';
import '../domain/models/view_unread_notification_list.dart';
import '../domain/services/notification_service_interface.dart';

class NotificationController extends ChangeNotifier {
  final NotificationServiceInterface? notificationServiceInterface;

  NotificationController({required this.notificationServiceInterface});

  bool isNotificationType = true;
  bool archiveStatus = false;
  List<ViewUnreadNotificationData>? archivedList;

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
  int UNREAD_TOTAL_PAGES = 1;
  bool isLastPageUR = false;
  bool archiveAll = false;

  void notificationDataSet(Map<String, dynamic> response){

    ViewUnreadNotificationList response1 = ViewUnreadNotificationList.fromJson(response);


    final List<ViewUnreadNotificationData> listUnreadTemp = response1.data!;

    final joAnsStatus = response['ansStatus'] ?? {};
    final reminderList = response['reminderList'] ?? {};
    final joToDoList = response['toDoList'] ?? {};


    UNREAD_TOTAL_PAGES = response1.totalPageCount!;
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

    addCheck('tribeValue',
        'Evaluate yourself against Tribe Values.',
        'Evaluate yourself against Tribe Values.');
    addCheck('functionalLens',
        'Complete Personality Type Questionnaire.',
        'Complete Personality Type Questionnaire.');
    addCheck('teamRoleAnswers',
        'Complete Team Role Questionnaire.',
        'Complete Team Role Questionnaire.');
    addCheck('cultureStructure',
        'Complete Culture Structure Questionnaire.',
        'Complete Culture Structure Questionnaire.');
    addCheck('motivation',
        'Complete Motivation Questionnaire.',
        'Complete Motivation Questionnaire.');
    addCheck('tribeometer',
        'Complete Tribeometer Survey.',
        'Complete Tribeometer Survey.');
    addCheck('diagnostic',
        'Complete Diagnostic Survey.',
        'Complete Diagnostic Survey.');

    bool allAnsDone = [
      'tribeValue',
      'functionalLens',
      'teamRoleAnswers',
      'cultureStructure',
      'motivation',
      'tribeometer',
      'diagnostic'
    ].every((key) => joAnsStatus[key] ?? false);

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

      addTodo('tribeValue',
          'Review your values Monthly.',
          'Review your values Monthly.');
      addTodo('functionalLens',
          'Review Personality Type Questionnaire.',
          'Review Personality Type Questionnaire.');
      addTodo('teamRoleAnswers',
          'Review Team Role Questionnaire.',
          'Review Team Role Questionnaire.');
      addTodo('cultureStructure',
          'Review Culture Structure Questionnaire.',
          'Review Culture Structure Questionnaire.');
      addTodo('motivation',
          'Review Motivation Questionnaire.',
          'Review Motivation Questionnaire.');
      addTodo('tribeometer',
          'Review Tribeometer Survey.',
          'Review Tribeometer Survey.');
      addTodo('diagnostic',
          'Review Diagnostic Survey.',
          'Review Diagnostic Survey.');
      addTodo('bubbleRatings',
          'Award green bubbles daily.',
          'Award green bubbles daily.');
    }
    listUnread.addAll(listUnreadTemp);

    if (currentPageUR >= UNREAD_TOTAL_PAGES) isLastPageUR = true;
    notifyListeners();
  }


  //API calling----------------
  Future<void> viewUnReadNotificationList(String userId, int page) async {
    Map<String, dynamic> requestData = {
      "userId": userId,
      "page": page
    };
    ApiResponse apiResponse = await notificationServiceInterface!.viewUnReadNotificationList(requestData);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewUnreadNotificationList response = ViewUnreadNotificationList.fromJson(map);
      if(response.data==null){
        archiveStatus = false;
      }
      else if(response.data!.isNotEmpty){
        archiveStatus = true;
      }
      else{
        archiveStatus = false;
      }
      notificationDataSet(apiResponse.response!.data);
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> viewNotificationList(String userId, int page) async {
    Map<String, dynamic> requestData = {
      "userId": userId,
      "page": page
    };
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
      Map<String, dynamic> map = apiResponse.response!.data;
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
      Map<String, dynamic> map = apiResponse.response!.data;

    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }
}
