abstract class HomeServiceInterface {
  Future<dynamic> getHomeData(Map<String, dynamic> body);
  Future<dynamic> viewNotificationsCount(Map<String, dynamic> body);
  Future<dynamic> userApplyLeave(Map<String, dynamic> body);
  Future<dynamic> userChangeLeaveStatus(Map<String, dynamic> body);
  Future<dynamic> addHappyIndex(Map<String, dynamic> body);
  Future<dynamic> postFeedback(Map<String, dynamic> body);
  Future<dynamic> getCurrentVersionOfApp(Map<String, dynamic> body);
  Future<dynamic> getDotDetail(Map<String, dynamic> body);
  Future<dynamic> getDepartmentUserList(Map<String, dynamic> body);
  Future<dynamic> addKudosAward(Map<String, dynamic> body);
  Future<dynamic> addRatingsToDotValues(Map<String, dynamic> body);
  Future<dynamic> viewHomeKudosCount(Map<String, dynamic> body);
  Future<dynamic> addKudosAwardMultiUser(Map<String, dynamic> body);
  Future<void> savePushNotificationStatus(bool userData);
  bool getPushNotificationStatus();
}
