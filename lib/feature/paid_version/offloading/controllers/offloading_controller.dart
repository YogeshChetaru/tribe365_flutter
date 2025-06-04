
import 'package:flutter/material.dart';
import '../domain/services/offloading_service_interface.dart';

class OffloadingController extends ChangeNotifier {
  final OffloadingServiceInterface? offloadingServiceInterface;

  OffloadingController({required this.offloadingServiceInterface});
  bool isType = true;

  void updateIsType(String s) {
    if (s == 'offloading') {
      isType = true;
    } else {
      isType = false;
    }
    notifyListeners();
  }
}
