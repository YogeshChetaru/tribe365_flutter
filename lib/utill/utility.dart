import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:io' show Platform, File;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';


class Utility {
  static String changeDateDMYtoYMD(String date) {
    try {
      final inputFormat = DateFormat('dd-MMM-yyyy');
      final outputFormat = DateFormat('yyyy-MM-dd');
      final parsedDate = inputFormat.parse(date);
      return outputFormat.format(parsedDate);
    } catch (e) {
      // print("Parse error: $e");
      return "";
    }
  }

  static Future<String?> imageToBase64(String filePath) async {
    try {
      File imageFile = File(filePath);
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64String = base64Encode(imageBytes);
      return base64String;
    } catch (e) {
      debugPrint("Error converting image to Base64: $e");
      return null;
    }
  }

  static String convertDataIntoddMMMyyyyhhmma(String inputDate) {
    try {
      final parsedDate = DateTime.parse(inputDate);
      final now = DateTime.now();
      final difference = now.difference(parsedDate);

      if (difference.inSeconds < 60) {
        return 'just now';
      } else if (difference.inMinutes < 60) {
        return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
      } else if (difference.inHours < 24) {
        return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
      } else if (difference.inDays == 1) {
        return 'yesterday';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} days ago';
      } else {
        final formatter = DateFormat('dd MMM yyyy, hh:mm a');
        return formatter.format(parsedDate);
      }
    } catch (e) {
      return inputDate; // fallback in case of error
    }
  }
  static String getCurrentDate() {
    final now = DateTime.now().toUtc();
    final formattedDate = "${now.year.toString().padLeft(4, '0')}-"
        "${now.month.toString().padLeft(2, '0')}-"
        "${now.day.toString().padLeft(2, '0')} "
        "${now.hour.toString().padLeft(2, '0')}:"
        "${now.minute.toString().padLeft(2, '0')}:"
        "${now.second.toString().padLeft(2, '0')}";
    return formattedDate;
  }


 static Future<Map<String, String>> getAppVersionInfo() async {
    try {
      String platform;

      if (kIsWeb) {
        platform = 'Web';
        return {
          'version': 'Unknown',
          'buildNumber': 'Unknown',
          'platform': platform,
        };
      } else if (Platform.isAndroid) {
        platform = 'Android';
      } else if (Platform.isIOS) {
        platform = 'iOS';
      } else if (Platform.isMacOS) {
        platform = 'macOS';
      } else if (Platform.isWindows) {
        platform = 'Windows';
      } else if (Platform.isLinux) {
        platform = 'Linux';
      } else {
        platform = 'Unknown';
      }

      final PackageInfo info = await PackageInfo.fromPlatform();
      return {
        'version': info.version,         // e.g., "1.0.2"
        'buildNumber': info.buildNumber, // e.g., "3"
        'platform': platform,
      };
    } catch (e) {
      return {
        'version': 'Error',
        'buildNumber': 'Error',
        'platform': 'Error',
      };
    }
  }



  static Future<void> openAppInStore() async {
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final String packageName = packageInfo.packageName;

      String url = '';
      if (Platform.isAndroid) {
        // Try Play Store app
        final playStoreUrl = Uri.parse("market://details?id=$packageName");
        if (await canLaunchUrl(playStoreUrl)) {
          await launchUrl(playStoreUrl);
          return;
        }
        // Fallback to browser
        url = "https://play.google.com/store/apps/details?id=$packageName";
      } else if (Platform.isIOS) {
        // Replace with your actual App Store ID
        url = "https://apps.apple.com/app/idYOUR_APP_ID";
      }

      if (url.isNotEmpty) {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          throw 'Could not launch $url';
        }
      }
    } catch (e) {
      debugPrint('Error opening store: $e');
    }
  }


}
