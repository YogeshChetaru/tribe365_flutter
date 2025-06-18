class ViewReflectionListResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  List<ViewReflectionListData>? data;

  ViewReflectionListResponse({this.code, this.status, this.serviceName, this.message, this.data});

  ViewReflectionListResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ViewReflectionListData>[];
      json['data'].forEach((v) {
        data!.add(new ViewReflectionListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['service_name'] = this.serviceName;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ViewReflectionListData {
  int? id;
  String? message;
  String? image;
  String? createdAt;


  ViewReflectionListData({this.id, this.message, this.image, this.createdAt});

  ViewReflectionListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    image = json['image'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['image'] = this.image;
    data['createdAt'] = this.createdAt;

    return data;
  }
}