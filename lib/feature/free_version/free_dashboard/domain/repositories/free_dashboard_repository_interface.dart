import '../../../../../data/model/api_response.dart';
import '../../../../../interface/repo_interface.dart';

abstract class FreeDashboardRepositoryInterface implements RepositoryInterface {
  Future<ApiResponse> changePassword(Map<String, dynamic> body);
  Future<ApiResponse> viewDepartmentList();
  Future<ApiResponse> getHomePageDetails(Map<String, dynamic> body);
  Future<ApiResponse> viewOfficeList(Map<String, dynamic> body);
  Future<ApiResponse> userApplyLeave(Map<String, dynamic> body);
}
