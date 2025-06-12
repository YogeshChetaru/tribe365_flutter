import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tribe365_new/feature/free_version/free_dashboard/domain/models/get_office_list_response.dart';
import 'package:tribe365_new/feature/paid_version/paid_dashboard/screens/paid_dashboard_screen.dart';
import 'package:tribe365_new/utill/custom_route.dart';
import 'package:tribe365_new/utill/images.dart';
import '../../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../../data/model/api_response.dart';
import '../../../../helper/api_checker.dart';
import '../../../../main.dart';
import '../../../../utill/color_resources.dart';
import '../domain/models/get_free_version_home_response.dart';
import '../domain/models/view_department_list_response.dart';
import '../domain/services/free_dashboard_service_interface.dart';

class FreeDashboardController extends ChangeNotifier {
  final FreeDashboardServiceInterface? freeDashboardServiceInterface;

  FreeDashboardController({required this.freeDashboardServiceInterface});

  bool _isLoading = true;

  bool get isLoading => _isLoading;
  bool isAbsentVisible = false;

  List<ViewDepartmentListData>? departmentList;
  List<Offices>? officesList;
  bool flag = true;
  String orgId = "";
  String userId = "";
  final List<String> calendarItems = List.generate(10, (index) => 'Day ${index + 1}');

  Offices? officeSelectedValue;
  ViewDepartmentListData? departmentSelectedValue;
  String selectedStartDate = DateFormat('dd-MMM-yyyy').format(DateTime.now());
  String selectedEndDate = "";
  final DateFormat dateDDMMMYYYYFormatter = DateFormat('dd-MMM-yyyy');

  List<int> yearList = [];
  int? yearSelectedValue =DateTime.now().year;
  int currentMonth = DateTime.now().month - 1;

  List<String> fullMonthArray = List.generate(12, (i) => DateFormat.MMMM().format(DateTime(0, i + 1)));
  int indexOfMonth = DateTime.now().month;
  int currentYear = DateTime.now().year;
  int selectedYear = DateTime.now().year;

  List<String> monthList = [];
  String? monthSelectedValue;

  bool firstFlag = true;

  bool obscureCurrentPasswordText = true;
  bool obscureNewPasswordText = true;
  bool obscureConfPasswordText = true;

  void toggleCurrentPasswordVisibility() {
    obscureCurrentPasswordText = !obscureCurrentPasswordText;
    notifyListeners();
  }

  void toggleNewPasswordVisibility() {
    obscureNewPasswordText = !obscureNewPasswordText;
    notifyListeners();
  }

