import '../repositories/offloading_repository_interface.dart';
import 'offloading_service_interface.dart';

class OffloadingService implements OffloadingServiceInterface {
  OffloadingRepositoryInterface offloadingRepositoryInterface;

  OffloadingService({required this.offloadingRepositoryInterface});
}
