import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/free_version/free_dashboard/controllers/free_dashboard_controller.dart';
import 'package:tribe365_new/feature/login/controllers/login_controller.dart';
import 'package:tribe365_new/feature/paid_version/notification/controllers/notification_controller.dart';
import 'package:tribe365_new/feature/paid_version/offloading/controllers/offloading_controller.dart';
import 'package:tribe365_new/feature/paid_version/paid_dashboard/controllers/paid_dashboard_controller.dart';
import 'package:tribe365_new/feature/paid_version/profile/controllers/profile_controller.dart';
import 'package:tribe365_new/utill/app_constants.dart';
import 'package:tribe365_new/utill/fcm_broadcast_receiver.dart';
import 'package:tribe365_new/utill/light_theme.dart';
import 'di_container.dart' as di;
import 'feature/free_version/hptm/controllers/hptm_controller.dart';
import 'feature/paid_version/home/controllers/home_controller.dart';
import 'feature/paid_version/know/controllers/know_controller.dart';
import 'feature/paid_version/risk/controllers/risk_controller.dart';
import 'feature/splash/controllers/splash_controller.dart';
import 'feature/splash/screens/splash_screen.dart';
import 'helper/custom_delegate.dart';
import 'localization/app_localization.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  FcmBroadcastReceiver.handleIncomingMessage(message);
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await Firebase.initializeApp();
  await di.init();
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => di.sl<SplashController>()),
        ChangeNotifierProvider(create: (context) => di.sl<LoginController>()),
        ChangeNotifierProvider(create: (context) => di.sl<FreeDashboardController>()),
        ChangeNotifierProvider(create: (context) => di.sl<HPTMController>()),
        ChangeNotifierProvider(create: (context) => di.sl<PaidDashboardController>()),
        ChangeNotifierProvider(create: (context) => di.sl<HomeController>()),
        ChangeNotifierProvider(create: (context) => di.sl<NotificationController>()),
        ChangeNotifierProvider(create: (context) => di.sl<KnowController>()),
        ChangeNotifierProvider(create: (context) => di.sl<OffloadingController>()),
        ChangeNotifierProvider(create: (context) => di.sl<RiskController>()),
        ChangeNotifierProvider(create: (context) => di.sl<ProfileController>()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    List<Locale> locals = [];
    for (var language in AppConstants.languages) {
      locals.add(Locale(language.languageCode!, language.countryCode));
    }
    return MaterialApp(
      title: AppConstants.appName,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      locale: Locale("en"),
      theme: light,
      localizationsDelegates: [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FallbackLocalizationDelegate(),
      ],
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.noScaling),
          child: child!,
        );
      },
      supportedLocales: locals,
      home: SplashScreen(),
    );
  }
}

class Get {
  static BuildContext? get context => navigatorKey.currentContext;

  static NavigatorState? get navigator => navigatorKey.currentState;
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
