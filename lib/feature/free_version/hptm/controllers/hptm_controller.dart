import 'package:flutter/material.dart';
import '../../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../../data/model/api_response.dart';
import '../../../../helper/api_checker.dart';
import '../../../../main.dart';
import '../domain/models/learningmainchecklistmodel.dart';
import '../domain/models/view_hptm_principles_list.dart';
import '../domain/services/hptm_service_interface.dart';

class HPTMController extends ChangeNotifier {
  final HPTMServiceInterface? hptmServiceInterface;

  HPTMController({required this.hptmServiceInterface});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _isLoading2 = false;

  bool get isLoading2 => _isLoading2;

  ViewHPTMPrinciplesData? viewHPTMPrinciplesData;
  List<PrincipleData>? hPTMPrincipleList;
  bool hPTMStatus = false;
  int selectedSelfLearningListIndex = 0;

  LearningMainCheckListModel? checklistModel;

  final Map<String, bool> mainClickStatus = {};
  final Map<String, List<bool>> subClickStatus = {};
  final Map<String, bool> sectionExpanded = {};

  Future<void> setChecklistData(LearningMainCheckListModel model) async {
    checklistModel = model;
    mainClickStatus.clear();
    subClickStatus.clear();
    sectionExpanded.clear(); // collapsed by default

    for (var key in model.learningCheckList.keys) {
      final subItems = model.learningCheckList[key] ?? [];

      final subStatuses = subItems.map((e) => e.userReadChecklist).toList();

      subClickStatus[key] = subStatuses;

      mainClickStatus[key] = subStatuses.every((checked) => checked);

      sectionExpanded[key] = false;
    }

    notifyListeners();
  }

  void toggleSection(String title) {
    sectionExpanded[title] = !(sectionExpanded[title] ?? false);
    notifyListeners();
  }

  void toggleMain(String title, bool? value) {
    mainClickStatus[title] = value ?? false;
    final subList = subClickStatus[title];
    if (subList != null) {
      for (int i = 0; i < subList.length; i++) {
        subList[i] = value ?? false;
      }
    }
    notifyListeners();
  }

  void toggleSub(String title, int index, bool? value) {
    subClickStatus[title]?[index] = value ?? false;

    final allSelected = subClickStatus[title]?.every((e) => e) ?? false;
    mainClickStatus[title] = allSelected;

    notifyListeners();
  }

  void updateHPTMStatus() {
    if (hPTMStatus == true) {
      hPTMStatus = false;
    } else {
      hPTMStatus = true;
    }
    notifyListeners();
  }

  void updateSelectedSelfLearningListItem(int index, PrincipleData date) {
    selectedSelfLearningListIndex = index;
    getHPTMLearningCheckList(date.id.toString());
    notifyListeners();
  }

  Future<void> getHPTMPrinciplesList(int count) async {
    _isLoading = true;
    ApiResponse apiResponse = await hptmServiceInterface!.viewHPTMPrinciplesList();
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewHPTMPrinciplesList viewHPTMPrinciplesResponse = ViewHPTMPrinciplesList.fromJson(map);
      viewHPTMPrinciplesData = viewHPTMPrinciplesResponse.data;
      hPTMPrincipleList = [];
      hPTMPrincipleList = viewHPTMPrinciplesData!.principleData!.reversed.toList();
      selectedSelfLearningListIndex = count;
      getHPTMLearningCheckList(hPTMPrincipleList![0].id.toString());
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> getHPTMLearningCheckList(String id) async {
    _isLoading2 = true;
    Map<String, dynamic> request = {
      "principleId": id,
    };
    ApiResponse apiResponse = await hptmServiceInterface!.viewHPTMLearningCheckList(request);
    _isLoading2 = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      final model = LearningMainCheckListModel.fromJson(apiResponse.response!.data);
      await setChecklistData(model);
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> updateHPTMLearningCheckListStatus(String id, bool status) async {
    Map<String, dynamic> request = {"checklistId": id, "readStatus": status};
    ApiResponse apiResponse = await hptmServiceInterface!.updateHPTMLearningCheckListStatus(request);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      getHPTMPrinciplesList(selectedSelfLearningListIndex);
    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }
}
