import 'package:flutter/material.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/main.dart';

import '../domain/services/know_service_interface.dart';


class KnowController extends ChangeNotifier {
  final KnowServiceInterface? knowServiceInterface;

  KnowController({required this.knowServiceInterface});
  List<String> officeList = ['Office A', 'Office B', 'Office C'];
  List<String> dayWiseList = [getTranslated("day_wise",Get.context!)!, getTranslated("week_wise",Get.context!)!, getTranslated("month_wise",Get.context!)!];
  List<String> departmentList = ['Department A', 'Department B', 'Department C'];

  String officeSelectedValue = 'Office A';
  String dayWiseSelectedValue = getTranslated("day_wise",Get.context!)!;
  String departmentSelectedValue = 'Department A';

  void updateOfficeSelectedValue(String? data) {
    officeSelectedValue = data!;
    notifyListeners();
  }

  void updateDepartmentSelectedValue(String? data) {
    departmentSelectedValue = data!;
    notifyListeners();
  }

  void updateDayWiseSelectedValue(String? value) {
    dayWiseSelectedValue = value!;
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
}
