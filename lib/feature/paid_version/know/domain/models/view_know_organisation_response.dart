class ViewKnowOrganisationResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  ViewKnowOrganisationData? data;

  ViewKnowOrganisationResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ViewKnowOrganisationResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    data = json['data'] != null ? ViewKnowOrganisationData.fromJson(json['data']) : null;
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

class ViewKnowOrganisationData {
  int? appPaymentVersion;
  String? todayHIPercent;
  String? todayDay;
  String? yesterdayHIPercent;
  String? yesterdayDay;
  String? dayBeforeYesterdayHIPercent;
  String? dayBeforeYesterdayDay;
  String? dayBeforeYesterdayDate;
  String? thisWeekHIPercent;
  String? lastWeekHIPercent;
  String? lastToLastWeekHIPercent;
  String? thisMonthHIPercent;
  String? thisMonthName;
  String? lastMonthHIPercent;
  String? lastMonthName;
  String? lastToLastMonthHIPercent;
  String? lastToLastMonthName;
  String? cultureIndex;
  String? engagementIndex;
  int? cultureIndexRank;
  int? engagementIndexRank;
  List<LastMonthKudosChamp>? lastMonthKudosChamp;
  List<LatestKudosAward>? latestKudosAward;

  ViewKnowOrganisationData(
      {this.appPaymentVersion,
        this.todayHIPercent,
        this.todayDay,
        this.yesterdayHIPercent,
        this.yesterdayDay,
        this.dayBeforeYesterdayHIPercent,
        this.dayBeforeYesterdayDay,
        this.dayBeforeYesterdayDate,
        this.thisWeekHIPercent,
        this.lastWeekHIPercent,
        this.lastToLastWeekHIPercent,
        this.thisMonthHIPercent,
        this.thisMonthName,
        this.lastMonthHIPercent,
        this.lastMonthName,
        this.lastToLastMonthHIPercent,
        this.lastToLastMonthName,
        this.cultureIndex,
        this.engagementIndex,
        this.cultureIndexRank,
        this.engagementIndexRank,
        this.lastMonthKudosChamp,
        this.latestKudosAward});

  ViewKnowOrganisationData.fromJson(Map<String, dynamic> json) {
    appPaymentVersion = json['appPaymentVersion'];
    todayHIPercent = json['todayHIPercent'];
    todayDay = json['todayDay'];
    yesterdayHIPercent = json['yesterdayHIPercent'];
    yesterdayDay = json['yesterdayDay'];
    dayBeforeYesterdayHIPercent = json['dayBeforeYesterdayHIPercent'];
    dayBeforeYesterdayDay = json['dayBeforeYesterdayDay'];
    dayBeforeYesterdayDate = json['dayBeforeYesterdayDate'];
    thisWeekHIPercent = json['thisWeekHIPercent'];
    lastWeekHIPercent = json['lastWeekHIPercent'];
    lastToLastWeekHIPercent = json['lastToLastWeekHIPercent'];
    thisMonthHIPercent = json['thisMonthHIPercent'];
    thisMonthName = json['thisMonthName'];
    lastMonthHIPercent = json['lastMonthHIPercent'];
    lastMonthName = json['lastMonthName'];
    lastToLastMonthHIPercent = json['lastToLastMonthHIPercent'];
    lastToLastMonthName = json['lastToLastMonthName'];
    cultureIndex = json['cultureIndex'];
    engagementIndex = json['engagementIndex'];
    cultureIndexRank = json['cultureIndexRank'];
    engagementIndexRank = json['engagementIndexRank'];
    if (json['lastMonthKudosChamp'] != null) {
      lastMonthKudosChamp = <LastMonthKudosChamp>[];
      json['lastMonthKudosChamp'].forEach((v) {
        lastMonthKudosChamp!.add(LastMonthKudosChamp.fromJson(v));
      });
    }
    if (json['latestKudosAward'] != null) {
      latestKudosAward = <LatestKudosAward>[];
      json['latestKudosAward'].forEach((v) {
        latestKudosAward!.add(LatestKudosAward.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appPaymentVersion'] = appPaymentVersion;
    data['todayHIPercent'] = todayHIPercent;
    data['todayDay'] = todayDay;
    data['yesterdayHIPercent'] = yesterdayHIPercent;
    data['yesterdayDay'] = yesterdayDay;
    data['dayBeforeYesterdayHIPercent'] = dayBeforeYesterdayHIPercent;
    data['dayBeforeYesterdayDay'] = dayBeforeYesterdayDay;
    data['dayBeforeYesterdayDate'] = dayBeforeYesterdayDate;
    data['thisWeekHIPercent'] = thisWeekHIPercent;
    data['lastWeekHIPercent'] = lastWeekHIPercent;
    data['lastToLastWeekHIPercent'] = lastToLastWeekHIPercent;
    data['thisMonthHIPercent'] = thisMonthHIPercent;
    data['thisMonthName'] = thisMonthName;
    data['lastMonthHIPercent'] = lastMonthHIPercent;
    data['lastMonthName'] = lastMonthName;
    data['lastToLastMonthHIPercent'] = lastToLastMonthHIPercent;
    data['lastToLastMonthName'] = lastToLastMonthName;
    data['cultureIndex'] = cultureIndex;
    data['engagementIndex'] = engagementIndex;
    data['cultureIndexRank'] = cultureIndexRank;
    data['engagementIndexRank'] = engagementIndexRank;
    if (lastMonthKudosChamp != null) {
      data['lastMonthKudosChamp'] =
          lastMonthKudosChamp!.map((v) => v.toJson()).toList();
    }
    if (latestKudosAward != null) {
      data['latestKudosAward'] =
          latestKudosAward!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LastMonthKudosChamp {
  String? userName;
  String? userImage;
  String? count;

  LastMonthKudosChamp({this.userName, this.userImage, this.count});

  LastMonthKudosChamp.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    userImage = json['userImage'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['userImage'] = userImage;
    data['count'] = count;
    return data;
  }
}

class LatestKudosAward {
  String? userName;
  String? userImage;
  String? awardDescription;
  String? awardDate;
  String? awardValue;
  int? kudoAwardCount;
  List<ViewMoreUsers>? viewMoreUsers;

  LatestKudosAward(
      {this.userName,
        this.userImage,
        this.awardDescription,
        this.awardDate,
        this.awardValue,
        this.kudoAwardCount,
        this.viewMoreUsers});

  LatestKudosAward.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    userImage = json['userImage'];
    awardDescription = json['awardDescription'];
    awardDate = json['awardDate'];
    awardValue = json['awardValue'];
    kudoAwardCount = json['kudoAwardCount'];
    if (json['viewMoreUsers'] != null) {
      viewMoreUsers = <ViewMoreUsers>[];
      json['viewMoreUsers'].forEach((v) {
        viewMoreUsers!.add(ViewMoreUsers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['userImage'] = userImage;
    data['awardDescription'] = awardDescription;
    data['awardDate'] = awardDate;
    data['awardValue'] = awardValue;
    data['kudoAwardCount'] = kudoAwardCount;
    if (viewMoreUsers != null) {
      data['viewMoreUsers'] =
          viewMoreUsers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ViewMoreUsers {
  String? userName;
  String? userImage;

  ViewMoreUsers({this.userName, this.userImage});

  ViewMoreUsers.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    userImage = json['userImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['userImage'] = userImage;
    return data;
  }
}