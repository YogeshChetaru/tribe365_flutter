import '../repositories/free_dashboard_repository_interface.dart';
import 'free_dashboard_service_interface.dart';

class FreeDashboardService implements FreeDashboardServiceInterface {
  FreeDashboardRepositoryInterface freeDashboardRepositoryInterface;

  FreeDashboardService({required this.freeDashboardRepositoryInterface});
}
