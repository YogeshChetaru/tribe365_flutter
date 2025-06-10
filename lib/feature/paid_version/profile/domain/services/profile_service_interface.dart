import 'dart:io';

abstract class ProfileServiceInterface {
  Future<dynamic> viewUserProfileData();
  String getUserToken();
  Future<dynamic> updateProfile(Map<String, dynamic> body);
}
