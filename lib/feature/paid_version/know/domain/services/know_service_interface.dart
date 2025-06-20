import '../../../../../data/model/api_response.dart';

abstract class KnowServiceInterface {
  Future<ApiResponse> viewKnowOrganisationData(Map<String, dynamic> body);
  Future<dynamic> viewDepartmentList();
  Future<dynamic> viewOfficeList(Map<String, dynamic> body);
  Future<dynamic> viewUserByType(Map<String, dynamic> body);
  Future<dynamic> viewKudosAward(Map<String, dynamic> body);
  Future<dynamic> viewKnowMemberDetails(Map<String, dynamic> body);
}
