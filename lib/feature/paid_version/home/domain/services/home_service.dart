import '../repositories/home_repository_interface.dart';
import 'home_service_interface.dart';

class HomeService implements HomeServiceInterface {
  HomeRepositoryInterface homeRepositoryInterface;

  HomeService({required this.homeRepositoryInterface});
}
