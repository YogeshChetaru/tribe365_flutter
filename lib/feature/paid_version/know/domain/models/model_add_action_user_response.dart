class ModelAddActionUserResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  List<ModelAddActionUserData>? data;

  ModelAddActionUserResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ModelAddActionUserResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ModelAddActionUserData>[];
      json['data'].forEach((v) {
        data!.add(ModelAddActionUserData.fromJson(v));
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

class ModelAddActionUserData {
  int? id;
  String? name;
  String? lastName;
  String? email;
  String? status;
  int? roleId;
  int? orgId;
  int? officeId;
  int? departmentId;

  ModelAddActionUserData(
      {this.id,
        this.name,
        this.lastName,
        this.email,
        this.status,
        this.roleId,
        this.orgId,
        this.officeId,
        this.departmentId});

  ModelAddActionUserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastName = json['lastName'];
    email = json['email'];
    status = json['status'];
    roleId = json['roleId'];
    orgId = json['orgId'];
    officeId = json['officeId'];
    departmentId = json['departmentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['lastName'] = lastName;
    data['email'] = email;
    data['status'] = status;
    data['roleId'] = roleId;
    data['orgId'] = orgId;
    data['officeId'] = officeId;
    data['departmentId'] = departmentId;
    return data;
  }
}