import '../../../../../data/model/api_response.dart';
import '../../../../../interface/repo_interface.dart';

abstract class HPTMRepositoryInterface implements RepositoryInterface {
  Future<ApiResponse> viewHPTMPrinciplesList();
  Future<ApiResponse> viewHPTMLearningCheckList(Map<String, dynamic> loginBody);
  Future<ApiResponse> updateHPTMLearningCheckListStatus(Map<String, dynamic> loginBody);
}
