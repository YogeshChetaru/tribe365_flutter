import 'package:tribe365_new/feature/free_version/free_dashboard/domain/models/view_department_list_response.dart';

class ViewOfficeListResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  ViewOfficeListData? data;

  ViewOfficeListResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ViewOfficeListResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    data = json['data'] != null ? ViewOfficeListData.fromJson(json['data']) : null;
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

class ViewOfficeListData {
  List<Offices>? offices;

  ViewOfficeListData({this.offices});

  ViewOfficeListData.fromJson(Map<String, dynamic> json) {
    if (json['offices'] != null) {
      offices = <Offices>[];
      json['offices'].forEach((v) {
        offices!.add(Offices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (offices != null) {
      data['offices'] = offices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Offices {
  int? officeId;
  String? office;
  List<ViewDepartmentListData>? department;

  Offices({this.officeId, this.office, this.department});

  Offices.fromJson(Map<String, dynamic> json) {
    officeId = json['officeId'];
    office = json['office'];
    if (json['department'] != null) {
      department = <ViewDepartmentListData>[];
      json['department'].forEach((v) {
        department!.add(ViewDepartmentListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['officeId'] = officeId;
    data['office'] = office;
    if (department != null) {
      data['department'] = department!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
