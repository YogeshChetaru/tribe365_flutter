import 'package:flutter/material.dart';
import '../domain/services/hptm_service_interface.dart';

class HPTMController extends ChangeNotifier {
  final HPTMServiceInterface? hptmServiceInterface;

  HPTMController({required this.hptmServiceInterface});

  bool hPTMStatus = false;
  int selectedSelfLearningListIndex = 0;

  final List<String> selfLearningListItems = ["Honesty", "Purpose", "Structure", "Balance", "Inclusive"];

  final List<Map<String, dynamic>> data = [
    {
      "title": "Fruits",
      "items": ["Apple", "Banana", "Mango"]
    },
    {
      "title": "Vegetables",
      "items": ["Carrot", "Potato", "Tomato"]
    },
    {
      "title": "Drinks",
      "items": ["Water", "Juice", "Coffee"]
    },
  ];
  void updateHPTMStatus() {
    if(hPTMStatus==true) {
      hPTMStatus = false;
    }
    else{
      hPTMStatus = true;
    }
    notifyListeners();
  }

  void updateSelectedSelfLearningListItem(int index) {
    selectedSelfLearningListIndex = index;
    notifyListeners();
  }

}
