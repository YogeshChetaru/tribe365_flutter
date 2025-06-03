import 'package:flutter/material.dart';

class DayData {
  final String day;
  final String date;
  final IconData? mood;

  DayData({required this.day, required this.date, this.mood});
}