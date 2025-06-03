import '../repositories/paid_dashboard_repository_interface.dart';
import 'paid_dashboard_service_interface.dart';

class PaidDashboardService implements PaidDashboardServiceInterface {
  PaidDashboardRepositoryInterface paidDashboardRepositoryInterface;

  PaidDashboardService({required this.paidDashboardRepositoryInterface});
}
