class ViewCommentListResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  List<ViewCommentListData>? data;

  ViewCommentListResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ViewCommentListResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ViewCommentListData>[];
      json['data'].forEach((v) {
        data!.add(ViewCommentListData.fromJson(v));
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

class ViewCommentListData {
  int? id;
  int? userId;
  String? comment;
  String? createdAt;
  String? name;

  ViewCommentListData({this.id, this.userId, this.comment, this.createdAt, this.name});

  ViewCommentListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    comment = json['comment'];
    createdAt = json['created_at'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['comment'] = comment;
    data['created_at'] = createdAt;
    data['name'] = name;
    return data;
  }
}