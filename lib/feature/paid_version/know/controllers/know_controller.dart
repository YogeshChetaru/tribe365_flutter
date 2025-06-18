import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/free_version/free_dashboard/controllers/free_dashboard_controller.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/main.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/images.dart';

import '../../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../../data/model/api_response.dart';
import '../../../../helper/api_checker.dart';
import '../../../free_version/free_dashboard/domain/models/get_office_list_response.dart';
import '../../../free_version/free_dashboard/domain/models/view_department_list_response.dart';
import '../../profile/domain/models/viewuserprofileresponse.dart';
import '../domain/models/view_know_organisation_response.dart';
import '../domain/services/know_service_interface.dart';


class KnowController extends ChangeNotifier {
  final KnowServiceInterface? knowServiceInterface;

  KnowController({required this.knowServiceInterface});

  // List<String> officeList = ['Office A', 'Office B', 'Office C'];
  List<String> dayWiseList = [getTranslated("day_wise",Get.context!)!, getTranslated("week_wise",Get.context!)!, getTranslated("month_wise",Get.context!)!];
  // List<String> departmentList = ['Department A', 'Department B', 'Department C'];
  List<ViewDepartmentListData>? departmentList;
  List<Offices>? officesList;
  String orgId = "";
  String userId = "";

  Offices? officeSelectedValue;
  String dayWiseSelectedValue = getTranslated("day_wise",Get.context!)!;
  ViewDepartmentListData? departmentSelectedValue;
  ViewKnowOrganisationData? homeData;

  String todayTitle = "";
  String yesterdayTitle = "";
  String dayAfterTitle = "";

  String tvCultureRank = "";
  String tvCultureValue = "";
  String cultureImagePath = Images.imgLowRed;
  Color cultureTextColor = Colors.grey;

  String engagementRank = '';
  String engagementValue = '';
  String engagementImagePath = Images.imgLowRed;
  Color engagementTextColor = Colors.grey;

  String todayValue = "";
  String yesterdayValue = "";
  String dayAfterValue = "";

  String todayEmoji = "";
  String yesterdayEmoji = "";
  String dayAfterEmoji = "";

  Color todayColor = Colors.grey;
  Color yesterdayColor = Colors.grey;
  Color dayAfterColor = Colors.grey;


  void updateOfficeSelectedValue(Offices? data) {
    officeSelectedValue = data!;

    departmentList=[];
    departmentList!.add(ViewDepartmentListData(id: 0, department: 'All Departments'));

    if (data.officeId==0) {
      // Load all departments from API
      viewDepartmentList();
    } else {
      // Filter departments linked to selected office
      for (var officeDept in officesList!) {
        if (officeDept.officeId == data.officeId) {
          departmentList!.addAll(officeDept.department!);
        }
      }
    }
    departmentSelectedValue = departmentList!.first;
    viewKnowOrganisation();
    notifyListeners();
  }
  void updateOrgID(ViewUserProfileData? data) {
    orgId = data!.orgId.toString();
    userId = data.id.toString();
    notifyListeners();
  }
  void updateDepartmentSelectedValue(ViewDepartmentListData? data) {
    if (departmentSelectedValue?.id != data!.id) {
      departmentSelectedValue = data;
      viewKnowOrganisation();
    }
    notifyListeners();
  }

  void updateDayWiseSelectedValue(String? value) {
    dayWiseSelectedValue = value!;
    setDataOnSelection(homeData!);
    notifyListeners();
  }

  String getEmoji(String mood) {
    switch (mood) {
      case 'sad':
        return '😞';
      case 'happy':
        return '🙂';
      case 'normal':
        return '😐';
      case 'none':
        return '-';
      default:
        return '';
    }
  }

  void setDataOnSelection(ViewKnowOrganisationData homeDetail) {
   if (dayWiseSelectedValue.contains(getTranslated("week_wise",Get.context!)!)) {
     setWeeklyData(homeDetail);
   } else if (dayWiseSelectedValue.contains(getTranslated("month_wise",Get.context!)!)) {
     setMonthlyData(homeDetail);
   } else {
     setDayWiseData(homeDetail);
   }
   notifyListeners();
  }
  void setMonthlyData(ViewKnowOrganisationData homeDetail) {
    final now = DateTime.now();

    if (homeDetail.thisMonthHIPercent != null) {
      todayTitle = homeDetail.thisMonthName ?? getMonthName(now.month);
      setFirstColumnData(double.parse(homeDetail.thisMonthHIPercent!));
    }

    if (homeDetail.lastMonthHIPercent != null) {
      final lastMonth = now.month - 1 == 0 ? 12 : now.month - 1;
      yesterdayTitle = homeDetail.lastMonthName ?? getMonthName(lastMonth);
      setSecondColumnData(double.parse(homeDetail.lastMonthHIPercent!));
    }

    if (homeDetail.lastToLastMonthHIPercent != null) {
      final month = now.month - 2 <= 0 ? now.month + 10 : now.month - 2;
      dayAfterTitle = homeDetail.lastToLastMonthName ?? getMonthName(month);
      setThirdColumnData(double.parse(homeDetail.lastToLastMonthHIPercent!));
    }
    notifyListeners();
  }
  String getMonthName(int month) {
    const months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    return months[month - 1];
  }


