import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tribe365_new/utill/app_constants.dart';

import 'data/datasource/remote/dio/dio_client.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';
import 'feature/login/controllers/login_controller.dart';
import 'feature/login/domain/repositories/login_repository.dart';
import 'feature/login/domain/repositories/login_repository_interface.dart';
import 'feature/login/domain/services/login_service.dart';
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

  // Provider
  sl.registerFactory(() => SplashController(splashServiceInterface: sl()));
  sl.registerFactory(() => LoginController(loginServiceInterface: sl()));

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


  SplashServiceInterface splashServiceInterface = SplashService(
    splashRepositoryInterface: sl(),
  );
  sl.registerLazySingleton(() => splashServiceInterface);

  //services
  sl.registerLazySingleton(
    () => SplashService(splashRepositoryInterface: sl()),
  );

  sl.registerLazySingleton(
        () => LoginService(loginRepositoryInterface: sl()),
  );
}
