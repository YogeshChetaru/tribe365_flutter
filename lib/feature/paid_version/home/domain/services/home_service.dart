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
  @override
  Future<ApiResponse> userApplyLeave(Map<String, dynamic> body) {
    return homeRepositoryInterface.userApplyLeave(body);
  }
  @override
  Future<ApiResponse> userChangeLeaveStatus(Map<String, dynamic> body) {
    return homeRepositoryInterface.userChangeLeaveStatus(body);
  }
  @override
  Future<ApiResponse> addHappyIndex(Map<String, dynamic> body) {
    return homeRepositoryInterface.addHappyIndex(body);
  }

  @override
  Future<ApiResponse> postFeedback(Map<String, dynamic> body) {
    return homeRepositoryInterface.postFeedback(body);
  }
  @override
  Future<ApiResponse> getCurrentVersionOfApp(Map<String, dynamic> body) {
    return homeRepositoryInterface.getCurrentVersionOfApp(body);
  }

  @override
  Future<ApiResponse> getDepartmentUserList(Map<String, dynamic> body) {
    return homeRepositoryInterface.getDepartmentUserList(body);
  }

  @override
  Future<ApiResponse> getDotDetail(Map<String, dynamic> body) {
    return homeRepositoryInterface.getDotDetail(body);
  }

  @override
  Future<void> savePushNotificationStatus(bool userData) {
    return homeRepositoryInterface.savePushNotificationStatus(userData);
  }

  @override
  bool getPushNotificationStatus() {
    return homeRepositoryInterface.getPushNotificationStatus();
  }
}
