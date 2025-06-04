import '../repositories/profile_repository_interface.dart';
import 'profile_service_interface.dart';

class ProfileService implements ProfileServiceInterface {
  ProfileRepositoryInterface profileRepositoryInterface;

  ProfileService({required this.profileRepositoryInterface});
}
