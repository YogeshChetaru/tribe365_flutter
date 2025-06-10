import '../../../../../data/model/api_response.dart';
import '../repositories/free_dashboard_repository_interface.dart';
import 'free_dashboard_service_interface.dart';

class FreeDashboardService implements FreeDashboardServiceInterface {
  FreeDashboardRepositoryInterface freeDashboardRepositoryInterface;

  FreeDashboardService({required this.freeDashboardRepositoryInterface});
  @override
  Future<ApiResponse> changePassword(Map<String, dynamic> body) {
    return freeDashboardRepositoryInterface.changePassword(body);
  }
}
