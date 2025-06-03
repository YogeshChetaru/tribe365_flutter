import '../repositories/hptm_repository_interface.dart';
import 'hptm_service_interface.dart';

class HPTMService implements HPTMServiceInterface {
  HPTMRepositoryInterface hptmRepositoryInterface;

  HPTMService({required this.hptmRepositoryInterface});
}
