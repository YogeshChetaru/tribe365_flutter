import 'package:flutter/services.dart';

class NotificationUtils {
  static const MethodChannel _channel = MethodChannel('com.chetaru.notifications');

  static Future<bool> areNotificationsEnabled() async {
    final bool result = await _channel.invokeMethod('areNotificationsEnabled');
    return result;
  }
}
