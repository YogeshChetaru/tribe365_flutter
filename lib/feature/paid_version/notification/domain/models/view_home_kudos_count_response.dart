class ViewHomeKudosCountResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  ViewHomeKudosCountData? data;

  ViewHomeKudosCountResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ViewHomeKudosCountResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    data = json['data'] != null ? ViewHomeKudosCountData.fromJson(json['data']) : null;
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

class ViewHomeKudosCountData {
  List<ViewHomeKudosCountBelief>? belief;
  String? kudoAwardKey;
  int? todayKudosAwardCount;
  int? yesterdayKudosAwardCount;
  int? thisWeekKudosAwardCount;
  int? lastWeekKudosAwardCount;
  int? thisMonthKudosAwardCount;
  int? lastMonthKudosAwardCount;
  int? totalKudosAwardCount;

  ViewHomeKudosCountData(
      {this.belief,
        this.kudoAwardKey,
        this.todayKudosAwardCount,
        this.yesterdayKudosAwardCount,
        this.thisWeekKudosAwardCount,
        this.lastWeekKudosAwardCount,
        this.thisMonthKudosAwardCount,
        this.lastMonthKudosAwardCount,
        this.totalKudosAwardCount});

  ViewHomeKudosCountData.fromJson(Map<String, dynamic> json) {
    if (json['belief'] != null) {
      belief = <ViewHomeKudosCountBelief>[];
      json['belief'].forEach((v) {
        belief!.add(ViewHomeKudosCountBelief.fromJson(v));
      });
    }
    kudoAwardKey = json['kudoAwardKey'];
    todayKudosAwardCount = json['todayKudosAwardCount'];
    yesterdayKudosAwardCount = json['yesterdayKudosAwardCount'];
    thisWeekKudosAwardCount = json['thisWeekKudosAwardCount'];
    lastWeekKudosAwardCount = json['lastWeekKudosAwardCount'];
    thisMonthKudosAwardCount = json['thisMonthKudosAwardCount'];
    lastMonthKudosAwardCount = json['lastMonthKudosAwardCount'];
    totalKudosAwardCount = json['totalKudosAwardCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (belief != null) {
      data['belief'] = belief!.map((v) => v.toJson()).toList();
    }
    data['kudoAwardKey'] = kudoAwardKey;
    data['todayKudosAwardCount'] = todayKudosAwardCount;
    data['yesterdayKudosAwardCount'] = yesterdayKudosAwardCount;
    data['thisWeekKudosAwardCount'] = thisWeekKudosAwardCount;
    data['lastWeekKudosAwardCount'] = lastWeekKudosAwardCount;
    data['thisMonthKudosAwardCount'] = thisMonthKudosAwardCount;
    data['lastMonthKudosAwardCount'] = lastMonthKudosAwardCount;
    data['totalKudosAwardCount'] = totalKudosAwardCount;
    return data;
  }
}

class ViewHomeKudosCountBelief {
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


  ViewHomeKudosCountBelief(
      {this.id,
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
        this.totalDotValueKudoAwardCount});

  ViewHomeKudosCountBelief.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    valueUrl = json['valueUrl'];
    valueDesc = json['valueDesc'];
    valueId = json['valueId'];
    beliefId = json['beliefId'];
    dotId = json['dotId'];
    todayKudosCount = json['todayKudosCount'];
    yesterdayKudosCount = json['yesterdayKudosCount'];
    thisWeekKudosCount = json['thisWeekKudosCount'];
    lastWeekKudosCount = json['lastWeekKudosCount'];
    thisMonthKudosCount = json['thisMonthKudosCount'];
    lastMonthKudosCount = json['lastMonthKudosCount'];
    totalKudosCount = json['totalKudosCount'];
    todayDotValueKudoAwardCount = json['todayDotValueKudoAwardCount'];
    yesterdayDotValueKudoAwardCount = json['yesterdayDotValueKudoAwardCount'];
    thisWeekDotValueKudoAwardCount = json['thisWeekDotValueKudoAwardCount'];
    lastWeekDotValueKudoAwardCount = json['lastWeekDotValueKudoAwardCount'];
    thisMonthDotValueKudoAwardCount = json['thisMonthDotValueKudoAwardCount'];
    lastMonthDotValueKudoAwardCount = json['lastMonthDotValueKudoAwardCount'];
    totalDotValueKudoAwardCount = json['totalDotValueKudoAwardCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['valueUrl'] = valueUrl;
    data['valueDesc'] = valueDesc;
    data['valueId'] = valueId;
    data['beliefId'] = beliefId;
    data['dotId'] = dotId;
    data['todayKudosCount'] = todayKudosCount;
    data['yesterdayKudosCount'] = yesterdayKudosCount;
    data['thisWeekKudosCount'] = thisWeekKudosCount;
    data['lastWeekKudosCount'] = lastWeekKudosCount;
    data['thisMonthKudosCount'] = thisMonthKudosCount;
    data['lastMonthKudosCount'] = lastMonthKudosCount;
    data['totalKudosCount'] = totalKudosCount;
    data['todayDotValueKudoAwardCount'] = todayDotValueKudoAwardCount;
    data['yesterdayDotValueKudoAwardCount'] =
        yesterdayDotValueKudoAwardCount;
    data['thisWeekDotValueKudoAwardCount'] =
        thisWeekDotValueKudoAwardCount;
    data['lastWeekDotValueKudoAwardCount'] =
        lastWeekDotValueKudoAwardCount;
    data['thisMonthDotValueKudoAwardCount'] =
        thisMonthDotValueKudoAwardCount;
    data['lastMonthDotValueKudoAwardCount'] =
        lastMonthDotValueKudoAwardCount;
    data['totalDotValueKudoAwardCount'] = totalDotValueKudoAwardCount;
    return data;
  }
}