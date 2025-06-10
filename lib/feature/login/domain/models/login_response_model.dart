class LoginResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  LoginData? data;

  LoginResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    data = json['data'] != null ? LoginData.fromJson(json['data']) : null;
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

class LoginData {
  int? id;
  String? name;
  String? lastName;
  String? email;
  int? officeId;
  int? departmentId;
  String? orgname;
  String? office;
  String? department;
  String? organisationLogo;
  String? role;
  int? orgId;
  String? profileImage;
  String? token;
  bool? isDot;
  bool? firstLogin;
  int? appPaymentVersion;

  LoginData(
      {this.id,
        this.name,
        this.lastName,
        this.email,
        this.officeId,
        this.departmentId,
        this.orgname,
        this.office,
        this.department,
        this.organisationLogo,
        this.role,
        this.orgId,
        this.profileImage,
        this.token,
        this.isDot,
        this.firstLogin,
        this.appPaymentVersion});

  LoginData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastName = json['lastName'];
    email = json['email'];
    officeId = json['officeId'];
    departmentId = json['departmentId'];
    orgname = json['orgname'];
    office = json['office'];
    department = json['department'];
    organisationLogo = json['organisation_logo'];
    role = json['role'];
    orgId = json['orgId'];
    profileImage = json['profileImage'];
    token = json['token'];
    isDot = json['isDot'];
    firstLogin = json['firstLogin'];
    appPaymentVersion = json['appPaymentVersion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['lastName'] = lastName;
    data['email'] = email;
    data['officeId'] = officeId;
    data['departmentId'] = departmentId;
    data['orgname'] = orgname;
    data['office'] = office;
    data['department'] = department;
    data['organisation_logo'] = organisationLogo;
    data['role'] = role;
    data['orgId'] = orgId;
    data['profileImage'] = profileImage;
    data['token'] = token;
    data['isDot'] = isDot;
    data['firstLogin'] = firstLogin;
    data['appPaymentVersion'] = appPaymentVersion;
    return data;
  }
}