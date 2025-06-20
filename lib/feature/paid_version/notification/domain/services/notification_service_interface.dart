import '../../../../../data/model/api_response.dart';

abstract class NotificationServiceInterface {
  Future<ApiResponse> viewUnReadNotificationList(Map<String, dynamic> body);
  Future<ApiResponse> viewNotificationList(Map<String, dynamic> body);
  Future<ApiResponse> readAllNotification(Map<String, dynamic> body);
  Future<ApiResponse> updateNotificationStatus(Map<String, dynamic> body);
}
