import '../../../../../data/model/api_response.dart';

abstract class HPTMServiceInterface {
  Future<ApiResponse> viewHPTMPrinciplesList();
  Future<ApiResponse> viewHPTMLearningCheckList(Map<String, dynamic> loginBody);
  Future<ApiResponse> updateHPTMLearningCheckListStatus(Map<String, dynamic> loginBody);
}
