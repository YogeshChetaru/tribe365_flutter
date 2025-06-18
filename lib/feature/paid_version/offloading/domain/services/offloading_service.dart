import '../../../../../data/model/api_response.dart';
import '../repositories/offloading_repository_interface.dart';
import 'offloading_service_interface.dart';

class OffloadingService implements OffloadingServiceInterface {
  OffloadingRepositoryInterface offloadingRepositoryInterface;

  OffloadingService({required this.offloadingRepositoryInterface});
  @override
  Future<ApiResponse> sendOffloadingData(Map<String, dynamic> body) {
    return offloadingRepositoryInterface.sendOffloadingData(body);
  }
  @override
  Future<ApiResponse> viewOffloadingFirstData(Map<String, dynamic> body) {
    return offloadingRepositoryInterface.viewOffloadingFirstData(body);
  }

  @override
  Future<ApiResponse> viewHptmReflectionData(Map<String, dynamic> body) {
    return offloadingRepositoryInterface.viewHptmReflectionData(body);
  }

  @override
  Future<ApiResponse> viewChatMessages(Map<String, dynamic> body) {
    return offloadingRepositoryInterface.viewChatMessages(body);
  }
  @override
  Future<ApiResponse> sendChatMessages(Map<String, dynamic> body) {
    return offloadingRepositoryInterface.sendChatMessages(body);
  }

  @override
  Future<ApiResponse> sendHPTMReflection(Map<String, dynamic> body) {
    return offloadingRepositoryInterface.sendHPTMReflection(body);
  }


}
