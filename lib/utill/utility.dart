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
}
