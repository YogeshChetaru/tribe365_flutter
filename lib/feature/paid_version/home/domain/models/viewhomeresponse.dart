class ViewHomeResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  ViewHomeData? data;

  ViewHomeResponse({
    this.code,
    this.status,
    this.serviceName,
    this.message,
    this.data,
  });

  factory ViewHomeResponse.fromJson(Map<String, dynamic> json) {
    return ViewHomeResponse(
      code: json['code'],
      status: json['status'],
      serviceName: json['service_name'],
      message: json['message'],
      data: json['data'] != null ? ViewHomeData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['code'] = code;
    result['status'] = status;
    result['service_name'] = serviceName;
    result['message'] = message;
    if (data != null) {
      result['data'] = data!.toJson();
    }
    return result;
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
  List<LatestKudoAward>? latestKAward;
  List<HomeBelief>? belief;
  LatestKudoAward? latestKudosAward;

  ViewHomeData({
    this.appPaymentVersion,
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
    this.deviceNotificationPush,
    this.latestKAward,
    this.belief,
    this.latestKudosAward,
  });

  factory ViewHomeData.fromJson(Map<String, dynamic> json) {
    return ViewHomeData(
      appPaymentVersion: json['appPaymentVersion'],
      todayEIScore: json['todayEIScore'],
      userGivenfeedback: json['userGivenfeedback'],
      badDayOffload: json['badDayOffload'],
      kudoAwardKey: json['kudoAwardKey'],
      kudoAwardValue: json['kudoAwardValue'],
      dotId: json['dotId'],
      vision: json['vision'],
      visionUrl: json['visionUrl'],
      visionDesc: json['visionDesc'],
      leaveStatus: json['leaveStatus'],
      notificationPush: json['notificationPush'],
      deviceNotificationPush: json['deviceNotificationPush'],
      latestKAward: (json['latestKudosAward'] as List<dynamic>?)?.map((e) => LatestKudoAward.fromJson(e)).toList(),
      latestKudosAward: json['latestKudoAward'] != null ? LatestKudoAward.fromJson(json['latestKudoAward']) : null,
      belief: (json['belief'] as List<dynamic>?)?.map((e) => HomeBelief.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appPaymentVersion': appPaymentVersion,
      'todayEIScore': todayEIScore,
      'userGivenfeedback': userGivenfeedback,
      'badDayOffload': badDayOffload,
      'kudoAwardKey': kudoAwardKey,
      'kudoAwardValue': kudoAwardValue,
      'dotId': dotId,
      'vision': vision,
      'visionUrl': visionUrl,
      'visionDesc': visionDesc,
      'leaveStatus': leaveStatus,
      'notificationPush': notificationPush,
      'deviceNotificationPush': deviceNotificationPush,
      'latestKudosAward': latestKAward?.map((e) => e.toJson()).toList(),
      'latestKudoAward': latestKudosAward?.toJson(),
      'belief': belief?.map((e) => e.toJson()).toList(),
    };
  }
}

class LatestKudoAward {
  final String? userName;
  final String? userImage;
  final String? awardDescription;
  final String? awardDate;
  final String? awardValue;
  final int kudoAwardCount;

  LatestKudoAward({
    this.userName,
    this.userImage,
    this.awardDescription,
    this.awardDate,
    this.awardValue,
    required this.kudoAwardCount,
  });

  factory LatestKudoAward.fromJson(Map<String, dynamic> json) {
    return LatestKudoAward(
      userName: json['userName'],
      userImage: json['userImage'],
      awardDescription: json['awardDescription'],
      awardDate: json['awardDate'],
      awardValue: json['awardValue'],
      kudoAwardCount: json['kudoAwardCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'userImage': userImage,
      'awardDescription': awardDescription,
      'awardDate': awardDate,
      'awardValue': awardValue,
      'kudoAwardCount': kudoAwardCount,
    };
  }
}

class HomeBelief {
  int? id;
  String? name;
  String? valueUrl;
  String? valueDesc;
  String? valueId;
  int? beliefId;
  int? dotId;
  int? todayKudosCount;
  int? yesterdayKudosCount;
  int? thisWeekKudosCount;
  int? lastWeekKudosCount;
  int? thisMonthKudosCount;
  int? lastMonthKudosCount;
  int? totalKudosCount;
  int? todayDotValueKudoAwardCount;
  int? yesterdayDotValueKudoAwardCount;
  int? thisWeekDotValueKudoAwardCount;
  int? lastWeekDotValueKudoAwardCount;
  int? thisMonthDotValueKudoAwardCount;
  int? lastMonthDotValueKudoAwardCount;
  int? totalDotValueKudoAwardCount;
  int? amazingValue;
  bool isValue;
  bool isSelected;

  HomeBelief({
    this.id,
    this.name,
    this.valueUrl,
    this.valueDesc,
    this.valueId,
    this.beliefId,
    this.dotId,
    this.todayKudosCount,
    this.yesterdayKudosCount,
    this.thisWeekKudosCount,
    this.lastWeekKudosCount,
    this.thisMonthKudosCount,
    this.lastMonthKudosCount,
    this.totalKudosCount,
    this.todayDotValueKudoAwardCount,
    this.yesterdayDotValueKudoAwardCount,
    this.thisWeekDotValueKudoAwardCount,
    this.lastWeekDotValueKudoAwardCount,
    this.thisMonthDotValueKudoAwardCount,
    this.lastMonthDotValueKudoAwardCount,
    this.totalDotValueKudoAwardCount,
    this.amazingValue,
    this.isValue = false,
    this.isSelected = false,
  });

  factory HomeBelief.fromJson(Map<String, dynamic> json) {
    return HomeBelief(
      id: json['id'],
      name: json['name'],
      valueUrl: json['valueUrl'],
      valueDesc: json['valueDesc'],
      valueId: json['valueId'],
      beliefId: json['beliefId'],
      dotId: json['dotId'],
      todayKudosCount: json['todayKudosCount'],
      yesterdayKudosCount: json['yesterdayKudosCount'],
      thisWeekKudosCount: json['thisWeekKudosCount'],
      lastWeekKudosCount: json['lastWeekKudosCount'],
      thisMonthKudosCount: json['thisMonthKudosCount'],
      lastMonthKudosCount: json['lastMonthKudosCount'],
      totalKudosCount: json['totalKudosCount'],
      todayDotValueKudoAwardCount: json['todayDotValueKudoAwardCount'],
      yesterdayDotValueKudoAwardCount: json['yesterdayDotValueKudoAwardCount'],
      thisWeekDotValueKudoAwardCount: json['thisWeekDotValueKudoAwardCount'],
      lastWeekDotValueKudoAwardCount: json['lastWeekDotValueKudoAwardCount'],
      thisMonthDotValueKudoAwardCount: json['thisMonthDotValueKudoAwardCount'],
      lastMonthDotValueKudoAwardCount: json['lastMonthDotValueKudoAwardCount'],
      totalDotValueKudoAwardCount: json['totalDotValueKudoAwardCount'],
      amazingValue: json['amazingValue'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'valueUrl': valueUrl,
      'valueDesc': valueDesc,
      'valueId': valueId,
      'beliefId': beliefId,
      'dotId': dotId,
      'todayKudosCount': todayKudosCount,
      'yesterdayKudosCount': yesterdayKudosCount,
      'thisWeekKudosCount': thisWeekKudosCount,
      'lastWeekKudosCount': lastWeekKudosCount,
      'thisMonthKudosCount': thisMonthKudosCount,
      'lastMonthKudosCount': lastMonthKudosCount,
      'totalKudosCount': totalKudosCount,
      'todayDotValueKudoAwardCount': todayDotValueKudoAwardCount,
      'yesterdayDotValueKudoAwardCount': yesterdayDotValueKudoAwardCount,
      'thisWeekDotValueKudoAwardCount': thisWeekDotValueKudoAwardCount,
      'lastWeekDotValueKudoAwardCount': lastWeekDotValueKudoAwardCount,
      'thisMonthDotValueKudoAwardCount': thisMonthDotValueKudoAwardCount,
      'lastMonthDotValueKudoAwardCount': lastMonthDotValueKudoAwardCount,
      'totalDotValueKudoAwardCount': totalDotValueKudoAwardCount,
      'amazingValue': amazingValue,
      'isValue': isValue,
      'isSelected': isSelected,
    };
  }
}
