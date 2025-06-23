import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tribe365_new/feature/paid_version/home/domain/models/amazingawardusermodel.dart';
import 'package:tribe365_new/utill/images.dart';
import '../../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../../data/model/api_response.dart';
import '../../../../helper/api_checker.dart';
import '../../../../main.dart';
import '../domain/models/daydata.dart';
import '../domain/models/view_notification_count_response.dart';
import '../domain/models/viewhomeresponse.dart';
import '../domain/services/home_service_interface.dart';

class HomeController extends ChangeNotifier {
  final HomeServiceInterface? homeServiceInterface;

  HomeController({required this.homeServiceInterface});

  bool _isPopupLoading = false;
  bool get isPopupLoading => _isPopupLoading;

  TextEditingController searchController = TextEditingController();
  FocusNode searchFocus = FocusNode();
  ViewHomeData? homeData;
 String? notificationCount;
  bool isAbsentVisible = false;
  bool isHappyIndexStatus = false;
  String orgId = "";
  String userId = "";

  final List<DayData> weekData = [
    DayData(day: 'Sun', date: '01'),
    DayData(day: 'Mon', date: '02', mood: Icons.sentiment_dissatisfied),
    DayData(day: 'Tue', date: '03', mood: Icons.sentiment_dissatisfied),
    DayData(day: 'Wed', date: ''),
    DayData(day: 'Thu', date: ''),
    DayData(day: 'Fri', date: ''),
    DayData(day: 'Sat', date: ''),
  ];

  List<AmazingAwardUserModel> allUsers = [
    AmazingAwardUserModel(name: "Alice"),
    AmazingAwardUserModel(name: "Bob"),
    AmazingAwardUserModel(name: "Charlie"),
    AmazingAwardUserModel(name: "Daisy"),
  ];

  List<AmazingAwardUserModel> filteredUsers = [];

  viewFilteredUsersList(bool isNotify) {
    filteredUsers = List.from(allUsers);
    if (isNotify) {
      notifyListeners();
    }
  }

  intiData(bool isNotify) {
    searchController = TextEditingController();
    searchFocus = FocusNode();
    if (isNotify) {
      notifyListeners();
    }
  }

  void filterUsers() {
    final query = searchController.text.toLowerCase();
    filteredUsers = allUsers.where((user) => user.name.toLowerCase().contains(query)).toList();
    notifyListeners();
  }

