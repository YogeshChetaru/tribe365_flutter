

import '../../../../../data/model/api_response.dart';
import '../../../../../interface/repo_interface.dart';

abstract class OffloadingRepositoryInterface implements RepositoryInterface {
  Future<ApiResponse> sendOffloadingData(Map<String, dynamic> body);
  Future<ApiResponse> viewOffloadingFirstData(Map<String, dynamic> body);
  Future<ApiResponse> sendHPTMReflection(Map<String, dynamic> body);
  Future<ApiResponse> viewHptmReflectionData(Map<String, dynamic> body);
  Future<ApiResponse> viewChatMessages(Map<String, dynamic> body);
  Future<ApiResponse> sendChatMessages(Map<String, dynamic> body);
}
