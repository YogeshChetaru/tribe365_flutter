import 'dart:io';

import 'package:flutter/material.dart' hide Feedback;
import 'package:tribe365_new/feature/paid_version/profile/domain/models/viewuserprofileresponse.dart';
import '../../../../data/model/api_response.dart';
import '../domain/models/view_message_details_response.dart';
import '../domain/models/view_offloading_list_response.dart';
import '../domain/models/view_reflection_chat_messages_response.dart';
import '../domain/models/view_reflection_list_response.dart';
import '../domain/services/offloading_service_interface.dart';

class OffloadingController extends ChangeNotifier {
  final OffloadingServiceInterface? offloadingServiceInterface;

  OffloadingController({required this.offloadingServiceInterface});

  bool _isLoadingData = false;

  bool get isLoadingData => _isLoadingData;

  bool _isLoadingBtn = false;

  bool get isLoadingBtn => _isLoadingBtn;

  bool isType = true;
  String orgId = "";
  String userId = "";

  List<ViewOffLoadingListData>? offLoadingList;
  List<ViewReflectionListData>? reflectionList;
  List<Messages>? messagesList;
  List<ViewReflectionChatMessages>? reflectionMessagesList;
  Reflection? reflectionData;
  Feedback? feedbackData;

  TextEditingController tellUsController = TextEditingController();
  FocusNode tellUsFocus = FocusNode();
  File? file;
  int pageStart = 1;
  int totalPage = 0;
  int currentPage = 1;

  void initData() {
    tellUsController = TextEditingController();
    tellUsFocus = FocusNode();
    file = null;
  }

  void updateIsType(String s) {
    if (s == 'offloading') {
      isType = true;
    } else {
      isType = false;
    }
    notifyListeners();
  }

  void updateData(ViewUserProfileData? userProfileData) {
    orgId = userProfileData!.orgId.toString();
    userId = userProfileData.id.toString();
    notifyListeners();
  }

  void updateInitData() {
    tellUsController.text = "";
    file = null;
    notifyListeners();
  }

  void updateFileData(File data) {
    file = data;
    notifyListeners();
  }

  //API Calling---------
  Future<ApiResponse> sendOffloadingData(String message, String image) async {
    _isLoadingBtn = true;
    notifyListeners();
    Map<String, dynamic> request = {"message": message, "userId": userId, "orgId": orgId, "image": image};
    ApiResponse apiResponse = await offloadingServiceInterface!.sendOffloadingData(request);
    _isLoadingBtn = false;
    notifyListeners();
    return apiResponse;
  }

  Future<ApiResponse> sendHPTMReflection(String message) async {
    _isLoadingBtn = true;
    notifyListeners();
    Map<String, dynamic> request = {"message": message, "userId": userId, "orgId": orgId, "image": ""};
    ApiResponse apiResponse = await offloadingServiceInterface!.sendHPTMReflection(request);
    _isLoadingBtn = false;
    notifyListeners();
    return apiResponse;
  }

  Future<ApiResponse> viewOffloadingFirstData() async {
    _isLoadingData = true;
    notifyListeners();
    Map<String, dynamic> request = {"userId": userId, "page": currentPage};
    ApiResponse apiResponse = await offloadingServiceInterface!.viewOffloadingFirstData(request);
    _isLoadingData = false;
    Map<String, dynamic> map = apiResponse.response!.data;
    ViewOffLoadingListResponse response = ViewOffLoadingListResponse.fromJson(map);
    offLoadingList = [];
    offLoadingList = response.data;
    notifyListeners();
    return apiResponse;
  }

  Future<ApiResponse> viewHptmReflectionData() async {
    _isLoadingData = true;
    notifyListeners();
    Map<String, dynamic> request = {"userId": userId};
    ApiResponse apiResponse = await offloadingServiceInterface!.viewHptmReflectionData(request);
    _isLoadingData = false;
    Map<String, dynamic> map = apiResponse.response!.data;
    ViewReflectionListResponse response = ViewReflectionListResponse.fromJson(map);
    reflectionList = [];
    reflectionList = response.data;
    notifyListeners();
    return apiResponse;
  }

  Future<ApiResponse> viewChatMessages(int feedbackId) async {
    Map<String, dynamic> request = {"feedbackId": feedbackId};
    ApiResponse apiResponse = await offloadingServiceInterface!.viewChatMessages(request);
    Map<String, dynamic> map = apiResponse.response!.data;
    ViewMessageDetailsResponse response = ViewMessageDetailsResponse.fromJson(map);
    messagesList = [];
    messagesList = response.data!.messages!;
    feedbackData = response.data!.feedback!;
    notifyListeners();
    return apiResponse;
  }

  Future<ApiResponse> sendChatMessages(String msgType, String message, String feedbackId) async {
    _isLoadingData = true;
    notifyListeners();
    Map<String, dynamic> request = {"sendFrom": userId, "sendTo": "1", "message": message, "feedbackId": feedbackId, "postType": msgType};
    ApiResponse apiResponse = await offloadingServiceInterface!.sendChatMessages(request);
    _isLoadingData = false;
    updateInitData();
    viewChatMessages(int.parse(feedbackId.toString()));
    notifyListeners();
    return apiResponse;
  }

  Future<ApiResponse> viewReflectionChatMessages(int feedbackId) async {
    Map<String, dynamic> request = {"reflectionId": feedbackId};
    ApiResponse apiResponse = await offloadingServiceInterface!.viewReflectionChatMessages(request);
    Map<String, dynamic> map = apiResponse.response!.data;
    ViewReflectionChatMessagesResponse response = ViewReflectionChatMessagesResponse.fromJson(map);
    reflectionMessagesList = [];
    reflectionMessagesList = response.data!.messages!;
    reflectionData = response.data!.reflection;
    notifyListeners();
    return apiResponse;
  }

  Future<ApiResponse> reflectionSendChatMessages(String msgType, String message, String feedbackId) async {
    _isLoadingData = true;
    notifyListeners();
    Map<String, dynamic> request = {"sendFrom": userId, "sendTo": "1", "message": message, "reflectionId": feedbackId, "postType": msgType};
    ApiResponse apiResponse = await offloadingServiceInterface!.reflectionSendChatMessages(request);
    _isLoadingData = false;
    updateInitData();
    viewReflectionChatMessages(int.parse(feedbackId.toString()));
    notifyListeners();
    return apiResponse;
  }
}
