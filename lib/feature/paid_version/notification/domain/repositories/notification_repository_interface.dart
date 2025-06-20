

import '../../../../../data/model/api_response.dart';
import '../../../../../interface/repo_interface.dart';

abstract class NotificationRepositoryInterface implements RepositoryInterface {
  Future<ApiResponse> viewUnReadNotificationList(Map<String, dynamic> body);
  Future<ApiResponse> viewNotificationList(Map<String, dynamic> body);
  Future<ApiResponse> readAllNotification(Map<String, dynamic> body);
  Future<ApiResponse> updateNotificationStatus(Map<String, dynamic> body);
}
