abstract class HomeServiceInterface {
  Future<dynamic> getHomeData(Map<String, dynamic> body);
  Future<dynamic> viewNotificationsCount(Map<String, dynamic> body);
  Future<dynamic> userApplyLeave(Map<String, dynamic> body);
  Future<dynamic> userChangeLeaveStatus(Map<String, dynamic> body);
  Future<dynamic> addHappyIndex(Map<String, dynamic> body);
}
