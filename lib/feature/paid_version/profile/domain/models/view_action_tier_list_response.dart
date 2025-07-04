class ViewActionTierListResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  List<ViewActionTierListData>? data;

  ViewActionTierListResponse({this.code, this.status, this.serviceName, this.message, this.data});

  ViewActionTierListResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ViewActionTierListData>[];
      json['data'].forEach((v) {
        data!.add(ViewActionTierListData.fromJson(v));
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

class ViewActionTierListData {
  int? id;
  String? name;

  ViewActionTierListData({this.id, this.name});

  ViewActionTierListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
