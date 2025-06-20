class ViewNotificationCountResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  ViewNotificationCountData? data;

  ViewNotificationCountResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ViewNotificationCountResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    data = json['data'] != null ? ViewNotificationCountData.fromJson(json['data']) : null;
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

class ViewNotificationCountData {
  int? notificationCount;

  ViewNotificationCountData({this.notificationCount});

  ViewNotificationCountData.fromJson(Map<String, dynamic> json) {
    notificationCount = json['notificationCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notificationCount'] = notificationCount;
    return data;
  }
}