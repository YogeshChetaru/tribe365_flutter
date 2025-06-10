import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utill/app_constants.dart';
import 'models/notification_body.dart';

class NotificationHelper {
  static Future<void> initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings = InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    flutterLocalNotificationsPlugin.initialize(initializationsSettings, onDidReceiveNotificationResponse: (NotificationResponse load) async {
      try {
        NotificationBody payload;
        if (load.payload!.isNotEmpty) {
          payload = NotificationBody.fromJson(jsonDecode(load.payload!));
         /* if (Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn()) {
            if (payload.type == 'order') {
              Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => OrderDetailsScreen(
                        orderId: payload.orderId,
                        isNotification: true,
                      )));
            } else if (payload.type == 'wallet') {
              Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const WalletScreen()));
            } else if (payload.type == 'notification') {
              Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => const NotificationScreen(
                        fromNotification: true,
                      )));
            } else if (payload.type == 'cart') {
              Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const CartScreen()));
            } else if (payload.type == 'weather') {
              Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const WeatherForecastScreen()));
            } else if (payload.type == 'farmWeather') {
              Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => MyFieldsWeatherScreen(
                        farmId: payload.farmId!,
                        farmName: payload.farmName!,
                      )));
            }else if (payload.type== 'product') {
              Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => ProductDetails(
                    slug: payload.productSlug,
                    productId: int.parse(payload.productId!),
                  )));
            } else {
              Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => const NotificationScreen(
                        fromNotification: true,
                      )));
            }
          } else {
            Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const AuthScreen()));
          }*/
        }
      } catch (_) {}
      return;
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        NotificationBody notificationBody = convertNotification(message.data);
        print("onMessage: ${message.data}");

        /*if (Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn()) {
          if (message.data['type'] == "block") {
            Provider.of<AuthController>(Get.context!, listen: false).clearSharedData();
            Provider.of<AddressController>(Get.context!, listen: false).getAddressList();
            Navigator.of(Get.context!).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const AuthScreen()), (route) => false);
          } else if (message.data['type'] == 'order') {
            Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => OrderDetailsScreen(
                      orderId: notificationBody.orderId,
                      isNotification: true,
                    )));
          } else if (message.data['type'] == 'wallet') {
            Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const WalletScreen()));
          } else if (message.data['type'] == 'notification') {
            Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => const NotificationScreen(
                      fromNotification: true,
                    )));
          } else if (message.data['type'] == 'cart') {
            Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const CartScreen()));
          } else if (message.data['type'] == 'weather') {
            Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const WeatherForecastScreen()));
          } else if (message.data['type'] == 'farmWeather') {
            Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => MyFieldsWeatherScreen(
                      farmId: notificationBody.farmId!,
                      farmName: notificationBody.farmName!,
                    )));
          } else if (message.data['type'] == 'product') {
            Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => ProductDetails(
                      slug: notificationBody.productSlug,
                      productId: int.parse(notificationBody.productId!),
                    )));
          } else {
            Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => const NotificationScreen(
                      fromNotification: true,
                    )));
          }
        } else {
          Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const AuthScreen()));
        }*/
      }
      NotificationHelper.showNotification(message, flutterLocalNotificationsPlugin, false);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print("onOpenApp: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
      }
      try {
        if (message.data.isNotEmpty) {
          NotificationBody notificationBody = convertNotification(message.data);


          /*if (Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn()) {
            if (notificationBody.type == 'order') {
              Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => OrderDetailsScreen(
                        orderId: notificationBody.orderId,
                        isNotification: true,
                      )));
            } else if (notificationBody.type == 'wallet') {
              Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const WalletScreen()));
            } else if (notificationBody.type == 'notification') {
              Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => const NotificationScreen(
                        fromNotification: true,
                      )));
            } else if (notificationBody.type == 'cart') {
              Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const CartScreen()));
            } else if (notificationBody.type == 'weather') {
              Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const WeatherForecastScreen()));
            } else if (notificationBody.type == 'farmWeather') {
              Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => MyFieldsWeatherScreen(
                        farmId: notificationBody.farmId!,
                        farmName: notificationBody.farmName!,
                      )));
            } else if (message.data['type'] == 'product') {
              Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => ProductDetails(
                        slug: notificationBody.productSlug,
                        productId: int.parse(notificationBody.productId!),
                      )));
            } else {
              Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => const NotificationScreen(
                        fromNotification: true,
                      )));
            }
          } else {
            Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const AuthScreen()));
          }*/
        }
      } catch (_) {}
    });
  }

  static Future<void> showNotification(RemoteMessage message, FlutterLocalNotificationsPlugin fln, bool data) async {
    if (!Platform.isIOS) {
      String? title;
      String? body;
      String? orderID;
      String? farmIdD;
      String? farmName;
      String? productId;
      String? productSlug;
      String? image;
      NotificationBody notificationBody = convertNotification(message.data);
      if (data) {
        title = message.data['title'];
        body = message.data['body'];
        orderID = message.data['order_id'];
        farmIdD = message.data['farm_id'];
        farmName = message.data['farm_name'];
        productId = message.data['product_id'];
        productSlug = message.data['product_slug'];
        image = (message.data['image'] != null && message.data['image'].isNotEmpty)
            ? message.data['image'].startsWith('http')
                ? message.data['image']
                : '${AppConstants.baseUrl}/storage/app/public/notification/${message.data['image']}'
            : null;
      } else {
        title = message.notification!.title;
        body = message.notification!.body;
        orderID = message.notification!.titleLocKey;
        farmIdD = message.notification!.titleLocKey;
        farmName = message.notification!.titleLocKey;
        productId = message.notification!.titleLocKey;
        productSlug = message.notification!.titleLocKey;
        if (Platform.isAndroid) {
          image = (message.notification!.android!.imageUrl != null && message.notification!.android!.imageUrl!.isNotEmpty)
              ? message.notification!.android!.imageUrl!.startsWith('http')
                  ? message.notification!.android!.imageUrl
                  : '${AppConstants.baseUrl}/storage/app/public/notification/${message.notification!.android!.imageUrl}'
              : null;
        } else if (Platform.isIOS) {
          image = (message.notification!.apple!.imageUrl != null && message.notification!.apple!.imageUrl!.isNotEmpty)
              ? message.notification!.apple!.imageUrl!.startsWith('http')
                  ? message.notification!.apple!.imageUrl
                  : '${AppConstants.baseUrl}/storage/app/public/notification/${message.notification!.apple!.imageUrl}'
              : null;
        }
      }

      if (image != null && image.isNotEmpty) {
        try {
          await showBigPictureNotificationHiddenLargeIcon(
              title, body, orderID, farmIdD, farmName, productId, productSlug, notificationBody, image, fln);
        } catch (e) {
          await showBigTextNotification(title, body!, orderID, farmIdD, farmName, productId, productSlug, notificationBody, fln);
        }
      } else {
        await showBigTextNotification(title, body!, orderID, farmIdD, farmName, productId, productSlug, notificationBody, fln);
      }
    }
  }

  static Future<void> showTextNotification(String title, String body, String orderID, String? farmIdD, String? farmName, String? productId,
      String? productSlug, NotificationBody? notificationBody, FlutterLocalNotificationsPlugin fln) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'tribe365',
      'tribe365',
      playSound: true,
      importance: Importance.max,
      priority: Priority.max,
      sound: RawResourceAndroidNotificationSound('notification'),
      icon: '@mipmap/ic_launcher',
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: notificationBody != null ? jsonEncode(notificationBody.toJson()) : null);
  }

  static Future<void> showBigTextNotification(String? title, String body, String? orderID, String? farmIdD, String? farmName, String? productId,
      String? productSlug, NotificationBody? notificationBody, FlutterLocalNotificationsPlugin fln) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body,
      htmlFormatBigText: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
    );
    AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'tribe365',
      'tribe365',
      importance: Importance.max,
      styleInformation: bigTextStyleInformation,
      priority: Priority.max,
      playSound: true,
      sound: const RawResourceAndroidNotificationSound('notification'),
      icon: '@mipmap/ic_launcher',
    );
    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: notificationBody != null ? jsonEncode(notificationBody.toJson()) : null);
  }

  static Future<void> showBigPictureNotificationHiddenLargeIcon(String? title, String? body, String? orderID, String? farmIdD, String? farmName,
      String? productId, String? productSlug, NotificationBody? notificationBody, String image, FlutterLocalNotificationsPlugin fln) async {
    final String largeIconPath = await _downloadAndSaveFile(image, 'largeIcon');
    final String bigPicturePath = await _downloadAndSaveFile(image, 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      hideExpandedLargeIcon: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
      summaryText: body,
      htmlFormatSummaryText: true,
    );
    final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'tribe365',
      'tribe365',
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      priority: Priority.max,
      playSound: true,
      styleInformation: bigPictureStyleInformation,
      importance: Importance.max,
      sound: const RawResourceAndroidNotificationSound('notification'),
      icon: '@mipmap/ic_launcher',
    );
    final NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: notificationBody != null ? jsonEncode(notificationBody.toJson()) : null);
  }

  static Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  static NotificationBody convertNotification(Map<String, dynamic> data) {
    if (data['type'] == 'notification') {
      return NotificationBody(type: 'notification');
    } else if (data['type'] == 'order') {
      return NotificationBody(type: 'order', orderId: int.parse(data['order_id']));
    } else if (data['type'] == 'wallet') {
      return NotificationBody(type: 'wallet');
    } else if (data['type'] == 'block') {
      return NotificationBody(type: 'block');
    } else if (data['type'] == 'cart') {
      return NotificationBody(type: 'cart');
    } else if (data['type'] == 'weather') {
      return NotificationBody(type: 'weather');
    } else if (data['type'] == 'farmWeather') {
      return NotificationBody(type: 'farmWeather', farmId: data['farm_id'], farmName: data['farm_name']);
    } else if (data['type'] == 'product') {
      return NotificationBody(type: 'product', productId: data['product_id'], productSlug: data['product_slug']);
    } else {
      return NotificationBody(type: 'notification');
    }
  }
}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('notification_data', jsonEncode(message.data));
}
