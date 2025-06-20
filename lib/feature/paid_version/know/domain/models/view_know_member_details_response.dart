import '../../../profile/domain/models/viewuserprofileresponse.dart';

class ViewKnowMemberDetailsResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  ViewKnowMemberDetailsData? data;

  ViewKnowMemberDetailsResponse({this.code, this.status, this.serviceName, this.message, this.data});

  ViewKnowMemberDetailsResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    data = json['data'] != null ? ViewKnowMemberDetailsData.fromJson(json['data']) : null;
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

class ViewKnowMemberDetailsData {
  final bool? personaliseData;
  int? appPaymentVersion;
  final String? engagementIndexScore;
  final List<KudosCount>? kudosCount;
  final List<PersonalityTypeDetailsArr>? personalityType;
  final List<String>? teamRole;
  final List<String>? motivation;
  final String? perTypeDetails;
  final String? teamRoleDetails;
  final String? motivationDetails;

  ViewKnowMemberDetailsData({
    this.personaliseData,
    this.appPaymentVersion,
    this.engagementIndexScore,
    this.kudosCount,
    this.personalityType,
    this.teamRole,
    this.motivation,
    this.perTypeDetails,
    this.teamRoleDetails,
    this.motivationDetails,
  });

  factory ViewKnowMemberDetailsData.fromJson(Map<String, dynamic> json) {
    return ViewKnowMemberDetailsData(
      personaliseData: json['personaliseData'],
      appPaymentVersion: json['appPaymentVersion'],
      engagementIndexScore: json['engagementIndexScore'],
      kudosCount: (json['kudosCount'] as List<dynamic>?)?.map((e) => KudosCount.fromJson(e)).toList(),
      personalityType: (json['personalityType'] as List<dynamic>?)?.map((e) => PersonalityTypeDetailsArr.fromJson(e)).toList(),
      teamRole: (json['teamRole'] as List<dynamic>?)?.cast<String>(),
      motivation: (json['motivation'] as List<dynamic>?)?.cast<String>(),
      perTypeDetails: json['perTypeDetails'],
      teamRoleDetails: json['teamRoleDetails'],
      motivationDetails: json['motivationDetails'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'personaliseData': personaliseData,
      'appPaymentVersion': appPaymentVersion,
      'engagementIndexScore': engagementIndexScore,
      'kudosCount': kudosCount?.map((e) => e.toJson()).toList(),
      'personalityType': personalityType?.map((e) => e.toJson()).toList(),
      'teamRole': teamRole,
      'motivation': motivation,
      'perTypeDetails': perTypeDetails,
      'teamRoleDetails': teamRoleDetails,
      'motivationDetails': motivationDetails,
    };
  }
}


class KudosCount {
  final String? name;
  final int? kudosCount;

  KudosCount({
    this.name,
    this.kudosCount,
  });

  factory KudosCount.fromJson(Map<String, dynamic> json) {
    return KudosCount(
      name: json['name'],
      kudosCount: json['KudosCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'KudosCount': kudosCount,
    };
  }
}
