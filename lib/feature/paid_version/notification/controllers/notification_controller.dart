import 'package:flutter/material.dart';
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
}
