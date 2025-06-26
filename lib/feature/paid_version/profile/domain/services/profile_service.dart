

import '../../../../../data/model/api_response.dart';
import '../repositories/profile_repository_interface.dart';
import 'profile_service_interface.dart';

class ProfileService implements ProfileServiceInterface {
  ProfileRepositoryInterface profileRepositoryInterface;

  ProfileService({required this.profileRepositoryInterface});

  @override
  Future<ApiResponse> viewUserProfileData() {
    return profileRepositoryInterface.viewUserProfileData();
  }
  @override
  String getUserToken() {
    return profileRepositoryInterface.getUserToken();
  }


  @override
  Future<ApiResponse> updateProfile(Map<String, dynamic> body) {
    return profileRepositoryInterface.updateProfile(body);
  }
  @override
  Future<ApiResponse> viewQuestionsList() {
    return profileRepositoryInterface.viewQuestionsList();
  }
}
