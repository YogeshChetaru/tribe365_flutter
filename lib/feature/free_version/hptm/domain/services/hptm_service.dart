import 'package:tribe365_new/data/model/api_response.dart';

import '../repositories/hptm_repository_interface.dart';
import 'hptm_service_interface.dart';

class HPTMService implements HPTMServiceInterface {
  HPTMRepositoryInterface hptmRepositoryInterface;

  HPTMService({required this.hptmRepositoryInterface});

  @override
  Future<ApiResponse> viewHPTMPrinciplesList() {
    return hptmRepositoryInterface.viewHPTMPrinciplesList();
  }

  @override
  Future<ApiResponse> viewHPTMLearningCheckList(Map<String, dynamic> loginBody) {
    return hptmRepositoryInterface.viewHPTMLearningCheckList(loginBody);
  }

  @override
  Future<ApiResponse> updateHPTMLearningCheckListStatus(Map<String, dynamic> loginBody) {
    return hptmRepositoryInterface.updateHPTMLearningCheckListStatus(loginBody);
  }
}
