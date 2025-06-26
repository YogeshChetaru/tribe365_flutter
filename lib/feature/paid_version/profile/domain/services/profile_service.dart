

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

  @override
  Future<ApiResponse> getCOTMapperSummary() {
    return profileRepositoryInterface.getCOTMapperSummary();
  }

  @override
  Future<void> saveUserTeamRoleData(String userData) {
    return profileRepositoryInterface.saveUserTeamRoleData(userData);
  }

  @override
  String getUserTeamRoleData() {
    return profileRepositoryInterface.getUserTeamRoleData();
  }

  @override
  Future<ApiResponse> sendTeamRoleData(Map<String, dynamic> body) {
    return profileRepositoryInterface.sendTeamRoleData(body);
  }

  @override
  Future<void> clearSavedUserTeamRoleData() {
    return profileRepositoryInterface.clearSavedUserTeamRoleData();
  }

  @override
  Future<void> viewCOTindividualSummary() {
    return profileRepositoryInterface.viewCOTindividualSummary();
  }
}
