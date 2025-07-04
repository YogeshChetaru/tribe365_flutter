import 'package:tribe365_new/feature/paid_version/profile/domain/models/view_action_list_response.dart';

class ViewThemeListResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  ViewThemeListData? data;

  ViewThemeListResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ViewThemeListResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    data = json['data'] != null ? ViewThemeListData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    data['service_name'] = serviceName;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ViewThemeListData {
  List<ModelTheme>? themeList;

  ViewThemeListData({this.themeList});

  ViewThemeListData.fromJson(Map<String, dynamic> json) {
    if (json['themeList'] != null) {
      themeList = <ModelTheme>[];
      json['themeList'].forEach((v) {
        themeList!.add(ModelTheme.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (themeList != null) {
      data['themeList'] = themeList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
