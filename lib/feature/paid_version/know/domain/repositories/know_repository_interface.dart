

import '../../../../../data/model/api_response.dart';
import '../../../../../interface/repo_interface.dart';

abstract class KnowRepositoryInterface implements RepositoryInterface {
  Future<ApiResponse> viewKnowOrganisationData(Map<String, dynamic> body);
  Future<ApiResponse> viewOfficeList(Map<String, dynamic> body);
  Future<ApiResponse> viewDepartmentList();
}
