import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../localization/language_constrants.dart';
import '../main.dart';

class NetworkInfo {
  final Connectivity? connectivity;
  NetworkInfo(this.connectivity);

  Future<bool> get isConnected async {
    List<ConnectivityResult> results = await connectivity!.checkConnectivity();
    return results.any((result) => result != ConnectivityResult.none);
  }

  static void checkConnectivity(BuildContext context) {
    bool firstTime = true;
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) async {
      if (!firstTime) {
        bool isNotConnected;

        if (results.isEmpty || results.every((r) => r == ConnectivityResult.none)) {
          isNotConnected = true;
        } else {
          isNotConnected = !await _updateConnectivityStatus(); // assumes this returns Future<bool>
        }

        if (!isNotConnected) {
          ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
        }

        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            backgroundColor: isNotConnected ? Colors.red : Colors.green,
            duration: Duration(seconds: isNotConnected ? 6000 : 3),
            content: Text(
              isNotConnected
                  ? getTranslated('no_connection', Get.context!)!
                  : getTranslated('connected', Get.context!)!,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
      firstTime = false;
    });
  }


  static Future<bool> _updateConnectivityStatus() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

}
