import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/home/controllers/home_controller.dart';
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
import '../domain/models/model_add_action_user_response.dart';
import '../domain/models/view_know_member_details_response.dart';
import '../domain/models/view_know_organisation_response.dart';
import '../domain/models/view_kudos_award_response.dart';
import '../domain/services/know_service_interface.dart';


class KnowController extends ChangeNotifier {
  final KnowServiceInterface? knowServiceInterface;

  KnowController({required this.knowServiceInterface});
  bool _isLoading = true;
  bool _isLoadingMember = true;
  bool viewMoreStatus = false;
  bool get isLoading => _isLoading;
  bool get isLoadingMember => _isLoadingMember;
   List<String> dayWiseList = [getTranslated("day_wise",Get.context!)!, getTranslated("week_wise",Get.context!)!, getTranslated("month_wise",Get.context!)!];
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
  List<LastMonthKudosChamp>? lastMonthKudosChamp;
  List<LatestKudosAward>? latestKudosAwardMainList;
  String userNameAward = "";
  bool kudosCountCardStatus = false ;
  List<KudosCount>? kudosCountList;
  List<ModelAddActionUserData> users = [];
  List<ViewKudosAwardData> awards = [];
  Map<String, List<ViewKudosAwardData>> groupedAwards = {};
  String selectedUserId = '';
  String selectedMemberId = '';
  String selectedMemberOrgId = '';
  String selectedUserName = 'All User';
  String selectedMemberName = '';
  List<GroupKudosList> groupKudosList = [];

  double _engagementKMScore = 0;
  String _engagementKMStatus = '';
  String _engagementKMDisplayValue = '';
  String _engagementKMImagePath = Images.imgLowRed;
  Color _engagementKMScoreColor = Colors.grey;

  double get engagementKMScore => _engagementKMScore;
  String get engagementKMStatus => _engagementKMStatus;
  String get engagementKMDisplayValue => _engagementKMDisplayValue;
  String get engagementKMImagePath => _engagementKMImagePath;
  Color get engagementKMScoreColor => _engagementKMScoreColor;

  List<PersonalityTypeDetailsArr>? personalityTypeList;
  String? personalityTypeDetailsMsg;
  List<String>? teamRoleList;
  String? teamRoleDetailsMsg;
  List<String>? motivationList;
  String? motivationDetails;


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
    viewKnowOrganisation(false);
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
      viewKnowOrganisation(false);
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

        // Kudos Champ List
        lastMonthKudosChamp = [];
        lastMonthKudosChamp = homeData!.lastMonthKudosChamp ?? [];

