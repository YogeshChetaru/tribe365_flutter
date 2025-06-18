class ViewOffLoadingListResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  List<ViewOffLoadingListData>? data;
  int? totalPageCount;
  int? currentPage;

  ViewOffLoadingListResponse({this.code, this.status, this.serviceName, this.message, this.data, this.totalPageCount, this.currentPage});

  ViewOffLoadingListResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ViewOffLoadingListData>[];
      json['data'].forEach((v) {
        data!.add(ViewOffLoadingListData.fromJson(v));
      });
    }
    totalPageCount = json['totalPageCount'];
    currentPage = json['currentPage'];
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

class ViewOffLoadingListData {
  int? id;
  String? message;
  String? image;
  String? createdAt;
  String? status;

  ViewOffLoadingListData({
    this.id,
    this.message,
    this.image,
    this.createdAt,
    this.status,
  });

  ViewOffLoadingListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    image = json['image'];
    createdAt = json['createdAt'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = message;
    data['image'] = image;
    data['createdAt'] = createdAt;
    data['status'] = status;
    return data;
  }
}
