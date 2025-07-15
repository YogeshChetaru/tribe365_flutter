import '../../../../../data/model/api_response.dart';
import '../repositories/risk_repository_interface.dart';
import 'risk_service_interface.dart';

class RiskService implements RiskServiceInterface {
  RiskRepositoryInterface riskRepositoryInterface;

  RiskService({required this.riskRepositoryInterface});

  @override
  Future<ApiResponse> viewRiskRegisterList(Map<String, dynamic> body) {
    return riskRepositoryInterface.viewRiskRegisterList(body);
  }

  @override
  Future<ApiResponse> viewRiskDetail(Map<String, dynamic> body) {
    return riskRepositoryInterface.viewRiskDetail(body);
  }

}
