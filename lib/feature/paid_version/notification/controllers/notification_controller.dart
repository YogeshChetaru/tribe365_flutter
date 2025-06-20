import 'package:flutter/material.dart';
import 'package:tribe365_new/helper/api_checker.dart';
import '../../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../../data/model/api_response.dart';
import '../../../../main.dart';
import '../domain/models/view_notification_list_response.dart';
import '../domain/models/view_unread_notification_list.dart';
import '../domain/services/notification_service_interface.dart';

class NotificationController extends ChangeNotifier {
  final NotificationServiceInterface? notificationServiceInterface;

  NotificationController({required this.notificationServiceInterface});

  bool isNotificationType = true;

  void updateIsNotificationType(String s) {
    if (s == 'notification') {
      isNotificationType = true;
    } else {
      isNotificationType = false;
    }
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
      ViewNotificationListResponse response = ViewNotificationListResponse.fromJson(map);
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> readAllNotification(String userId, int page) async {
    Map<String, dynamic> requestData = {
      "userId": userId,
    };
    ApiResponse apiResponse = await notificationServiceInterface!.readAllNotification(requestData);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
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
