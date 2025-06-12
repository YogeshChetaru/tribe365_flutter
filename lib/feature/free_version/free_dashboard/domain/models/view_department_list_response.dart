class ViewDepartmentListResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  List<ViewDepartmentListData>? data;

  ViewDepartmentListResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ViewDepartmentListResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ViewDepartmentListData>[];
      json['data'].forEach((v) {
        data!.add(ViewDepartmentListData.fromJson(v));
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

class ViewDepartmentListData {
  int? id;
  String? department;

  ViewDepartmentListData({this.id, this.department});

  ViewDepartmentListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    department = json['department'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['department'] = department;
    return data;
  }
}