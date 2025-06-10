

import 'dart:io';

import '../../../../../data/model/api_response.dart';
import '../../../../../interface/repo_interface.dart';

abstract class ProfileRepositoryInterface implements RepositoryInterface {
  Future<ApiResponse> viewUserProfileData();
  String getUserToken();
  Future<ApiResponse> updateProfile(Map<String, dynamic> body);
}
