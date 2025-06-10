class ViewHomeResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  ViewHomeData? data;

  ViewHomeResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ViewHomeResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    data = json['data'] != null ? ViewHomeData.fromJson(json['data']) : null;
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

class ViewHomeData {
  int? appPaymentVersion;
  String? todayEIScore;
  bool? userGivenfeedback;
  bool? badDayOffload;
  String? kudoAwardKey;
  int? kudoAwardValue;
  String? dotId;
  String? vision;
  String? visionUrl;
  String? visionDesc;
  int? leaveStatus;
  int? notificationPush;
  int? deviceNotificationPush;

  ViewHomeData(
      {this.appPaymentVersion,
        this.todayEIScore,
        this.userGivenfeedback,
        this.badDayOffload,
        this.kudoAwardKey,
        this.kudoAwardValue,
        this.dotId,
        this.vision,
        this.visionUrl,
        this.visionDesc,
        this.leaveStatus,
        this.notificationPush,
        this.deviceNotificationPush});

  ViewHomeData.fromJson(Map<String, dynamic> json) {
    appPaymentVersion = json['appPaymentVersion'];
    todayEIScore = json['todayEIScore'];
    userGivenfeedback = json['userGivenfeedback'];
    badDayOffload = json['badDayOffload'];
    kudoAwardKey = json['kudoAwardKey'];
    kudoAwardValue = json['kudoAwardValue'];
    dotId = json['dotId'];
    vision = json['vision'];
    visionUrl = json['visionUrl'];
    visionDesc = json['visionDesc'];
    leaveStatus = json['leaveStatus'];
    notificationPush = json['notificationPush'];
    deviceNotificationPush = json['deviceNotificationPush'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appPaymentVersion'] = appPaymentVersion;
    data['todayEIScore'] = todayEIScore;
    data['userGivenfeedback'] = userGivenfeedback;
    data['badDayOffload'] = badDayOffload;
    data['kudoAwardKey'] = kudoAwardKey;
    data['kudoAwardValue'] = kudoAwardValue;
    data['dotId'] = dotId;
    data['vision'] = vision;
    data['visionUrl'] = visionUrl;
    data['visionDesc'] = visionDesc;
    data['leaveStatus'] = leaveStatus;
    data['notificationPush'] = notificationPush;
    data['deviceNotificationPush'] = deviceNotificationPush;
    return data;
  }
}