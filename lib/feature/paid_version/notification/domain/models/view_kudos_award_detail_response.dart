class ViewKudosAwardDetailResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  List<ViewKudosAwardDetailData>? data;

  ViewKudosAwardDetailResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ViewKudosAwardDetailResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ViewKudosAwardDetailData>[];
      json['data'].forEach((v) {
        data!.add(ViewKudosAwardDetailData.fromJson(v));
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

class ViewKudosAwardDetailData {
  String? id;
  String? dotName;
  int? awardCount;
  List<DotValAward>? dotValAward;
  bool? countStatus;

  ViewKudosAwardDetailData(
      {this.id,
        this.dotName,
        this.awardCount,
        this.dotValAward,
        this.countStatus});

  ViewKudosAwardDetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    dotName = json['dotName'];
    awardCount = json['awardCount'];
    if (json['dotValAward'] != null) {
      dotValAward = <DotValAward>[];
      json['dotValAward'].forEach((v) {
        dotValAward!.add(DotValAward.fromJson(v));
      });
    }
    countStatus = json['countStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['dotName'] = dotName;
    data['awardCount'] = awardCount;
    if (dotValAward != null) {
      data['dotValAward'] = dotValAward!.map((v) => v.toJson()).toList();
    }
    data['countStatus'] = countStatus;
    return data;
  }
}

class DotValAward {
  int? awardId;
  String? description;
  String? createdAt;

  DotValAward({this.awardId, this.description, this.createdAt});

  DotValAward.fromJson(Map<String, dynamic> json) {
    awardId = json['awardId'];
    description = json['description'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['awardId'] = awardId;
    data['description'] = description;
    data['createdAt'] = createdAt;
    return data;
  }
}