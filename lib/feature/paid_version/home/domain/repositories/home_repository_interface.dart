

import '../../../../../data/model/api_response.dart';
import '../../../../../interface/repo_interface.dart';

abstract class HomeRepositoryInterface implements RepositoryInterface {
  Future<ApiResponse> getHomeData(Map<String, dynamic> body);
  Future<ApiResponse> viewNotificationsCount(Map<String, dynamic> body);
  Future<ApiResponse> userApplyLeave(Map<String, dynamic> body);
  Future<ApiResponse> userChangeLeaveStatus(Map<String, dynamic> body);
  Future<ApiResponse> addHappyIndex(Map<String, dynamic> body);
  Future<ApiResponse> postFeedback(Map<String, dynamic> body);
  Future<ApiResponse> getCurrentVersionOfApp(Map<String, dynamic> body);
  Future<ApiResponse> getDotDetail(Map<String, dynamic> body);
  Future<ApiResponse> getDepartmentUserList(Map<String, dynamic> body);
  Future<void> savePushNotificationStatus(bool userData);
  bool getPushNotificationStatus();
}
