class ViewCotIndividualSummaryResponse {
  int? code;
  bool? status;
  bool? cotAnswered;
  String? serviceName;
  String? message;
  ViewCotIndividualSummaryData? data;

  ViewCotIndividualSummaryResponse(
      {this.code,
        this.status,
        this.cotAnswered,
        this.serviceName,
        this.message,
        this.data});

  ViewCotIndividualSummaryResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    cotAnswered = json['cotAnswered'];
    serviceName = json['service_name'];
    message = json['message'];
    data = json['data'] != null ? ViewCotIndividualSummaryData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    data['cotAnswered'] = cotAnswered;
    data['service_name'] = serviceName;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ViewCotIndividualSummaryData {
  int? userId;
  String? userName;
  int? resourceInvestigator;
  int? implementer;
  int? monitorEvaluator;
  int? plant;
  int? coordinator;
  int? completerFinisher;
  int? teamworker;
  int? shaper;
  TotalKeyCount? totalKeyCount;
  MapersArray? mapersArray;

  ViewCotIndividualSummaryData(
      {this.userId,
        this.userName,
        this.resourceInvestigator,
        this.implementer,
        this.monitorEvaluator,
        this.plant,
        this.coordinator,
        this.completerFinisher,
        this.teamworker,
        this.shaper,
        this.totalKeyCount,
        this.mapersArray});

  ViewCotIndividualSummaryData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    resourceInvestigator = json['resourceInvestigator'];
    implementer = json['implementer'];
    monitorEvaluator = json['monitorEvaluator'];
    plant = json['plant'];
    coordinator = json['coordinator'];
    completerFinisher = json['completerFinisher'];
    teamworker = json['teamworker'];
    shaper = json['shaper'];
    totalKeyCount = json['totalKeyCount'] != null
        ? TotalKeyCount.fromJson(json['totalKeyCount'])
        : null;
    mapersArray = json['mapersArray'] != null
        ? MapersArray.fromJson(json['mapersArray'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['userName'] = userName;
    data['resourceInvestigator'] = resourceInvestigator;
    data['implementer'] = implementer;
    data['monitorEvaluator'] = monitorEvaluator;
    data['plant'] = plant;
    data['coordinator'] = coordinator;
    data['completerFinisher'] = completerFinisher;
    data['teamworker'] = teamworker;
    data['shaper'] = shaper;
    if (totalKeyCount != null) {
      data['totalKeyCount'] = totalKeyCount!.toJson();
    }
    if (mapersArray != null) {
      data['mapersArray'] = mapersArray!.toJson();
    }
    return data;
  }
}

class TotalKeyCount {
  int? resourceInvestigator;
  int? implementer;
  int? monitorEvaluator;
  int? plant;
  int? coordinator;
  int? completerFinisher;
  int? teamworker;
  int? shaper;

  TotalKeyCount(
      {this.resourceInvestigator,
        this.implementer,
        this.monitorEvaluator,
        this.plant,
        this.coordinator,
        this.completerFinisher,
        this.teamworker,
        this.shaper});

  TotalKeyCount.fromJson(Map<String, dynamic> json) {
    resourceInvestigator = json['resourceInvestigator'];
    implementer = json['implementer'];
    monitorEvaluator = json['monitorEvaluator'];
    plant = json['plant'];
    coordinator = json['coordinator'];
    completerFinisher = json['completerFinisher'];
    teamworker = json['teamworker'];
    shaper = json['shaper'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['resourceInvestigator'] = resourceInvestigator;
    data['implementer'] = implementer;
    data['monitorEvaluator'] = monitorEvaluator;
    data['plant'] = plant;
    data['coordinator'] = coordinator;
    data['completerFinisher'] = completerFinisher;
    data['teamworker'] = teamworker;
    data['shaper'] = shaper;
    return data;
  }
}

class MapersArray {
  String? shaper;
  String? coordinator;
  String? implementer;
  String? completerFinisher;
  String? monitorEvaluator;
  String? teamworker;
  String? plant;
  String? resourceInvestigator;

  MapersArray(
      {this.shaper,
        this.coordinator,
        this.implementer,
        this.completerFinisher,
        this.monitorEvaluator,
        this.teamworker,
        this.plant,
        this.resourceInvestigator});

  MapersArray.fromJson(Map<String, dynamic> json) {
    shaper = json['shaper'];
    coordinator = json['coordinator'];
    implementer = json['implementer'];
    completerFinisher = json['completerFinisher'];
    monitorEvaluator = json['monitorEvaluator'];
    teamworker = json['teamworker'];
    plant = json['plant'];
    resourceInvestigator = json['resourceInvestigator'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shaper'] = shaper;
    data['coordinator'] = coordinator;
    data['implementer'] = implementer;
    data['completerFinisher'] = completerFinisher;
    data['monitorEvaluator'] = monitorEvaluator;
    data['teamworker'] = teamworker;
    data['plant'] = plant;
    data['resourceInvestigator'] = resourceInvestigator;
    return data;
  }
}
class getcotindividualsummaryresponse {
  int? code;
  bool? status;
  bool? cotAnswered;
  String? serviceName;
  String? message;
  Data? data;

  getcotindividualsummaryresponse(
      {this.code,
        this.status,
        this.cotAnswered,
        this.serviceName,
        this.message,
        this.data});

  getcotindividualsummaryresponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    cotAnswered = json['cotAnswered'];
    serviceName = json['service_name'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    data['cotAnswered'] = cotAnswered;
    data['service_name'] = serviceName;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? userId;
  String? userName;
  int? resourceInvestigator;
  int? implementer;
  int? monitorEvaluator;
  int? plant;
  int? coordinator;
  int? completerFinisher;
  int? teamworker;
  int? shaper;
  TotalKeyCount? totalKeyCount;
  MapersArray? mapersArray;

  Data(
      {this.userId,
        this.userName,
        this.resourceInvestigator,
        this.implementer,
        this.monitorEvaluator,
        this.plant,
        this.coordinator,
        this.completerFinisher,
        this.teamworker,
        this.shaper,
        this.totalKeyCount,
        this.mapersArray});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    resourceInvestigator = json['resourceInvestigator'];
    implementer = json['implementer'];
    monitorEvaluator = json['monitorEvaluator'];
    plant = json['plant'];
    coordinator = json['coordinator'];
    completerFinisher = json['completerFinisher'];
    teamworker = json['teamworker'];
    shaper = json['shaper'];
    totalKeyCount = json['totalKeyCount'] != null
        ? TotalKeyCount.fromJson(json['totalKeyCount'])
        : null;
    mapersArray = json['mapersArray'] != null
        ? MapersArray.fromJson(json['mapersArray'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['userName'] = userName;
    data['resourceInvestigator'] = resourceInvestigator;
    data['implementer'] = implementer;
    data['monitorEvaluator'] = monitorEvaluator;
    data['plant'] = plant;
    data['coordinator'] = coordinator;
    data['completerFinisher'] = completerFinisher;
    data['teamworker'] = teamworker;
    data['shaper'] = shaper;
    if (totalKeyCount != null) {
      data['totalKeyCount'] = totalKeyCount!.toJson();
    }
    if (mapersArray != null) {
      data['mapersArray'] = mapersArray!.toJson();
    }
    return data;
  }
}

