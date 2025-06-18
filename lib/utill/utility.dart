import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

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
}
