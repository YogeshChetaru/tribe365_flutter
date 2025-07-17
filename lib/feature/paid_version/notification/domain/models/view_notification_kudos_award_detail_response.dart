class ViewNotificationKudosAwardDetailResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  List<ViewNotificationKudosAwardDetailData>? data;
  int? totalPageCount;
  String? currentPage;

  ViewNotificationKudosAwardDetailResponse(
      {this.code,
        this.status,
        this.serviceName,
        this.message,
        this.data,
        this.totalPageCount,
        this.currentPage});

  ViewNotificationKudosAwardDetailResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ViewNotificationKudosAwardDetailData>[];
      json['data'].forEach((v) {
        data!.add(ViewNotificationKudosAwardDetailData.fromJson(v));
      });
    }
    totalPageCount = json['totalPageCount'];
    currentPage = json['currentPage'].toString();
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
    data['totalPageCount'] = totalPageCount;
    data['currentPage'] = currentPage;
    return data;
  }
}

class ViewNotificationKudosAwardDetailData {
  int? id;
  String? description;
  String? createdAt;

  ViewNotificationKudosAwardDetailData({this.id, this.description, this.createdAt});

  ViewNotificationKudosAwardDetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['createdAt'] = createdAt;
    return data;
  }
}