import 'package:tribe365_new/feature/splash/domain/services/splash_service_interface.dart';
import '../repositories/splash_repository_interface.dart';

class SplashService implements SplashServiceInterface {
  SplashRepositoryInterface splashRepositoryInterface;

  SplashService({required this.splashRepositoryInterface});
}
