import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/images.dart';
import 'package:tribe365_new/utill/utility.dart';
import '../../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../../data/model/api_response.dart';
import '../../../../helper/api_checker.dart';
import '../../../../main.dart';
import '../domain/models/daydata.dart';
import '../domain/models/view_department_user_list_response.dart';
import '../domain/models/view_dot_details_response.dart';
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
  ViewDotDetailsData? dotDetailsData;
  List<Belief>? beliefList;

 bool updateLayoutStatus = false;
  bool checkLater = false;
  bool homeVisionStatus = false;
  String? vision;
  String? visionUrl;
  String? visionDesc;

  bool isAbsentVisible = false;
  bool isHappyIndexStatus = false;
  String orgId = "";
  String userId = "";
  int amazingValue=0;
  String awardName="";

  final List<DayData> weekData = [
    DayData(day: 'Sun', date: '01'),
    DayData(day: 'Mon', date: '02', mood: Icons.sentiment_dissatisfied),
    DayData(day: 'Tue', date: '03', mood: Icons.sentiment_dissatisfied),
    DayData(day: 'Wed', date: ''),
    DayData(day: 'Thu', date: ''),
    DayData(day: 'Fri', date: ''),
    DayData(day: 'Sat', date: ''),
  ];

  List<ViewDepartmentUsers> filteredUsers = [];
  List<ViewDepartmentUsers> selectedUsersList = [];

  viewFilteredUsersList(bool isNotify) {
    filteredUsers = userList!;
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
    filteredUsers = userList!.where((user) => user.name!.toLowerCase().contains(query)).toList();
    notifyListeners();
  }

  void toggleSelection(int index) {
    filteredUsers[index].isSelected = !filteredUsers[index].isSelected;

    final actualIndex = userList!.indexWhere((u) => u.name == filteredUsers[index].name);
    if (actualIndex != -1) {
      userList![actualIndex].isSelected = filteredUsers[index].isSelected;
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
  void updateUserID(int? id,int? orgIdMain) {
    userId = id.toString();
    orgId = orgIdMain.toString();
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
  void showHappyIndex(bool feedbackStatus, int leaveStatus) {
    if (leaveStatus != 1) {
      if (!feedbackStatus && leaveStatus != 1) {
        if (checkTime()) {
          isHappyIndexStatus = true;
        } else {
          isHappyIndexStatus = false;
        }
      } else {
        isHappyIndexStatus = false;
      }
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

  void dialogGetFeedback(BuildContext context, String title, String todayEIScore) {
    final TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title.isEmpty ? getTranslated("offloading", context)! : getTranslated("sentiment_submit", context)!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: ColorResources.mainColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (title.isNotEmpty) ...[
                    SizedBox(height: 8),
                    Text(
                      getTranslated("engagement_index", context)!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Images.imgHappyEmoji,
                          width: 40,
                          height: 40,
                        ),
                        SizedBox(width: 8),
                        Text(
                          todayEIScore,
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      getTranslated("tell_us_more", context)!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 170,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: TextField(
                      controller: commentController,
                      maxLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        hintText: getTranslated("write_your_feedback_here", context),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      String msg = commentController.text.trim();
                      if (msg.isEmpty) {
                        showCustomSnackBar(getTranslated("please_enter_your_offloading_feedback", context)!, context,isError: true);
                        return;
                      }
                      Navigator.of(context).pop();
                      sendOffloading(msg);
                    },
                    child: Text(
                      'Send',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void dialogKudosSendResponse(BuildContext context, String title, String todayEIScore) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.transparent,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26)],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title.contains("kudosSend") ? getTranslated("kudos_sent", context)! : getTranslated("sentiment_submit", context)!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                // Subheading
                Text(
                  getTranslated("engagement_index", context)!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                // Icon and Score Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      todayEIScore,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }

  void updateAppStatus(String s) {
    if (s == "later") {
      checkLater = true;
      updateLayoutStatus = false;
    }
    else {
      checkLater = false;
      updateLayoutStatus = false;
      Utility.openAppInStore();
    }
      notifyListeners();
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
      showHappyIndex(homeData!.userGivenfeedback!, homeData!.leaveStatus!);
      int status= homeData!.leaveStatus!;
      if (status ==1) {
        isAbsentVisible = true;
      }else{
        isAbsentVisible = false;
      }

      if(homeData!.vision.toString()=="") {
        homeVisionStatus = false;
      }else{
        homeVisionStatus = true;
        vision = homeData!.vision;
        visionDesc = homeData!.visionDesc;
        visionUrl = homeData!.visionUrl;
      }

      amazingValue=homeData!.kudoAwardValue!;
      awardName=homeData!.kudoAwardKey!;


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
      String todayEIScore = map["data"]["todayEIScore"];
      indexEngScoreData(todayEIScore);
      //sentiment index user send not happy
      if (status=="1"){
        dialogGetFeedback(Get.context!,"happyIndexSend",todayEIScore);
      }else {
        dialogKudosSendResponse(Get.context!,"happyIndexSend", todayEIScore);
      }
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> sendOffloading(String message) async {
    Map<String, dynamic> requestData = {
      "userId": userId,
      "message": message,
      "orgId":orgId,
      "image":""
    };
    ApiResponse apiResponse = await homeServiceInterface!.addHappyIndex(requestData);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      showCustomSnackBar(map["message"], Get.context!, isError: false);

    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> getCurrentVersionOfApp(String version,String type) async {
    Map<String, dynamic> requestData = {
      "version": version,
      "appType": type
    };
    ApiResponse apiResponse = await homeServiceInterface!.getCurrentVersionOfApp(requestData);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      if(map["data"]["versionUpdate"]){
        updateLayoutStatus = false;
      }
      else{
        updateLayoutStatus = true;
      }
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> getDotDetails() async {
    _isPopupLoading = true;
    notifyListeners();
    Map<String, dynamic> requestData = {
      "orgId": orgId,
    };
    ApiResponse apiResponse = await homeServiceInterface!.getDotDetail(requestData);
    _isPopupLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewDotDetailsResponse response = ViewDotDetailsResponse.fromJson(map);
      dotDetailsData = response.data;

      beliefList = [];
      beliefList = dotDetailsData!.belief!;
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  List<ViewDepartmentUsers>? resetUserList;
  List<ViewDepartmentUsers>? userList;
  List<ViewDepartmentDepartment>? resetDepartmentsList;
  Future<void> getDepartmentUserList() async {
    Map<String, dynamic> requestData = {
      "orgId": orgId,
    };
    ApiResponse apiResponse = await homeServiceInterface!.getDepartmentUserList(requestData);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewDepartmentUserListResponse response = ViewDepartmentUserListResponse.fromJson(map);
      ViewDepartmentUserListData data = response.data!;
      resetDepartmentsList = data.departments;
      userList = data.users;
      resetUserList = data.users;
      for (int i = 0; i < userList!.length; i++) {
        String id = userList![i].id.toString();
        if (id==userId) {
          userList!.removeAt(i);
        }
      }
      viewFilteredUsersList(false);

    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }
}





