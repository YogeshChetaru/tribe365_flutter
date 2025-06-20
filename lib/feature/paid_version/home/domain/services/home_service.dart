import '../../../../../data/model/api_response.dart';
import '../repositories/home_repository_interface.dart';
import 'home_service_interface.dart';

class HomeService implements HomeServiceInterface {
  HomeRepositoryInterface homeRepositoryInterface;

  HomeService({required this.homeRepositoryInterface});
  @override
  Future<ApiResponse> getHomeData(Map<String, dynamic> body) {
    return homeRepositoryInterface.getHomeData(body);
  }

  @override
  Future<ApiResponse> viewNotificationsCount(Map<String, dynamic> body) {
    return homeRepositoryInterface.viewNotificationsCount(body);
  }
}
