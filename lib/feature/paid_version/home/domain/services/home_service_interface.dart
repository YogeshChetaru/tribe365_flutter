abstract class HomeServiceInterface {
  Future<dynamic> getHomeData(Map<String, dynamic> body);
  Future<dynamic> viewNotificationsCount(Map<String, dynamic> body);
}
