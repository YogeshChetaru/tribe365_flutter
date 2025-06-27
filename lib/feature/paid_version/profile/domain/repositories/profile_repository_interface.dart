import '../../../../../data/model/api_response.dart';
import '../../../../../interface/repo_interface.dart';

abstract class ProfileRepositoryInterface implements RepositoryInterface {
  Future<ApiResponse> viewUserProfileData();
  Future<ApiResponse> viewQuestionsList();
  Future<ApiResponse> viewMotivationList();
  Future<ApiResponse> viewCompletedQuestionsList();
  Future<ApiResponse> getCOTMapperSummary();
  Future<ApiResponse> viewCOTindividualSummary();
  String getUserToken();
  Future<ApiResponse> updateProfile(Map<String, dynamic> body);
  Future<ApiResponse> sendTeamRoleData(Map<String, dynamic> body);
  Future<ApiResponse> sendTeamRoleDataUpdate(Map<String, dynamic> body);
  Future<void> saveUserTeamRoleData(String userData);
  String getUserTeamRoleData();
  Future<void> clearSavedUserTeamRoleData();
}