  void setWeeklyData(ViewKnowOrganisationData homeDetail) {
    if (homeDetail.thisWeekHIPercent != null) {
      todayTitle = "This Week";
      setFirstColumnData(double.parse(homeDetail.thisWeekHIPercent!));
    }

    if (homeDetail.lastWeekHIPercent != null) {
      yesterdayTitle = "Last Week";
      setSecondColumnData(double.parse(homeDetail.lastWeekHIPercent!));
    }

    if (homeDetail.lastToLastWeekHIPercent != null) {
      dayAfterTitle = "Last 3rd Week";
      setThirdColumnData(double.parse(homeDetail.lastToLastWeekHIPercent!));
    }
    notifyListeners();
  }
  void setDayWiseData(ViewKnowOrganisationData homeDetail) {
    if (homeDetail.todayHIPercent != null) {

      todayTitle = homeDetail.todayDay ?? "Today";
      setFirstColumnData(double.parse(homeDetail.todayHIPercent!));

    }

    if (homeDetail.yesterdayHIPercent != null) {
      yesterdayTitle = homeDetail.yesterdayDay ?? "Yesterday";
      setSecondColumnData(double.parse(homeDetail.yesterdayHIPercent!));
    }

    if (homeDetail.dayBeforeYesterdayHIPercent != null) {
      dayAfterTitle = homeDetail.dayBeforeYesterdayDay ?? "Day Before Yesterday";
      setThirdColumnData(double.parse(homeDetail.dayBeforeYesterdayHIPercent!));
    }
    notifyListeners();
  }

  void setFirstColumnData(double value) {
    todayValue = "${value.toStringAsFixed(1)}%";
    todayEmoji = getEmojiForValue(value);
    todayColor = getColorForValue(value);
    notifyListeners();
  }
  void setSecondColumnData(double value) {
    yesterdayValue = "${value.toStringAsFixed(1)}%";
    yesterdayEmoji = getEmojiForValue(value);
    yesterdayColor = getColorForValue(value);
    notifyListeners();
  }
  void setThirdColumnData(double value) {
    dayAfterValue = "${value.toStringAsFixed(1)}%";
    dayAfterEmoji = getEmojiForValue(value);
    dayAfterColor = getColorForValue(value);
    notifyListeners();
  }

  String getEmojiForValue(double finalCount) {
    String imagePath = '';
    if (finalCount >= 0 && finalCount <= 30) {
      imagePath = Images.imgLowRed;
    } else if (finalCount >= 31 && finalCount <= 60) {
      imagePath = Images.imgMediumYellow;
    } else if (finalCount > 60) {
      imagePath = Images.imgSmileGreenBig;
    }
    return imagePath;
  }
  Color getColorForValue(double finalCount) {
    Color textColor = Colors.grey;
    if (finalCount >= 0 && finalCount <= 30) {
      textColor = ColorResources.colorEb1c24;
    } else if (finalCount >= 31 && finalCount <= 60) {
      textColor =ColorResources.colorffde00;
    } else if (finalCount > 60) {
      textColor = ColorResources.color17ba0a;
    }
    return textColor;
  }

  void setCultureData(double? cultureData, int cultureIndexRank) {
    if (cultureData == null) return;

    String showEngValue = trimTrailingZeros(cultureData.toString());
    tvCultureRank = 'Rank: $cultureIndexRank';
    tvCultureValue = showEngValue;

    if (cultureData <= 499) {
      cultureImagePath = Images.imgLowRed;
      cultureTextColor = ColorResources.colorEb1c24;
    } else if (cultureData >= 500 && cultureData <= 1099) {
      cultureImagePath = Images.imgMediumYellow;
      cultureTextColor = ColorResources.colorffde00;
    } else {
      cultureImagePath = Images.imgSmileGreenBig;
      cultureTextColor = ColorResources.color17ba0a;
    }
    notifyListeners();
  }
  void setCultureDataBasicVersion(double? cultureData, int cultureIndexRank) {
    if (cultureData == null) return;

    String showEngValue = trimTrailingZeros(cultureData.toString());

    tvCultureRank = 'Rank: $cultureIndexRank';
    tvCultureValue = showEngValue;

    if (cultureData <= 299) {
      cultureImagePath = Images.imgLowRed;
      cultureTextColor = ColorResources.colorEb1c24;
    } else if (cultureData >= 300 && cultureData < 800) {
      cultureImagePath = Images.imgMediumYellow;
      cultureTextColor = ColorResources.colorffde00;
    } else {
      cultureImagePath = Images.imgSmileGreenBig;
      cultureTextColor = ColorResources.color17ba0a;
    }
    notifyListeners();
  }

