import 'package:flutter/material.dart';
import '../domain/services/profile_service_interface.dart';


class ProfileController extends ChangeNotifier {
  final ProfileServiceInterface? profileServiceInterface;

  ProfileController({required this.profileServiceInterface});
  String actionStatus="";
  String tierSelectedValue = 'All Tier';

  List<String> tierList = ['All Tier', 'Primary', 'Secondary', 'Tertiary'];

  bool isPushNotification = false;

  void updateIsPushNotification(bool value) {
    isPushNotification = value;
    notifyListeners();
  }

  void updateActionStatus(String s) {
    actionStatus = s;
    notifyListeners();
  }

  void updateTierSelectedValue(String? newValue) {
    tierSelectedValue = newValue!;
    notifyListeners();
  }
}