  void toggleSelection(int index) {
    filteredUsers[index].isSelected = !filteredUsers[index].isSelected;

    final actualIndex = allUsers.indexWhere((u) => u.name == filteredUsers[index].name);
    if (actualIndex != -1) {
      allUsers[actualIndex].isSelected = filteredUsers[index].isSelected;
    }
    notifyListeners();
  }
  void pickStartDate(BuildContext context, String type) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      if (type == "start") {
        selectedStartDate = DateFormat('dd-MMM-yyyy').format(date);
      } else if (type == "end") {
        selectedEndDate = DateFormat('dd-MMM-yyyy').format(date);
      }
      notifyListeners();
    }
  }
  int getDeviceType() {
    if (kIsWeb) {
      return 0; // Web (you can return any code you want, e.g. 3 for Web)
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 1; // Android
      case TargetPlatform.iOS:
        return 2; // iOS
      default:
        return 0; // Unknown or unsupported platform
    }
  }
  String showEngValue = "";
  String imagePath = Images.imgLowRed; // default
  Color textColor = Colors.red; // default
  double animatedValue = 150;
  String selectedStartDate = DateFormat('dd-MMM-yyyy').format(DateTime.now());
  String selectedEndDate = "";
  final DateFormat dateDDMMMYYYYFormatter = DateFormat('dd-MMM-yyyy');

  void indexEngScoreData(String engValue) {
    double indexEngScore = double.tryParse(engValue) ?? 0.0;
    String trimmedValue = _trimTrailingZeros(engValue);

    String newImagePath;
    Color newTextColor;

    if (indexEngScore <= 499) {
      newImagePath = Images.imgLowRed;
      newTextColor = Colors.red; // R.color.motion_index_low
    } else if (indexEngScore >= 500 && indexEngScore <= 1099) {
      newImagePath = Images.imgMediumYellow;
      newTextColor = Colors.orange; // R.color.motion_index_medium
    } else {
      newImagePath = Images.imgSmileGreenBig;
      newTextColor = Colors.green; // R.color.motion_index_high
    }

    showEngValue = trimmedValue;
    imagePath = newImagePath;
    textColor = newTextColor;
    animatedValue = 600;
    notifyListeners();
  }
  void updateUserID(int? id) {
    userId = id.toString();
    notifyListeners();
  }
  String _trimTrailingZeros(String value) {
    // Example trimming logic
    if (value.contains(".")) {
      value = value.replaceAll(RegExp(r'0*$'), '');
      value = value.replaceAll(RegExp(r'\.$'), '');
    }
    return value;
  }
  void getHappyIndexBlink(int? leaveStatus) {
    if (leaveStatus != 1  && checkTime()) {
      isHappyIndexStatus = true;
    } else {
      isHappyIndexStatus = false;
    }
    notifyListeners();
  }
  void updateDate() {
    selectedStartDate = DateFormat('dd-MMM-yyyy').format(DateTime.now());
    selectedEndDate = "";
    notifyListeners();
  }

  bool checkTime() {
    try {
      final now = DateTime.now();
      final startTime = TimeOfDay(hour: 16, minute: 0);
      final endTime = TimeOfDay(hour: 23, minute: 59);
      final currentMinutes = now.hour * 60 + now.minute;
      final startMinutes = startTime.hour * 60 + startTime.minute;
      final endMinutes = endTime.hour * 60 + endTime.minute;

      return currentMinutes >= startMinutes && currentMinutes < endMinutes;
    } catch (e) {
      debugPrint('Error in checkTime: $e');
      return false;
    }
  }

  //API calling
  Future<void> getHomeData(String orgId) async {
    Map<String, dynamic> request = {
      "orgId": orgId,
      "deviceType": getDeviceType().toString(),
    };
    ApiResponse apiResponse = await homeServiceInterface!.getHomeData(request);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewHomeResponse homeResponse = ViewHomeResponse.fromJson(map);
      homeData = homeResponse.data;
      indexEngScoreData(homeData!.todayEIScore!);
      getHappyIndexBlink(homeData!.leaveStatus);
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> viewNotificationCount(String userId) async {
    Map<String, dynamic> request = {
      "userId": userId,
    };
    ApiResponse apiResponse = await homeServiceInterface!.viewNotificationsCount(request);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewNotificationCountResponse response = ViewNotificationCountResponse.fromJson(map);
      notificationCount =  response.data!.notificationCount.toString();
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> userApplyLeave(String startDate, String endDate) async {
    Map<String, dynamic> requestData = {
      "userId": userId,
      "startDate": startDate,
      "endDate":endDate
    };

    ApiResponse apiResponse = await homeServiceInterface!.userApplyLeave(requestData);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      showCustomSnackBar(map["message"], Get.context!, isError: false);
      isAbsentVisible = true;
      isHappyIndexStatus = false;
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> userChangeLeaveStatus() async {
    _isPopupLoading = true;
    notifyListeners();
    Map<String, dynamic> requestData = {
      "userId": userId,
    };

    ApiResponse apiResponse = await homeServiceInterface!.userChangeLeaveStatus(requestData);
    _isPopupLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      showCustomSnackBar(map["message"], Get.context!, isError: false);
      Navigator.of(Get.context!).pop();
      getHomeData(orgId);
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> addHappyIndex(String status) async {
    Map<String, dynamic> requestData = {
      "userId": userId,
      "moodStatus": status,
    };
    ApiResponse apiResponse = await homeServiceInterface!.addHappyIndex(requestData);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      showCustomSnackBar(map["message"], Get.context!, isError: false);
      isHappyIndexStatus = false;
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

}
