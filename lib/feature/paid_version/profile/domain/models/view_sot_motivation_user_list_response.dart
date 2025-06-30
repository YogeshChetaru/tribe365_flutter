class ViewSotMotivationUserListResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  List<ViewSotMotivationUserListData>? data;

  ViewSotMotivationUserListResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ViewSotMotivationUserListResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ViewSotMotivationUserListData>[];
      json['data'].forEach((v) {
        data!.add(ViewSotMotivationUserListData.fromJson(v));
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

class ViewSotMotivationUserListData {
  String? title;
  String? score;

  ViewSotMotivationUserListData({this.title, this.score});

  ViewSotMotivationUserListData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['score'] = score;
    return data;
  }
}