  void toggleConfPasswordVisibility() {
    obscureConfPasswordText = !obscureConfPasswordText;
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


  void updateOfficeSelectedValue(Offices? newOffice) {
    if (!flag || newOffice == null) return;

    officeSelectedValue = newOffice;

    // Reset departments
    departmentList=[];
    departmentList!.add(ViewDepartmentListData(id: 0, department: 'All Departments'));

    if (newOffice.officeId==0) {
      // Load all departments from API
      viewDepartmentList();
    } else {
      // Filter departments linked to selected office
      for (var officeDept in officesList!) {
        if (officeDept.officeId == newOffice.officeId) {
          departmentList!.addAll(officeDept.department!);
        }
      }
    }
    departmentSelectedValue = departmentList!.first;
    // Optionally call getHomePageDetails if department is empty
    getHomePageDetails();
    notifyListeners();
  }

  void updateDepartmentSelectedValue(ViewDepartmentListData? newDept) {
    if (!flag || newDept == null) return;

    if (departmentSelectedValue?.id != newDept.id) {
      departmentSelectedValue = newDept;
      getHomePageDetails();
    }
    notifyListeners();
  }


  void updateDate() {
    selectedStartDate = DateFormat('dd-MMM-yyyy').format(DateTime.now());
    selectedEndDate = "";
    notifyListeners();
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



  void updateYearSelectedValue(int? newValue) {
    if (newValue == null) return;

    int newYear = newValue;
    if (newYear != 0 && selectedYear != newYear) {
      selectedYear = newYear;
      yearSelectedValue = newValue;
      initMonths(); // Refresh months for selected year
      notifyListeners();
    }
  }

  void initMonths() {
    monthList.clear();
    if (selectedYear == currentYear) {
      monthList = fullMonthArray.sublist(0, currentMonth + 1);
    } else {
      monthList = List.from(fullMonthArray);
    }

    monthSelectedValue = monthList.contains(monthSelectedValue)
        ? monthSelectedValue
        : monthList.isNotEmpty ? monthList.last : null;
    notifyListeners();
  }

  void updateMonthSelectedValue(String? newValue) {
    if (newValue == null) return;

    monthSelectedValue = newValue;
    indexOfMonth = fullMonthArray.indexOf(newValue) + 1;

    if (firstFlag) {
      getHomePageDetails();
      firstFlag = true;
    }
    notifyListeners();
  }

  void initYears(int startYear) {
    yearList.clear();
    for (int year = currentYear; year >= startYear; year--) {
      yearList.add(year);
    }
    yearSelectedValue = selectedYear;
    notifyListeners();
    initMonths();

  }
  List<Map<String, dynamic>> calendarData = [];


  void setCalendarList({
    required List<HappyIndexMonthly> monthlyList,
    required String monthStart,
    required List<String> notWorkingDays,
  }) {
    List<Map<String, dynamic>> updatedCalendar = [];

    // Padding empty slots based on month start
    final startIndex = {
      "Monday": 1,
      "Tuesday": 2,
      "Wednesday": 3,
      "Thursday": 4,
      "Friday": 5,
      "Saturday": 6,
      "Sunday": 0,
    }[monthStart] ?? 0;

    for (int i = 0; i < startIndex; i++) {
      updatedCalendar.add({
        "day": "",
        "mood": null,
        "isNotWorkingDay": false,
        "date": null,
      });
    }

    final dateFormatter = DateFormat('EEE, dd MMM yyyy');

    for (var item in monthlyList) {
      final dayString = item.date?.padLeft(2, '0') ?? "";
      final mood = item.score;

      final dayInt = int.tryParse(dayString) ?? 1;
      final dateObj = DateTime(selectedYear, indexOfMonth, dayInt);

      final weekdayName = getWeekdayName(dateObj).toLowerCase();
      final formattedDate = dateFormatter.format(dateObj);

      updatedCalendar.add({
        "day": dayString,
        "mood": mood,
        "isNotWorkingDay": notWorkingDays.contains(weekdayName),
        "date": formattedDate,
      });
    }

    calendarData.clear();
    calendarData = updatedCalendar;
    notifyListeners();
  }

  String getWeekdayName(DateTime date) {
    const weekdayNames = [
      'sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday'
    ];
    return weekdayNames[date.weekday % 7];
  }
  void updateOrgID(int? id) {
    orgId = id.toString();
    notifyListeners();
  }

  String getMoodImage(double? score) {
    if (score == null) return Images.imgLowRed;

    if (score >= 0 && score <= 30) {
      return Images.imgLowRed;
    } else if (score >= 31 && score <= 60) {
      return Images.imgMediumYellow;
    } else if (score > 60) {
      return Images.imgSmileGreenBig;
    } else {
      return Images.imgLowRed;
    }
  }

  Color getMoodColor(double? score) {
    if (score == null) return ColorResources.mainColor;

    if (score >= 0 && score <= 30) {
      return ColorResources.mainColor;
    } else if (score >= 31 && score <= 60) {
      return ColorResources.colorF1d621;
    } else if (score > 60) {
      return ColorResources.color17ba0a;
    } else {
      return ColorResources.mainColor;
    }
  }

  void updateUserID(int? id) {
    userId = id.toString();
    notifyListeners();
  }

  //API calling

  Future<void> getHomePageDetails() async {
    _isLoading = true;
    notifyListeners();

    Map<String, dynamic> requestData = {
      "orgId": orgId,
      "month": indexOfMonth.toString(),
      "year": selectedYear.toString(),
      "deviceType": getDeviceType().toString(),
      "officeId": officeSelectedValue?.officeId.toString() ?? "",
      "departmentId": departmentSelectedValue?.id.toString() ?? "",
    };

    ApiResponse apiResponse =
    await freeDashboardServiceInterface!.getHomePageDetails(requestData);
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      GetFreeVersionHomeResponse response =GetFreeVersionHomeResponse.fromJson(map);

      try {
        GetFreeVersionHomeData homeDetail = response.data!;

        if (homeDetail.appPaymentVersion == 2) {

          return;
        } else if (homeDetail.appPaymentVersion == 3) {
          routePushAndRemoveUntil(Get.context!, PaidDashboardScreen());
          return;
        }

        // showHappyIndex(homeDetail.userGivenFeedback, homeDetail.leaveStatus);

        setCalendarList(monthlyList:
        homeDetail.happyIndexMonthly!,monthStart:
        homeDetail.firstDayOfMonth!,notWorkingDays:
        homeDetail.notWorkingDays!,
        );
        yearList = homeDetail.orgYearList!;
        initYears(yearList[0]);
        yearSelectedValue = selectedYear;
        firstFlag = true;

        debugPrint("leaveStatus >>>>>${homeDetail.leaveStatus}");
        int status= homeDetail.leaveStatus!;
        if (status ==1) {
          isAbsentVisible = true;
        }else{
          isAbsentVisible = false;
        }

      } catch (e) {
        debugPrint("Parse Error: $e");
      }
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> changePassword(String currentPassword, String newPassword) async {
    _isLoading = true;
    notifyListeners();
    Map<String, dynamic> requestData = {
      "currentPassword": currentPassword,
      "newPassword": newPassword,
    };

    ApiResponse apiResponse = await freeDashboardServiceInterface!.changePassword(requestData);
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      showCustomSnackBar(map["message"], Get.context!, isError: false);
      Navigator.of(Get.context!).pop();
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> viewDepartmentList() async {
    ApiResponse apiResponse = await freeDashboardServiceInterface!.viewDepartmentList();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewDepartmentListResponse response = ViewDepartmentListResponse.fromJson(map);

      departmentList = [];
      ViewDepartmentListData data0 = ViewDepartmentListData(id: 0,department: "All Departments");
      departmentList!.add(data0);
      for (var i = 0; i < response.data!.length; i++) {
        departmentList!.add(response.data![i]);
      }
      departmentSelectedValue = departmentList![0];
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> viewOfficeList() async {
    Map<String, dynamic> requestData = {
      "orgId": orgId,
    };
    ApiResponse apiResponse = await freeDashboardServiceInterface!.viewOfficeList(requestData);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewOfficeListResponse response = ViewOfficeListResponse.fromJson(map);

      officesList = [];
      Offices data0 = Offices(officeId: 0,department:departmentList,office: "All Offices");
      officesList!.add(data0);
      for (var i = 0; i < response.data!.offices!.length; i++) {
        officesList!.add(response.data!.offices![i]);
      }
      officeSelectedValue = officesList![0];
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

    ApiResponse apiResponse = await freeDashboardServiceInterface!.userApplyLeave(requestData);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      showCustomSnackBar(map["message"], Get.context!, isError: false);
      isAbsentVisible = true;
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }





}
