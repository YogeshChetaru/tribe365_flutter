import 'package:flutter/material.dart';
import 'package:tribe365_new/feature/paid_version/home/domain/models/amazingawardusermodel.dart';
import '../domain/models/daydata.dart';
import '../domain/services/home_service_interface.dart';

class HomeController extends ChangeNotifier {
  final HomeServiceInterface? homeServiceInterface;

  HomeController({required this.homeServiceInterface});
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocus = FocusNode();

  final List<DayData> weekData = [
    DayData(day: 'Sun', date: '01'),
    DayData(day: 'Mon', date: '02', mood: Icons.sentiment_dissatisfied),
    DayData(day: 'Tue', date: '03', mood: Icons.sentiment_dissatisfied),
    DayData(day: 'Wed', date: ''),
    DayData(day: 'Thu', date: ''),
    DayData(day: 'Fri', date: ''),
    DayData(day: 'Sat', date: ''),
  ];

  List<AmazingAwardUserModel> allUsers = [
    AmazingAwardUserModel(name: "Alice"),
    AmazingAwardUserModel(name: "Bob"),
    AmazingAwardUserModel(name: "Charlie"),
    AmazingAwardUserModel(name: "Daisy"),
  ];

  List<AmazingAwardUserModel> filteredUsers = [];

  viewFilteredUsersList(bool isNotify){
  filteredUsers = List.from(allUsers);
  if(isNotify){
    notifyListeners();
  }

  }

  intiData(bool isNotify){
    searchController = TextEditingController();
    searchFocus = FocusNode();
    if(isNotify){
      notifyListeners();
    }

  }

  void filterUsers() {
    final query = searchController.text.toLowerCase();
    filteredUsers = allUsers.where((user) => user.name.toLowerCase().contains(query)).toList();
    notifyListeners();
  }
  void toggleSelection(int index) {
    filteredUsers[index].isSelected = !filteredUsers[index].isSelected;

    final actualIndex = allUsers.indexWhere((u) => u.name == filteredUsers[index].name);
    if (actualIndex != -1) {
      allUsers[actualIndex].isSelected = filteredUsers[index].isSelected;
    }
    notifyListeners();
  }
}
