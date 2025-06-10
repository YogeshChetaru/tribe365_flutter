import '../../../../../data/model/api_response.dart';
import '../../../../../interface/repo_interface.dart';

abstract class FreeDashboardRepositoryInterface implements RepositoryInterface {
  Future<ApiResponse> changePassword(Map<String, dynamic> body);
}
