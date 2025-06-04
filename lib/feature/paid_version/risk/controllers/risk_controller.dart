import 'package:flutter/material.dart';
import '../domain/services/risk_service_interface.dart';


class RiskController extends ChangeNotifier {
  final RiskServiceInterface? riskServiceInterface;

  RiskController({required this.riskServiceInterface});

  List<String> riskTypeList = ['SWOT', 'Strength', 'Weakness', 'Opportunities', 'Threats'];

  String riskTypeSelectedValue = 'SWOT';
  String isType = "new";

  void updateRiskTypeSelectedValue(String? data) {
    riskTypeSelectedValue = data!;
    notifyListeners();
  }

  void updateIsType(String s) {
    if (s == 'new') {
      isType = "new";
    } else if(s=="ongoing") {
      isType = "ongoing";
    }
    else {
      isType = "managed";
    }
    notifyListeners();
  }
}
