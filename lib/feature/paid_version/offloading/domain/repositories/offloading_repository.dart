import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../data/datasource/remote/dio/dio_client.dart';
import '../../../../../data/datasource/remote/exception/api_error_handler.dart';
import '../../../../../data/model/api_response.dart';
import '../../../../../utill/app_constants.dart';
import 'offloading_repository_interface.dart';

class OffloadingRepository implements OffloadingRepositoryInterface {
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;

  OffloadingRepository({required this.dioClient, required this.sharedPreferences});

  @override
  Future<ApiResponse> sendOffloadingData(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.postFeedbackUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> sendHPTMReflection(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.postHPTMReflectionUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponse> viewOffloadingFirstData(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.getFeedbackDetailUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> viewHptmReflectionData(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.getHptmReflectionDetailUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> viewChatMessages(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.getChatMessagesUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> viewReflectionChatMessages(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.getReflectionChatMessagesUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponse> sendChatMessages(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.iotSendMsgUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponse> reflectionSendChatMessages(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.sendReflectionChatMessageUri,
        data: loginBody,
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
