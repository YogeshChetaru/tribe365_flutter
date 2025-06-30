

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
  Future<ApiResponse> viewMotivationList() {
    return profileRepositoryInterface.viewMotivationList();
  }

  @override
  Future<ApiResponse> viewMotivationCompletedAnswerList() {
    return profileRepositoryInterface.viewMotivationCompletedAnswerList();
  }


  @override
  Future<ApiResponse> viewCompletedQuestionsList() {
    return profileRepositoryInterface.viewCompletedQuestionsList();
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
  Future<void> saveUserMotivationData(String userData) {
    return profileRepositoryInterface.saveUserMotivationData(userData);
  }

  @override
  String getUserTeamRoleData() {
    return profileRepositoryInterface.getUserTeamRoleData();
  }

  @override
  String getUserMotivationData() {
    return profileRepositoryInterface.getUserMotivationData();
  }


  @override
  Future<ApiResponse> sendTeamRoleData(Map<String, dynamic> body) {
    return profileRepositoryInterface.sendTeamRoleData(body);
  }

  @override
  Future<ApiResponse> sendTeamRoleDataUpdate(Map<String, dynamic> body) {
    return profileRepositoryInterface.sendTeamRoleDataUpdate(body);
  }

  @override
  Future<void> clearSavedUserTeamRoleData() {
    return profileRepositoryInterface.clearSavedUserTeamRoleData();
  }

  @override
  Future<void> clearSavedUserMotivationData() {
    return profileRepositoryInterface.clearSavedUserMotivationData();
  }

  @override
  Future<ApiResponse> sendMotivationData(Map<String, dynamic> body) {
    return profileRepositoryInterface.sendMotivationData(body);
  }



  @override
  Future<void> viewSOTmotivationUserList(Map<String, dynamic> loginBody) {
    return profileRepositoryInterface.viewSOTmotivationUserList(loginBody);
  }

  @override
  Future<void> viewCOTindividualSummary() {
    return profileRepositoryInterface.viewCOTindividualSummary();
  }
}
