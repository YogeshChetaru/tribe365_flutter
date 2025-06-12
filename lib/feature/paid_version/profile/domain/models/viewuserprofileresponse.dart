class ViewUserProfileResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  ViewUserProfileData? data;

  ViewUserProfileResponse({this.code, this.status, this.serviceName, this.message, this.data});

  ViewUserProfileResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    data = json['data'] != null ? ViewUserProfileData.fromJson(json['data']) : null;
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

class ViewUserProfileData {
  int? id;
  String? name;
  String? lastName;
  String? email;
  int? officeId;
  int? departmentId;
  int? role;
  String? status;
  String? userContact;
  int? orgId;
  String? organisationName;
  String? officeName;
  String? departmentName;
  int? personaliseData;
  String? profileImage;
  String? organisationLogo;
  String? cotTeamRoleMap;
  String? sotDetail;
  String? sotMotivationDetail;
  bool? perTypeStatus;
  String? personalityTypeDetails;
  List<PersonalityTypeDetailsArr>? personalityTypeDetailsArr;

  ViewUserProfileData({
    this.id,
    this.name,
    this.lastName,
    this.email,
    this.officeId,
    this.departmentId,
    this.role,
    this.status,
    this.userContact,
    this.orgId,
    this.organisationName,
    this.officeName,
    this.departmentName,
    this.personaliseData,
    this.profileImage,
    this.organisationLogo,
    this.cotTeamRoleMap,
    this.sotDetail,
    this.sotMotivationDetail,
    this.perTypeStatus,
    this.personalityTypeDetails,
    this.personalityTypeDetailsArr
  });

  ViewUserProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastName = json['lastName'];
    email = json['email'];
    officeId = json['officeId'];
    departmentId = json['departmentId'];
    role = json['role'];
    status = json['status'];
    userContact = json['userContact'];
    orgId = json['orgId'];
    organisationName = json['organisationName'];
    officeName = json['officeName'];
    departmentName = json['departmentName'];
    personaliseData = json['personaliseData'];
    profileImage = json['profileImage'];
    organisationLogo = json['organisation_logo'];
    cotTeamRoleMap = json['cotTeamRoleMap'];
    sotDetail = json['sotDetail'];
    sotMotivationDetail = json['sotMotivationDetail'];
    perTypeStatus = json['perTypeStatus'];
    personalityTypeDetails = json['personalityTypeDetails'];
    if (json['personalityTypeDetailsArr'] != null) {
      personalityTypeDetailsArr = <PersonalityTypeDetailsArr>[];
      json['personalityTypeDetailsArr'].forEach((v) {
        personalityTypeDetailsArr!
            .add( PersonalityTypeDetailsArr.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['lastName'] = lastName;
    data['email'] = email;
    data['officeId'] = officeId;
    data['departmentId'] = departmentId;
    data['role'] = role;
    data['status'] = status;
    data['userContact'] = userContact;
    data['orgId'] = orgId;
    data['organisationName'] = organisationName;
    data['officeName'] = officeName;
    data['departmentName'] = departmentName;
    data['personaliseData'] = personaliseData;
    data['profileImage'] = profileImage;
    data['organisation_logo'] = organisationLogo;
    data['cotTeamRoleMap'] = cotTeamRoleMap;
    data['sotDetail'] = sotDetail;
    data['sotMotivationDetail'] = sotMotivationDetail;
    data['perTypeStatus'] = perTypeStatus;
    data['personalityTypeDetails'] = personalityTypeDetails;
    if (personalityTypeDetailsArr != null) {
      data['personalityTypeDetailsArr'] =
          personalityTypeDetailsArr!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class PersonalityTypeDetailsArr {
  String? cateName;
  int? score;

  PersonalityTypeDetailsArr({this.cateName, this.score});

  PersonalityTypeDetailsArr.fromJson(Map<String, dynamic> json) {
    cateName = json['cateName'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cateName'] = cateName;
    data['score'] = score;
    return data;
  }
}
