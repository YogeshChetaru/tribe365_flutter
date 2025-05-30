import 'dart:developer';

import '../common/basewidget/show_custom_snakbar_widget.dart';
import '../data/model/api_response.dart';
import '../data/model/error_response.dart';
import '../localization/language_constrants.dart';
import '../main.dart';

class ApiChecker {
  static void checkApi(ApiResponse apiResponse) {
    if(apiResponse.error == "Failed to load data - status code: 401") {
      // Provider.of<AuthController>(Get.context!,listen: false).clearSharedData();
    }else if(apiResponse.response?.statusCode == 500){
      showCustomSnackBar(getTranslated('internal_server_error', Get.context!), Get.context!);
    }else {
      log("==ff=>${apiResponse.error}");
      if (apiResponse.error is String) {
      } else {
        ErrorResponse errorResponse = ErrorResponse.fromJson(apiResponse.error);
        log(errorResponse.toString());
      }
    }
  }
}