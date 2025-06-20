import '../../../../../data/model/api_response.dart';
import '../repositories/know_repository_interface.dart';
import 'know_service_interface.dart';

class KnowService implements KnowServiceInterface {
  KnowRepositoryInterface knowRepositoryInterface;

  KnowService({required this.knowRepositoryInterface});
  @override
  Future<ApiResponse> viewKnowOrganisationData(Map<String, dynamic> body) {
    return knowRepositoryInterface.viewKnowOrganisationData(body);
  }
  @override
  Future<ApiResponse> viewOfficeList(Map<String, dynamic> body) {
    return knowRepositoryInterface.viewOfficeList(body);
  }
  @override
  Future<ApiResponse> viewDepartmentList() {
    return knowRepositoryInterface.viewDepartmentList();
  }
  @override
  Future<ApiResponse> viewUserByType(Map<String, dynamic> body) {
    return knowRepositoryInterface.viewUserByType(body);
  }

  @override
  Future<ApiResponse> viewKudosAward(Map<String, dynamic> body) {
    return knowRepositoryInterface.viewKudosAward(body);
  }
  @override
  Future<ApiResponse> viewKnowMemberDetails(Map<String, dynamic> body) {
    return knowRepositoryInterface.viewKnowMemberDetails(body);
  }
}
