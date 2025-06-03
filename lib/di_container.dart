import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tribe365_new/feature/free_version/free_dashboard/controllers/free_dashboard_controller.dart';
import 'package:tribe365_new/feature/free_version/free_dashboard/domain/repositories/free_dashboard_repository.dart';
import 'package:tribe365_new/feature/free_version/hptm/domain/services/hptm_service_interface.dart';
import 'package:tribe365_new/feature/paid_version/notification/controllers/notification_controller.dart';
import 'package:tribe365_new/feature/paid_version/notification/domain/services/notification_service_interface.dart';
import 'package:tribe365_new/feature/paid_version/paid_dashboard/domain/repositories/paid_dashboard_repository.dart';
import 'package:tribe365_new/utill/app_constants.dart';
import 'data/datasource/remote/dio/dio_client.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';
import 'feature/free_version/free_dashboard/domain/repositories/free_dashboard_repository_interface.dart';
import 'feature/free_version/free_dashboard/domain/services/free_dashboard_service.dart';
import 'feature/free_version/free_dashboard/domain/services/free_dashboard_service_interface.dart';
import 'feature/free_version/hptm/controllers/hptm_controller.dart';
import 'feature/free_version/hptm/domain/repositories/hptm_repository.dart';
import 'feature/free_version/hptm/domain/repositories/hptm_repository_interface.dart';
import 'feature/free_version/hptm/domain/services/hptm_service.dart';
import 'feature/login/controllers/login_controller.dart';
import 'feature/login/domain/repositories/login_repository.dart';
import 'feature/login/domain/repositories/login_repository_interface.dart';
import 'feature/login/domain/services/login_service.dart';
import 'feature/login/domain/services/login_service_interface.dart';
import 'feature/paid_version/home/controllers/home_controller.dart';
import 'feature/paid_version/home/domain/repositories/home_repository.dart';
import 'feature/paid_version/home/domain/repositories/home_repository_interface.dart';
import 'feature/paid_version/home/domain/services/home_service.dart';
import 'feature/paid_version/home/domain/services/home_service_interface.dart';
import 'feature/paid_version/notification/domain/repositories/notification_repository.dart';
import 'feature/paid_version/notification/domain/repositories/notification_repository_interface.dart';
import 'feature/paid_version/notification/domain/services/notification_service.dart';
import 'feature/paid_version/paid_dashboard/controllers/paid_dashboard_controller.dart';
import 'feature/paid_version/paid_dashboard/domain/repositories/paid_dashboard_repository_interface.dart';
import 'feature/paid_version/paid_dashboard/domain/services/paid_dashboard_service_interface.dart';
import 'feature/paid_version/paid_dashboard/domain/services/paid_dashboard_service.dart';
import 'feature/splash/controllers/splash_controller.dart';
import 'feature/splash/domain/repositories/splash_repository.dart';
import 'feature/splash/domain/repositories/splash_repository_interface.dart';
import 'feature/splash/domain/services/splash_service.dart';
import 'feature/splash/domain/services/splash_service_interface.dart';
import 'helper/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => NetworkInfo(sl()));
  sl.registerLazySingleton(
    () => DioClient(
      AppConstants.baseUrl,
      sl(),
      loggingInterceptor: sl(),
      sharedPreferences: sl(),
    ),
  );

  // Repository
  sl.registerLazySingleton(
    () => SplashRepository(sharedPreferences: sl(), dioClient: sl()),
  );
  sl.registerLazySingleton(
    () => LoginRepository(sharedPreferences: sl(), dioClient: sl()),
  );
  sl.registerLazySingleton(
        () => FreeDashboardRepository(sharedPreferences: sl(), dioClient: sl()),
  );
  sl.registerLazySingleton(
        () => HPTMRepository(sharedPreferences: sl(), dioClient: sl()),
  );
  sl.registerLazySingleton(
        () => PaidDashboardRepository(sharedPreferences: sl(), dioClient: sl()),
  );

  sl.registerLazySingleton(
        () => HomeRepository(sharedPreferences: sl(), dioClient: sl()),
  );

  sl.registerLazySingleton(
        () => NotificationRepository(sharedPreferences: sl(), dioClient: sl()),
  );

  // Provider
  sl.registerFactory(() => SplashController(splashServiceInterface: sl()));
  sl.registerFactory(() => LoginController(loginServiceInterface: sl()));
  sl.registerFactory(() => FreeDashboardController(freeDashboardServiceInterface: sl()));
  sl.registerFactory(() => HPTMController(hptmServiceInterface: sl()));
  sl.registerFactory(() => PaidDashboardController(paidDashboardServiceInterface: sl()));
  sl.registerFactory(() => HomeController(homeServiceInterface: sl()));
  sl.registerFactory(() => NotificationController(notificationServiceInterface: sl()));

  //interface
  SplashRepositoryInterface splashRepositoryInterface = SplashRepository(
    dioClient: sl(),
    sharedPreferences: sl(),
  );
  sl.registerLazySingleton(() => splashRepositoryInterface);

  LoginRepositoryInterface loginRepositoryInterface = LoginRepository(
    dioClient: sl(),
    sharedPreferences: sl(),
  );
  sl.registerLazySingleton(() => loginRepositoryInterface);

  FreeDashboardRepositoryInterface freeDashboardRepositoryInterface = FreeDashboardRepository(
    dioClient: sl(),
    sharedPreferences: sl(),
  );
  sl.registerLazySingleton(() => freeDashboardRepositoryInterface);

  HPTMRepositoryInterface hptmRepositoryInterface = HPTMRepository(
    dioClient: sl(),
    sharedPreferences: sl(),
  );
  sl.registerLazySingleton(() => hptmRepositoryInterface);

  PaidDashboardRepositoryInterface paidDashboardRepositoryInterface = PaidDashboardRepository(
    dioClient: sl(),
    sharedPreferences: sl(),
  );
  sl.registerLazySingleton(() => paidDashboardRepositoryInterface);

  HomeRepositoryInterface homeRepositoryInterface = HomeRepository(
    dioClient: sl(),
    sharedPreferences: sl(),
  );
  sl.registerLazySingleton(() => homeRepositoryInterface);

  NotificationRepositoryInterface notificationRepositoryInterface = NotificationRepository(
    dioClient: sl(),
    sharedPreferences: sl(),
  );
  sl.registerLazySingleton(() => notificationRepositoryInterface);

  //Services Interface
  SplashServiceInterface splashServiceInterface = SplashService(
    splashRepositoryInterface: sl(),
  );
  sl.registerLazySingleton(() => splashServiceInterface);

  LoginServiceInterface loginServiceInterface = LoginService(
    loginRepositoryInterface: sl(),
  );
  sl.registerLazySingleton(() => loginServiceInterface);

  FreeDashboardServiceInterface freeDashboardServiceInterface = FreeDashboardService(
    freeDashboardRepositoryInterface: sl(),
  );
  sl.registerLazySingleton(() => freeDashboardServiceInterface);

  HPTMServiceInterface hptmServiceInterface = HPTMService(
    hptmRepositoryInterface: sl(),
  );
  sl.registerLazySingleton(() => hptmServiceInterface);

  PaidDashboardServiceInterface paidDashboardServiceInterface = PaidDashboardService(
    paidDashboardRepositoryInterface: sl(),
  );
  sl.registerLazySingleton(() => paidDashboardServiceInterface);


  HomeServiceInterface homeServiceInterface = HomeService(
    homeRepositoryInterface: sl(),
  );
  sl.registerLazySingleton(() => homeServiceInterface);

  NotificationServiceInterface notificationServiceInterface = NotificationService(
    notificationRepositoryInterface: sl(),
  );
  sl.registerLazySingleton(() => notificationServiceInterface);

  //services
  sl.registerLazySingleton(
    () => SplashService(splashRepositoryInterface: sl()),
  );

  sl.registerLazySingleton(
    () => LoginService(loginRepositoryInterface: sl()),
  );

  sl.registerLazySingleton(
        () => FreeDashboardService(freeDashboardRepositoryInterface: sl()),
  );

  sl.registerLazySingleton(
        () => HPTMService(hptmRepositoryInterface: sl()),
  );

  sl.registerLazySingleton(
        () => PaidDashboardService(paidDashboardRepositoryInterface: sl()),
  );

  sl.registerLazySingleton(
        () => HomeService(homeRepositoryInterface: sl()),
  );

  sl.registerLazySingleton(
        () => NotificationService(notificationRepositoryInterface: sl()),
  );
}
