class ViewPersonalityTypeReportResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  List<ViewPersonalityTypeReportData>? data;

  ViewPersonalityTypeReportResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ViewPersonalityTypeReportResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ViewPersonalityTypeReportData>[];
      json['data'].forEach((v) {
        data!.add(new ViewPersonalityTypeReportData.fromJson(v));
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

class ViewPersonalityTypeReportData {
  String? title;
  int? categoryId;
  String? score;
  String? percentage;

  ViewPersonalityTypeReportData({this.title, this.categoryId, this.score, this.percentage});

  ViewPersonalityTypeReportData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    categoryId = json['categoryId'];
    score = json['score'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['categoryId'] = categoryId;
    data['score'] = score;
    data['percentage'] = percentage;
    return data;
  }
}