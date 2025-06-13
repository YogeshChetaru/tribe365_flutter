import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';

class FcmBroadcastReceiver {
  static late BuildContext _context;
  static final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  static const int notificationId = 101;
  static const int replyNotificationId = 102;

  static void initialize(BuildContext context) {
    _context = context;
    _initNotificationPlugin();
    _listenToFirebase();
  }

  static void _initNotificationPlugin() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings =
    InitializationSettings(android: androidSettings);

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload != null) {
          _handlePayload(response.payload!);
        }
      },
    );
  }

  static void _listenToFirebase() {
    FirebaseMessaging.onMessage.listen(handleIncomingMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleIncomingMessage);
  }

  static void handleIncomingMessage(RemoteMessage message) {
    final title = message.notification?.title ?? "Notification";
    final body = message.notification?.body ?? "";

    _localNotifications.show(
      notificationId,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      payload: jsonEncode(message.data),
    );
  }

  static void _handlePayload(String payload) {
    final data = jsonDecode(payload);
    final String? mood = data['mood'];
    final String? message = data['message'];

    if (mood != null) {
      apiAddHappyIndex(mood);
    } else if (message != null) {
      sendOffloading(message);
    }
  }

  static void apiAddHappyIndex(String status) async {
    try {
      final response = await http.post(
        Uri.parse("https://yourapi.com/api/addHappyIndex"),
        body: jsonEncode({
          "userId": "USER_ID", // Replace with session param
          "moodStatus": status,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      final json = jsonDecode(response.body);
      final msg = json['message'] ?? '';

      if (msg.isNotEmpty) {
        removeNotification("Response already received.");
      } else {
        replyNotification("Response received.");
      }

      _sendInternalBroadcast("Reply");

    } catch (e) {
      replyErrorNotification("Failed to send mood.");
    }
  }

  static void sendOffloading(String msgString) async {
    try {
      final response = await http.post(
        Uri.parse("https://yourapi.com/api/postFeedback"),
        body: jsonEncode({
          "message": msgString,
          "userId": "USER_ID",
          "orgId": "ORG_ID",
          "image": ""
        }),
        headers: {'Content-Type': 'application/json'},
      );

      final json = jsonDecode(response.body);
      final msg = json['message'] ?? "Submitted successfully";

      Fluttertoast.showToast(msg: msg);
      offloadingReply();
    } catch (e) {
      Fluttertoast.showToast(msg: "Offloading failed.");
    }
  }

  static void replyNotification(String message) {
    _localNotifications.show(
      notificationId,
      "Notification",
      message,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
    _sendInternalBroadcast("noti");
  }

  static void replyErrorNotification(String message) {
    _localNotifications.show(
      notificationId,
      "Error",
      message,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }

  static void removeNotification(String message) async {
    _localNotifications.show(
      notificationId,
      "Notification",
      message,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );

    await Future.delayed(const Duration(seconds: 3));
    _localNotifications.cancel(notificationId);
  }

  static void offloadingReply() {
    _localNotifications.show(
      replyNotificationId,
      "Offloading",
      "Offloading submitted",
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }

  static void _sendInternalBroadcast(String action) {
    // You can use an event bus or provider to send messages to other parts of your app
    Fluttertoast.showToast(msg: "Broadcast: $action");
  }

  static void showLocalNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        channelDescription: 'Used for important notifications',
        importance: Importance.max,
        priority: Priority.high,
      );

      const NotificationDetails platformDetails =
      NotificationDetails(android: androidDetails);

      await flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        platformDetails,
      );
    }
  }

}
