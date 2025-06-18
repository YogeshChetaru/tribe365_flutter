import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../data/datasource/remote/dio/dio_client.dart';
import '../../../../../data/datasource/remote/exception/api_error_handler.dart';
import '../../../../../data/model/api_response.dart';
import '../../../../../utill/app_constants.dart';
import 'know_repository_interface.dart';

class KnowRepository implements KnowRepositoryInterface {
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;

  KnowRepository({required this.dioClient, required this.sharedPreferences});

  @override
  Future<ApiResponse> viewKnowOrganisationData(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.viewKnowOrganisationDetailsUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> viewOfficeList(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.getAllOfficeDepartmentsUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> viewDepartmentList() async {
    try {
      Response response = await dioClient!.get(
        AppConstants.getDepartmentListUri,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future add(value) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future get(String id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future getList({int? offset = 1}) {
    // TODO: implement getList
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body, int id) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
