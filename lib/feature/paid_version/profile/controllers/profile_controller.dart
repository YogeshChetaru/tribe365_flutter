import 'package:flutter/material.dart';
import '../domain/services/profile_service_interface.dart';


class ProfileController extends ChangeNotifier {
  final ProfileServiceInterface? profileServiceInterface;

  ProfileController({required this.profileServiceInterface});

}
