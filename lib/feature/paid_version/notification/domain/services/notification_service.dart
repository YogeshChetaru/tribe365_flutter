import '../repositories/notification_repository_interface.dart';
import 'notification_service_interface.dart';

class NotificationService implements NotificationServiceInterface {
  NotificationRepositoryInterface notificationRepositoryInterface;

  NotificationService({required this.notificationRepositoryInterface});
}
