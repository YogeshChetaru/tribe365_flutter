abstract class OffloadingServiceInterface {
  Future<dynamic> sendOffloadingData(Map<String, dynamic> body);
  Future<dynamic> viewOffloadingFirstData(Map<String, dynamic> body);
  Future<dynamic> sendHPTMReflection(Map<String, dynamic> body);
  Future<dynamic> viewHptmReflectionData(Map<String, dynamic> body);
  Future<dynamic> viewChatMessages(Map<String, dynamic> body);
  Future<dynamic> sendChatMessages(Map<String, dynamic> body);
}
