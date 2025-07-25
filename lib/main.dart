import 'dart:io' show HttpClient, HttpOverrides, Platform, SecurityContext, X509Certificate;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('Background message: ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase initialization
  await Firebase.initializeApp();

  // Register FCM background handler for mobile
  if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  // macOS-specific notification permission
  if (!kIsWeb && Platform.isMacOS) {
    var status = await Permission.notification.status;
    if (!status.isGranted) {
      await Permission.notification.request();
    }
  }

  // Allow self-signed certs (mobile/desktop only)
  if (!kIsWeb) {
    HttpOverrides.global = MyHttpOverrides();
  }

  // Initialize Dependency Injection
  await di.init();

  // Local notifications setup (non-web only)
  if (!kIsWeb) {
    FcmBroadcastReceiver.initLocalNotifications();
  }

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
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      locale: const Locale("en"),
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
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
          child: child!,
        );
      },
      supportedLocales: AppConstants.languages
          .map((lang) => Locale(lang.languageCode!, lang.countryCode))
          .toList(),
      home: const SplashScreen(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class Get {
  static BuildContext? get context => navigatorKey.currentContext;
  static NavigatorState? get navigator => navigatorKey.currentState;
}