  void setEngagementData(double? engagementData, int engagementIndexRank) {
    if (engagementData == null) return;

    final double finalCount = engagementData;
    final String showEngValue = trimTrailingZeros(engagementData.toString());
    engagementRank = 'Rank: $engagementIndexRank';
    engagementValue = showEngValue;

    if (finalCount <= 499) {
      engagementImagePath =  Images.imgLowRed;
      engagementTextColor = ColorResources.colorEb1c24;
    } else if (finalCount >= 500 && finalCount <= 1099) {
      engagementImagePath = Images.imgMediumYellow;
      engagementTextColor = ColorResources.colorffde00;
    } else if (finalCount >= 1100) {
      engagementImagePath = Images.imgSmileGreenBig;
      engagementTextColor = ColorResources.color17ba0a;
    }
    notifyListeners();
  }
  void setEngagementDataBasicVersion(double? engagementData, int engagementIndexRank) {
    if (engagementData == null) return;

    final double finalCount = engagementData;
    final String showEngValue = trimTrailingZeros(engagementData.toString());

    engagementRank = 'Rank: $engagementIndexRank';
    engagementValue = showEngValue;

    if (finalCount <= 299) {
      engagementImagePath =  Images.imgLowRed;
      engagementTextColor = ColorResources.colorEb1c24;
    } else if (finalCount >= 300 && finalCount < 800) {
      engagementImagePath = Images.imgMediumYellow;
      engagementTextColor = ColorResources.colorffde00;
    } else if (finalCount >= 800) {
      engagementImagePath = Images.imgSmileGreenBig;
      engagementTextColor = ColorResources.color17ba0a;
    }
    notifyListeners();
  }

  String trimTrailingZeros(String value) {
    if (value.contains('.') && value.endsWith('0')) {
      return value.replaceAll(RegExp(r"\.?0+$"), '');
    }
    return value;
  }


  void processHomeData(Map<String, dynamic> object) {
    try {

      if (homeData != null) {
        setDataOnSelection(homeData!);

        if (homeData!.appPaymentVersion == 3) {
          setCultureDataBasicVersion(
            double.parse(homeData!.cultureIndex!),
            homeData!.cultureIndexRank!,
          );
        }
        else {
          setCultureData(
            double.parse(homeData!.cultureIndex!),
            homeData!.cultureIndexRank!,
          );
        }

        if (homeData!.appPaymentVersion == 3) {
          setEngagementDataBasicVersion(
            double.parse(homeData!.engagementIndex!),
            homeData!.engagementIndexRank!,
          );
        }
        else {
          setEngagementData(
            double.parse(homeData!.engagementIndex!),
            homeData!.engagementIndexRank!,
          );
        }

        /*if (sessionParam.loginVersion == 3) {
          setEngagementDataBasicVersion(
            homeDetail.engagementIndex,
            homeDetail.engagementIndexRank,
          );
        }
        else {
          setEngagementData(
            homeDetail.engagementIndex,
            homeDetail.engagementIndexRank,
          );
        }*/

        // Kudos Champ List
        /*final kudosList = homeDetail.lastMonthKudosChamp ?? [];
        if (kudosList.isNotEmpty) {
          final firstUser = kudosList.first;
          if ((firstUser.userName ?? '').isEmpty) {
            showNoKudosChampRecord();
          } else {
            showKudosChampList(kudosList);
          }
        }
        else {
          showNoKudosChampRecord();
        }*/

        // Kudos Award List
       /* final kudosAwardList = homeDetail.latestKudosAward ?? [];
        if (kudosAwardList.isNotEmpty) {
          showKudosAwardList(kudosAwardList);

          if (kudosAwardList.length >= 3) {
            showViewMoreAwardButton();
          } else {
            hideViewMoreAwardButton();
          }
        }
        else {
          hideKudosAwardSection();
        }

        */
      }
    } catch (e) {
      debugPrint("Main block error: $e");
    }
  }

  //API calling --------------
  Future<void> viewKnowOrganisation() async {
    Map<String, dynamic> requestData = {
      "orgId": orgId,
      "officeId":officeSelectedValue!.officeId,
      "departmentId":departmentSelectedValue!.id
    };
    ApiResponse apiResponse = await knowServiceInterface!.viewKnowOrganisationData(requestData);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewKnowOrganisationResponse response = ViewKnowOrganisationResponse.fromJson(map);
      homeData = response.data;
      processHomeData(map);
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> viewDepartmentList() async {
    ApiResponse apiResponse = await knowServiceInterface!.viewDepartmentList();
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
    ApiResponse apiResponse = await knowServiceInterface!.viewOfficeList(requestData);
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
}
