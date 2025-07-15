import '../../../../../data/model/api_response.dart';

abstract class RiskServiceInterface {
  Future<ApiResponse> viewRiskRegisterList(Map<String, dynamic> body);
  Future<ApiResponse> viewRiskDetail(Map<String, dynamic> body);
}