        // Kudos Award List
        List<LatestKudosAward>? latestKudosAwardList = [];
        latestKudosAwardMainList = [];
        latestKudosAwardList = homeData!.latestKudosAward ?? [];
        if(latestKudosAwardList.length<3){
          viewMoreStatus = false;
          for(int i=0;i<latestKudosAwardList.length;i++){
            latestKudosAwardMainList!.add(latestKudosAwardList[i]);
          }
        }
        else{
          viewMoreStatus = true;
          for(int i=0;i<3;i++){
            latestKudosAwardMainList!.add(latestKudosAwardList[i]);
          }
        }
      }
    } catch (e) {
      debugPrint("Main block error: $e");
    }
    notifyListeners();
  }

  void setUserList(List<ModelAddActionUserData> userList) {
    users = userList;
    users.insert(0, ModelAddActionUserData(id: 0, name: 'All User'));
    notifyListeners();
  }

  void setAwardList(List<ViewKudosAwardData> awardList) {
    awards = awardList;
    groupAndSortAwards();
    notifyListeners();
  }

  void groupAndSortAwards() {
    final Map<String, List<ViewKudosAwardData>> map = {};
    for (var award in awards) {
      final key = "#${award.awardDate} # ${award.awardDescription}";
      map.putIfAbsent(key, () => []).add(award);
    }
    groupedAwards = Map.fromEntries(map.entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key)));
  }

  void selectUser(String id, String name) {
    selectedUserId = id;
    selectedUserName = name;

    notifyListeners();
  }
  void selectMember(String id, String name,String orgId) {
    selectedMemberId = id;
    selectedMemberName = name;
    selectedMemberOrgId = orgId;
    viewKnowMemberDetails(selectedMemberId, selectedMemberOrgId,false);
    notifyListeners();
  }
  void updateUserData(ModelAddActionUserData userData) {
    if (userData.name == 'All User') {
      selectUser('', userData.name!);
      viewKudosAward('');
    } else {
      selectUser(userData.id.toString(), "${userData.name!}  ${userData.lastName??""}");
      viewKudosAward(userId);
    }
    notifyListeners();
  }
  void updateMemberData(ModelAddActionUserData userData) {
    selectMember(userData.id.toString(), "${userData.name!}  ${userData.lastName??""}",userData.orgId.toString());
    notifyListeners();
  }

  void loadGroupedAwards(List<ViewKudosAwardData> allAwards, String userId) {

    groupKudosList.clear();
    final map = <String, List<ViewKudosAwardData>>{};
    for (var award in allAwards) {
      final key = '#${getDate(award.awardDate!)} # ${award.awardDescription}';
      map.putIfAbsent(key, () => []);
      map[key]!.add(award);
    }
    final sortedMap = Map.fromEntries(map.entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key)));
    for (var entry in sortedMap.entries) {
      groupKudosList.add(GroupKudosList(
        keyDescription: entry.key,
        kudosAwardLists: entry.value,
      ));
    }

    notifyListeners();
  }

  String getDate(String rawDate) {
    try {
      final date = DateTime.parse(rawDate);
      return '${date.day}-${date.month}-${date.year}';
    } catch (_) {
      return rawDate;
    }
  }

  void intiUserMemberData(ViewUserProfileData? userData) {
    selectedMemberId = userData!.id.toString();
    selectedMemberName ="${ userData.name}" "${userData.lastName??""}";
    selectedMemberOrgId = userData.orgId.toString();
    viewKnowMemberDetails(selectedMemberId, selectedMemberOrgId,true);
    notifyListeners();
  }

  void setEngagementScore(String? scoreStr) {
    final score = double.tryParse(scoreStr!) ?? 0;
    _engagementKMScore = score;
    _engagementKMDisplayValue = _trimTrailingZeros(scoreStr);

    if (score <= 499) {
      _engagementKMImagePath = Images.imgLowRed;
      _engagementKMStatus = 'Low';
      _engagementKMScoreColor = ColorResources.colorEb1c24;
    } else if (score >= 500 && score <= 1099) {
      _engagementKMImagePath = Images.imgMediumYellow;
      _engagementKMStatus = 'Medium';
      _engagementKMScoreColor = ColorResources.colorffde00;
    } else {
      _engagementKMImagePath = Images.imgSmileGreenBig;
      _engagementKMStatus = 'High';
      _engagementKMScoreColor = ColorResources.color17ba0a;
    }
    notifyListeners();
  }

  void setEngagementScoreBasicVersion(String? scoreStr) {
    final score = double.tryParse(scoreStr!) ?? 0;
    _engagementKMScore = score;
    _engagementKMDisplayValue = _trimTrailingZeros(scoreStr);

    if (score <= 299) {
      _engagementKMImagePath = Images.imgLowRed;
      _engagementKMStatus = 'Low';
      _engagementKMScoreColor = ColorResources.colorEb1c24;
    } else if (score >= 300 && score <= 800) {
      _engagementKMImagePath = Images.imgMediumYellow;
      _engagementKMStatus = 'Medium';
      _engagementKMScoreColor = ColorResources.colorffde00;
    } else {
      _engagementKMImagePath = Images.imgSmileGreenBig;
      _engagementKMStatus = 'High';
      _engagementKMScoreColor = ColorResources.color17ba0a;
    }
    notifyListeners();
  }

  String _trimTrailingZeros(String value) {
    final number = double.tryParse(value);
    if (number == null) return value;
    return number.toStringAsFixed(number.truncateToDouble() == number ? 0 : 2);
  }

  //API calling --------------
  Future<void> viewKnowOrganisation(bool loadStatus) async {
    if(loadStatus){
      _isLoading = true;
      notifyListeners();
    }

    Map<String, dynamic> requestData = {
      "orgId": orgId,
      "officeId":officeSelectedValue!.officeId,
      "departmentId":departmentSelectedValue!.id
    };
    ApiResponse apiResponse = await knowServiceInterface!.viewKnowOrganisationData(requestData);

    _isLoading = false;

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

  Future<void> viewUserByTypeList() async {
    Map<String, dynamic> requestData = {
      "typeId": orgId,
      "type":"organisation"
    };
    ApiResponse apiResponse = await knowServiceInterface!.viewUserByType(requestData);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ModelAddActionUserResponse response = ModelAddActionUserResponse.fromJson(map);
      users = [];
      users.add(ModelAddActionUserData(id: 0, name: 'All User'));
      for(int i=0;i<response.data!.length;i++){
        users.add(response.data![i]);
      }
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> viewKnowMemberList() async {
    Map<String, dynamic> requestData = {
      "typeId": orgId,
      "type":"organisation"
    };
    ApiResponse apiResponse = await knowServiceInterface!.viewUserByType(requestData);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ModelAddActionUserResponse response = ModelAddActionUserResponse.fromJson(map);
      users = [];
      for(int i=0;i<response.data!.length;i++){
        users.add(response.data![i]);
      }
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> viewKudosAward(String userId) async {
    _isLoading = true;
    Map<String, dynamic> requestData = {
      "userId": userId
    };
    ApiResponse apiResponse = await knowServiceInterface!.viewKudosAward(requestData);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewKudosAwardResponse response = ViewKudosAwardResponse.fromJson(map);

      loadGroupedAwards(response.data!, userId);
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> viewKnowMemberDetails(String userId,String orgId,bool loadStatus) async {
    if(loadStatus){
      _isLoadingMember = true;
      notifyListeners();
    }
    Map<String, dynamic> requestData = {
      "userId": userId,
      "orgId":orgId
    };
    ApiResponse apiResponse = await knowServiceInterface!.viewKnowMemberDetails(requestData);
    _isLoadingMember = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewKnowMemberDetailsResponse response = ViewKnowMemberDetailsResponse.fromJson(map);
      ViewKnowMemberDetailsData? data = response.data;
      if (Provider.of<HomeController>(Get.context!,listen: false).homeData!.appPaymentVersion==3){
        setEngagementScore(data!.engagementIndexScore);
      }else {
        setEngagementScoreBasicVersion(data!.engagementIndexScore);
      }

      kudosCountList = [];
      kudosCountList=data.kudosCount;

      if (data.appPaymentVersion==3){
        kudosCountCardStatus = false;
      }else {
        kudosCountCardStatus = true;
      }
      personalityTypeList = [];
      personalityTypeList =  data.personalityType;
      personalityTypeDetailsMsg = data.perTypeDetails;

      teamRoleList = [];
      teamRoleList = data.teamRole;
      teamRoleDetailsMsg = data.teamRoleDetails!;

      motivationList = [];
      motivationList = data.motivation;
      motivationDetails = data.motivationDetails;

    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }
}
