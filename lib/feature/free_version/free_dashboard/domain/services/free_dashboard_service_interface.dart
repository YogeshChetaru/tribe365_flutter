abstract class FreeDashboardServiceInterface {
  Future<dynamic> changePassword(Map<String, dynamic> body);
  Future<dynamic> viewDepartmentList();
  Future<dynamic> getHomePageDetails(Map<String, dynamic> body);
  Future<dynamic> viewOfficeList(Map<String, dynamic> body);
  Future<dynamic> userApplyLeave(Map<String, dynamic> body);
}
