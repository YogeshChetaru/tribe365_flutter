

import '../../../../../data/model/api_response.dart';
import '../../../../../interface/repo_interface.dart';

abstract class HomeRepositoryInterface implements RepositoryInterface {
  Future<ApiResponse> getHomeData(Map<String, dynamic> body);
  Future<ApiResponse> viewNotificationsCount(Map<String, dynamic> body);
  Future<ApiResponse> userApplyLeave(Map<String, dynamic> body);
  Future<ApiResponse> userChangeLeaveStatus(Map<String, dynamic> body);
  Future<ApiResponse> addHappyIndex(Map<String, dynamic> body);
}
