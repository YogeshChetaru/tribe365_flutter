class GetFreeVersionHomeResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  GetFreeVersionHomeData? data;

  GetFreeVersionHomeResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  GetFreeVersionHomeResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    data = json['data'] != null ? GetFreeVersionHomeData.fromJson(json['data']) : null;
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

class GetFreeVersionHomeData {
  bool? userGivenFeedback;
  List<HappyIndexMonthly>? happyIndexMonthly;
  String? firstDayOfMonth;
  List<int>? orgYearList;
  List<String>? notWorkingDays;
  int? appPaymentVersion;
  int? leaveStatus;

  GetFreeVersionHomeData(
      {this.userGivenFeedback,
        this.happyIndexMonthly,
        this.firstDayOfMonth,
        this.orgYearList,
        this.notWorkingDays,
        this.appPaymentVersion,
        this.leaveStatus});

  GetFreeVersionHomeData.fromJson(Map<String, dynamic> json) {
    userGivenFeedback = json['userGivenfeedback'];
    if (json['happyIndexMonthly'] != null) {
      happyIndexMonthly = <HappyIndexMonthly>[];
      json['happyIndexMonthly'].forEach((v) {
        happyIndexMonthly!.add(HappyIndexMonthly.fromJson(v));
      });
    }
    firstDayOfMonth = json['firstDayOfMonth'];
    orgYearList = json['orgYearList'].cast<int>();
    notWorkingDays = json['notWorkingDays'].cast<String>();
    appPaymentVersion = json['appPaymentVersion'];
    leaveStatus = json['leaveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userGivenfeedback'] = userGivenFeedback;
    if (happyIndexMonthly != null) {
      data['happyIndexMonthly'] =
          happyIndexMonthly!.map((v) => v.toJson()).toList();
    }
    data['firstDayOfMonth'] = firstDayOfMonth;
    data['orgYearList'] = orgYearList;
    data['notWorkingDays'] = notWorkingDays;
    data['appPaymentVersion'] = appPaymentVersion;
    data['leaveStatus'] = leaveStatus;
    return data;
  }
}

class HappyIndexMonthly {
  String? date;
  double? score;

  HappyIndexMonthly({this.date, this.score});

  HappyIndexMonthly.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    score = double.parse(json['score'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['score'] = score;
    return data;
  }
}