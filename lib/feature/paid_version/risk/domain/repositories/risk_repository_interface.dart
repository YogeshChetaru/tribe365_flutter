

import '../../../../../data/model/api_response.dart';
import '../../../../../interface/repo_interface.dart';

abstract class RiskRepositoryInterface implements RepositoryInterface {
  Future<ApiResponse> viewRiskRegisterList(Map<String, dynamic> body);
  Future<ApiResponse> viewRiskDetail(Map<String, dynamic> body);
}
