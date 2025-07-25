import 'package:tribe365_new/feature/paid_version/profile/domain/models/view_action_list_response.dart';

class ViewActionDetailResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  List<ViewActionListData>? data;

  ViewActionDetailResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ViewActionDetailResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ViewActionListData>[];
      json['data'].forEach((v) {
        data!.add(ViewActionListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    data['service_name'] = serviceName;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
