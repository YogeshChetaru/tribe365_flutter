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

  @override
  Future<ApiResponse> getHomePageDetails(Map<String, dynamic> body) {
    return freeDashboardRepositoryInterface.getHomePageDetails(body);
  }
  @override
  Future<ApiResponse> viewOfficeList(Map<String, dynamic> body) {
    return freeDashboardRepositoryInterface.viewOfficeList(body);
  }

  @override
  Future<ApiResponse> userApplyLeave(Map<String, dynamic> body) {
    return freeDashboardRepositoryInterface.userApplyLeave(body);
  }

  @override
  Future<ApiResponse> userChangeLeaveStatus(Map<String, dynamic> body) {
    return freeDashboardRepositoryInterface.userChangeLeaveStatus(body);
  }

  @override
  Future<ApiResponse> addHappyIndex(Map<String, dynamic> body) {
    return freeDashboardRepositoryInterface.addHappyIndex(body);
  }

  @override
  Future<ApiResponse> updatePushNotificationStatus(Map<String, dynamic> body) {
    return freeDashboardRepositoryInterface.updatePushNotificationStatus(body);
  }


  @override
  Future<ApiResponse> viewDepartmentList() {
    return freeDashboardRepositoryInterface.viewDepartmentList();
  }
}
