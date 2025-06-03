import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../domain/services/free_dashboard_service_interface.dart';

class FreeDashboardController extends ChangeNotifier {
  final FreeDashboardServiceInterface? freeDashboardServiceInterface;

  FreeDashboardController({required this.freeDashboardServiceInterface});

  List<String> officeList = ['Office A', 'Office B', 'Office C'];
  List<String> monthList = ['Jan', 'Feb', 'Mar','Apr'];
  List<String> departmentList = ['Department A', 'Department B', 'Department C'];
  List<String> yearList = ['2021', '2022', '2023', '2024', '2025'];
  final List<String> calendarItems = List.generate(10, (index) => 'Day ${index + 1}');

  String officeSelectedValue = 'Office A';
  String monthSelectedValue = 'Jan';
  String departmentSelectedValue = 'Department A';
  String yearSelectedValue = '2021';
  String selectedStartDate = DateFormat('dd-MMM-yyyy').format( DateTime.now());
  String selectedEndDate = "";
  final DateFormat dateDDMMMYYYYFormatter = DateFormat('dd-MMM-yyyy');

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

  void pickStartDate(BuildContext context,String type) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      if(type=="start"){
        selectedStartDate = DateFormat('dd-MMM-yyyy').format(date);
      }
      else if(type=="end")  {
        selectedEndDate = DateFormat('dd-MMM-yyyy').format(date) ;
      }
      notifyListeners();
    }
  }

  final List<Map<String, dynamic>> calendarData = [
    // Week 1
    {'day': '', 'mood': ''},
    {'day': '01', 'mood': 'sad'},
    {'day': '02', 'mood': 'sad'},
    {'day': '03', 'mood': 'none'},
    // Week 2
    {'day': '04', 'mood': 'none'},
    {'day': '05', 'mood': 'sad'},
    {'day': '06', 'mood': 'sad'},
    {'day': '07', 'mood': 'sad'},
    {'day': '08', 'mood': 'happy'},
    {'day': '09', 'mood': 'happy'},
    {'day': '10', 'mood': 'none'},
    // Week 3
    {'day': '11', 'mood': 'none'},
    {'day': '12', 'mood': 'sad'},
    {'day': '13', 'mood': 'normal'},
    {'day': '14', 'mood': ''},
    {'day': '15', 'mood': 'sad'},
    {'day': '16', 'mood': 'happy'},
    {'day': '17', 'mood': 'none'},
    // Week 4
    {'day': '18', 'mood': 'none'},
    {'day': '19', 'mood': 'happy'},
    {'day': '20', 'mood': 'normal'},
    {'day': '21', 'mood': 'sad'},
    {'day': '22', 'mood': 'sad'},
    {'day': '23', 'mood': 'sad'},
    {'day': '24', 'mood': 'none'},
    // Week 5
    {'day': '25', 'mood': 'none'},
    {'day': '26', 'mood': 'sad'},
    {'day': '27', 'mood': 'sad'},
    {'day': '28', 'mood': 'sad'},
    {'day': '29', 'mood': 'sad'},
  ];

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

  void updateOfficeSelectedValue(String? data) {
    officeSelectedValue = data!;
    notifyListeners();
  }

  void updateMonthSelectedValue(String? data) {
    monthSelectedValue = data!;
    notifyListeners();
  }

  void updateDepartmentSelectedValue(String? data) {
    departmentSelectedValue = data!;
    notifyListeners();
  }

  void updateYearSelectedValue(String? data) {
    yearSelectedValue = data!;
    notifyListeners();
  }

  void updateDate() {
     selectedStartDate = DateFormat('dd-MMM-yyyy').format( DateTime.now());
     selectedEndDate = "";
   notifyListeners();
  }


}
