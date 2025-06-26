class ViewDepartmentUserListResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  ViewDepartmentUserListData? data;

  ViewDepartmentUserListResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ViewDepartmentUserListResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    data = json['data'] != null ? ViewDepartmentUserListData.fromJson(json['data']) : null;
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

class ViewDepartmentUserListData {
  List<ViewDepartmentUsers>? users;
  List<ViewDepartmentDepartment>? departments;

  ViewDepartmentUserListData({this.users, this.departments});

  ViewDepartmentUserListData.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <ViewDepartmentUsers>[];
      json['users'].forEach((v) {
        users!.add(ViewDepartmentUsers.fromJson(v));
      });
    }
    if (json['departments'] != null) {
      departments = <ViewDepartmentDepartment>[];
      json['departments'].forEach((v) {
        departments!.add(ViewDepartmentDepartment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    if (departments != null) {
      data['departments'] = departments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ViewDepartmentUsers {
  int? id;
  String? name;
  bool isSelected =false;

  ViewDepartmentUsers({this.id, this.name,this.isSelected = false});

  ViewDepartmentUsers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['isSelected']=isSelected;
    return data;
  }
}

class ViewDepartmentDepartment {
  int? departmentId;
  String? name;

  ViewDepartmentDepartment({this.departmentId, this.name});

  ViewDepartmentDepartment.fromJson(Map<String, dynamic> json) {
    departmentId = json['department_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['department_id'] = departmentId;
    data['name'] = name;
    return data;
  }
}