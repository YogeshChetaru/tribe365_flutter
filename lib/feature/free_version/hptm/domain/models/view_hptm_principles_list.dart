class ViewHPTMPrinciplesList {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  ViewHPTMPrinciplesData? data;

  ViewHPTMPrinciplesList(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ViewHPTMPrinciplesList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    data = json['data'] != null ? ViewHPTMPrinciplesData.fromJson(json['data']) : null;
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

class ViewHPTMPrinciplesData {
  List<PrincipleData>? principleData;
  int? hPTMScore;

  ViewHPTMPrinciplesData({this.principleData, this.hPTMScore});

  ViewHPTMPrinciplesData.fromJson(Map<String, dynamic> json) {
    if (json['principleData'] != null) {
      principleData = <PrincipleData>[];
      json['principleData'].forEach((v) {
        principleData!.add(PrincipleData.fromJson(v));
      });
    }
    hPTMScore = json['hptmScore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (principleData != null) {
      data['principleData'] =
          principleData!.map((v) => v.toJson()).toList();
    }
    data['hptmScore'] = hPTMScore;
    return data;
  }
}

class PrincipleData {
  int? id;
  String? title;
  String? description;
  int? teamFeedbackScorePercent;
  String? completionPercent;

  PrincipleData(
      {this.id,
        this.title,
        this.description,
        this.teamFeedbackScorePercent,
        this.completionPercent});

  PrincipleData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    teamFeedbackScorePercent = json['teamFeedbackScorePercent'];
    completionPercent = json['completionPercent'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['teamFeedbackScorePercent'] = teamFeedbackScorePercent;
    data['completionPercent'] = completionPercent;
    return data;
  }
}