import '../../../../../data/model/api_response.dart';
import '../repositories/notification_repository_interface.dart';
import 'notification_service_interface.dart';

class NotificationService implements NotificationServiceInterface {
  NotificationRepositoryInterface notificationRepositoryInterface;

  NotificationService({required this.notificationRepositoryInterface});
  @override
  Future<ApiResponse> viewUnReadNotificationList(Map<String, dynamic> body) {
    return notificationRepositoryInterface.viewUnReadNotificationList(body);
  }

  @override
  Future<ApiResponse> viewNotificationList(Map<String, dynamic> body) {
    return notificationRepositoryInterface.viewNotificationList(body);
  }

  @override
  Future<ApiResponse> readAllNotification(Map<String, dynamic> body) {
    return notificationRepositoryInterface.readAllNotification(body);
  }

  @override
  Future<ApiResponse> updateNotificationStatus(Map<String, dynamic> body) {
    return notificationRepositoryInterface.updateNotificationStatus(body);
  }

  @override
  Future<ApiResponse> viewHomeKudosCount(Map<String, dynamic> body) {
    return notificationRepositoryInterface.viewHomeKudosCount(body);
  }

  @override
  Future<ApiResponse> viewTeamFeedbackUserAnswerStatus(Map<String, dynamic> body) {
    return notificationRepositoryInterface.viewTeamFeedbackUserAnswerStatus(body);
  }

  @override
  Future<ApiResponse> viewKudosAwardDetail() {
    return notificationRepositoryInterface.viewKudosAwardDetail();
  }

  @override
  Future<ApiResponse> viewIndividualQuestionnaireList(Map<String, dynamic> body) {
    return notificationRepositoryInterface.viewIndividualQuestionnaireList(body);
  }

  @override
  Future<ApiResponse> sendIndividualQuestionnaireList(Map<String, dynamic> body) {
    return notificationRepositoryInterface.sendIndividualQuestionnaireList(body);
  }

  @override
  Future<ApiResponse> viewKudoAwardDetail(Map<String, dynamic> body) {
    return notificationRepositoryInterface.viewKudoAwardDetail(body);
  }

}
