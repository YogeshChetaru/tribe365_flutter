import '../repositories/risk_repository_interface.dart';
import 'risk_service_interface.dart';

class RiskService implements RiskServiceInterface {
  RiskRepositoryInterface riskRepositoryInterface;

  RiskService({required this.riskRepositoryInterface});
}
