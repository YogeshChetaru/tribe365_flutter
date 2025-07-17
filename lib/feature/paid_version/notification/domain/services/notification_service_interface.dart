import '../../../../../data/model/api_response.dart';

abstract class NotificationServiceInterface {
  Future<ApiResponse> viewUnReadNotificationList(Map<String, dynamic> body);
  Future<ApiResponse> viewNotificationList(Map<String, dynamic> body);
  Future<ApiResponse> readAllNotification(Map<String, dynamic> body);
  Future<ApiResponse> updateNotificationStatus(Map<String, dynamic> body);
  Future<ApiResponse> viewHomeKudosCount(Map<String, dynamic> body);
  Future<ApiResponse> viewTeamFeedbackUserAnswerStatus(Map<String, dynamic> body);
  Future<ApiResponse> viewIndividualQuestionnaireList(Map<String, dynamic> body);
  Future<ApiResponse> sendIndividualQuestionnaireList(Map<String, dynamic> body);
  Future<ApiResponse> viewKudoAwardDetail(Map<String, dynamic> body);
  Future<ApiResponse> viewKudosAwardDetail();
}
