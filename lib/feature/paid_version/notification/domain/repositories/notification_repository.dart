import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../data/datasource/remote/dio/dio_client.dart';
import '../../../../../data/datasource/remote/exception/api_error_handler.dart';
import '../../../../../data/model/api_response.dart';
import '../../../../../utill/app_constants.dart';
import 'notification_repository_interface.dart';

class NotificationRepository implements NotificationRepositoryInterface {
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;

  NotificationRepository({required this.dioClient, required this.sharedPreferences});

  @override
  Future<ApiResponse> viewUnReadNotificationList(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.getBubbleRatingUnReadNotificationListUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponse> viewNotificationList(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.getBubbleRatingNotificationListUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> readAllNotification(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.readAllNotificationUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> updateNotificationStatus(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.changeNotificationStatusUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> viewHomeKudosCount(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.getHomePageKudosCountUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponse> viewKudosAwardDetail() async {
    try {
      Response response = await dioClient!.post(
        AppConstants.dotValueKudosAwardDetailUri,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> viewTeamFeedbackUserAnswerStatus(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.teamFeedbackUserAnswerStatusUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponse> viewIndividualQuestionnaireList(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.viewIndividualQuestionnaireListUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponse> sendIndividualQuestionnaireList(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.addIndividualQuestionnaireAnswersUri,
        data: loginBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponse> viewKudoAwardDetail(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.kudosAwardDetailUri,
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
