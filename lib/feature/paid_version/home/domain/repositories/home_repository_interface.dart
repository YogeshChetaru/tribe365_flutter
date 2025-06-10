

import '../../../../../data/model/api_response.dart';
import '../../../../../interface/repo_interface.dart';

abstract class HomeRepositoryInterface implements RepositoryInterface {
  Future<ApiResponse> getHomeData(Map<String, dynamic> body);
}
