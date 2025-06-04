import '../repositories/know_repository_interface.dart';
import 'know_service_interface.dart';

class KnowService implements KnowServiceInterface {
  KnowRepositoryInterface knowRepositoryInterface;

  KnowService({required this.knowRepositoryInterface});
}
