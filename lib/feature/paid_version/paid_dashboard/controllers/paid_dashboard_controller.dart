import 'package:flutter/material.dart';
import '../domain/services/paid_dashboard_service_interface.dart';

class PaidDashboardController extends ChangeNotifier {
  final PaidDashboardServiceInterface? paidDashboardServiceInterface;

  PaidDashboardController({required this.paidDashboardServiceInterface});



}
