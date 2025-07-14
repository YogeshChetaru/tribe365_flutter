import '../../../home/domain/models/view_dot_details_response.dart';

class ViewStudiesListResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  ViewStudiesListData? data;

  ViewStudiesListResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ViewStudiesListResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    data = json['data'] != null ? ViewStudiesListData.fromJson(json['data']) : null;
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

class ViewStudiesListData {
  int? appPaymentVersion;
  List<ModelAdminReportDOT>? getDOTreportGraph;
  GetCOTteamRoleMapReport? getCOTteamRoleMapReport;
  GetCOTpersonalityTypeOld? getCOTpersonalityTypeOld;
  List<GetCOTpersonalityType>? getCOTpersonalityType;
  GetSOTcultureStructureReport? getSOTcultureStructureReport;
  List<ModelMotivationGraph>? getSOTmotivationReport;
  List<GetDiagnosticReportForGraph>? getDiagnosticReportForGraph;
  List<GetCOTpersonalityType>? getTribeometerReportForGraph;
  OrgStatus? orgStatus;
  List<GetHappyIndexMonthGraphCount>? getHappyIndexMonthGraphCount;
  String? happyMaxCount;
  String? avgMaxCount;
  String? sadMaxCount;
  List<CultureIndex>? cultureIndex;
  List<CultureIndex>? engagementIndex;

  ViewStudiesListData(
      {this.appPaymentVersion,
        this.getDOTreportGraph,
        this.getCOTteamRoleMapReport,
        this.getCOTpersonalityTypeOld,
        this.getCOTpersonalityType,
        this.getSOTcultureStructureReport,
        this.getSOTmotivationReport,
        this.getDiagnosticReportForGraph,
        this.getTribeometerReportForGraph,
        this.orgStatus,
        this.getHappyIndexMonthGraphCount,
        this.happyMaxCount,
        this.avgMaxCount,
        this.sadMaxCount,
        this.cultureIndex,
        this.engagementIndex});

  ViewStudiesListData.fromJson(Map<String, dynamic> json) {
    appPaymentVersion = json['appPaymentVersion'];
    if (json['getDOTreportGraph'] != null) {
      getDOTreportGraph = <ModelAdminReportDOT>[];
      json['getDOTreportGraph'].forEach((v) {
        getDOTreportGraph!.add(ModelAdminReportDOT.fromJson(v));
      });
    }
    getCOTteamRoleMapReport = json['getCOTteamRoleMapReport'] != null
        ? GetCOTteamRoleMapReport.fromJson(json['getCOTteamRoleMapReport'])
        : null;
    getCOTpersonalityTypeOld = json['getCOTpersonalityType_old'] != null
        ? GetCOTpersonalityTypeOld.fromJson(
        json['getCOTpersonalityType_old'])
        : null;
    if (json['getCOTpersonalityType'] != null) {
      getCOTpersonalityType = <GetCOTpersonalityType>[];
      json['getCOTpersonalityType'].forEach((v) {
        getCOTpersonalityType!.add(GetCOTpersonalityType.fromJson(v));
      });
    }
    getSOTcultureStructureReport = json['getSOTcultureStructureReport'] != null
        ? GetSOTcultureStructureReport.fromJson(
        json['getSOTcultureStructureReport'])
        : null;
    if (json['getSOTmotivationReport'] != null) {
      getSOTmotivationReport = <ModelMotivationGraph>[];
      json['getSOTmotivationReport'].forEach((v) {
        getSOTmotivationReport!.add(ModelMotivationGraph.fromJson(v));
      });
    }
    if (json['getDiagnosticReportForGraph'] != null) {
      getDiagnosticReportForGraph = <GetDiagnosticReportForGraph>[];
      json['getDiagnosticReportForGraph'].forEach((v) {
        getDiagnosticReportForGraph!
            .add(GetDiagnosticReportForGraph.fromJson(v));
      });
    }
    if (json['getTribeometerReportForGraph'] != null) {
      getTribeometerReportForGraph = <GetCOTpersonalityType>[];
      json['getTribeometerReportForGraph'].forEach((v) {
        getTribeometerReportForGraph!
            .add(GetCOTpersonalityType.fromJson(v));
      });
    }
    orgStatus = json['orgStatus'] != null
        ? OrgStatus.fromJson(json['orgStatus'])
        : null;

    if (json['getHappyIndexMonthGraphCount'] != null) {
      getHappyIndexMonthGraphCount = <GetHappyIndexMonthGraphCount>[];
      json['getHappyIndexMonthGraphCount'].forEach((v) {
        getHappyIndexMonthGraphCount!
            .add(GetHappyIndexMonthGraphCount.fromJson(v));
      });
    }
    happyMaxCount = json['happyMaxCount'].toString();
    avgMaxCount = json['avgMaxCount'].toString();
    sadMaxCount = json['sadMaxCount'].toString();
    if (json['cultureIndex'] != null) {
      cultureIndex = <CultureIndex>[];
      json['cultureIndex'].forEach((v) {
        cultureIndex!.add(CultureIndex.fromJson(v));
      });
    }
    if (json['engagementIndex'] != null) {
      engagementIndex = <CultureIndex>[];
      json['engagementIndex'].forEach((v) {
        engagementIndex!.add(CultureIndex.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appPaymentVersion'] = appPaymentVersion;
    if (getDOTreportGraph != null) {
      data['getDOTreportGraph'] =
          getDOTreportGraph!.map((v) => v.toJson()).toList();
    }
    if (getCOTteamRoleMapReport != null) {
      data['getCOTteamRoleMapReport'] = getCOTteamRoleMapReport!.toJson();
    }
    if (getCOTpersonalityTypeOld != null) {
      data['getCOTpersonalityType_old'] =
          getCOTpersonalityTypeOld!.toJson();
    }
    if (getCOTpersonalityType != null) {
      data['getCOTpersonalityType'] =
          getCOTpersonalityType!.map((v) => v.toJson()).toList();
    }
    if (getSOTcultureStructureReport != null) {
      data['getSOTcultureStructureReport'] =
          getSOTcultureStructureReport!.toJson();
    }
    if (getSOTmotivationReport != null) {
      data['getSOTmotivationReport'] =
          getSOTmotivationReport!.map((v) => v.toJson()).toList();
    }
    if (getDiagnosticReportForGraph != null) {
      data['getDiagnosticReportForGraph'] =
          getDiagnosticReportForGraph!.map((v) => v.toJson()).toList();
    }
    if (getTribeometerReportForGraph != null) {
      data['getTribeometerReportForGraph'] =
          getTribeometerReportForGraph!.map((v) => v.toJson()).toList();
    }
    if (orgStatus != null) {
      data['orgStatus'] = orgStatus!.toJson();
    }

    if (getHappyIndexMonthGraphCount != null) {
      data['getHappyIndexMonthGraphCount'] =
          getHappyIndexMonthGraphCount!.map((v) => v.toJson()).toList();
    }
    data['happyMaxCount'] = happyMaxCount;
    data['avgMaxCount'] = avgMaxCount;
    data['sadMaxCount'] = sadMaxCount;
    if (cultureIndex != null) {
      data['cultureIndex'] = cultureIndex!.map((v) => v.toJson()).toList();
    }
    if (engagementIndex != null) {
      data['engagementIndex'] =
          engagementIndex!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetCOTteamRoleMapReport {
  String? id;
  String? orgId;
  String? name;
  String? shaper;
  String? coordinator;
  String? completerFinisher;
  String? teamworker;
  String? implementer;
  String? monitorEvaluator;
  String? plant;
  String? resourceInvestigator;
  MapersArray? mapersArray;

  GetCOTteamRoleMapReport(
      {this.id,
        this.orgId,
        this.name,
        this.shaper,
        this.coordinator,
        this.completerFinisher,
        this.teamworker,
        this.implementer,
        this.monitorEvaluator,
        this.plant,
        this.resourceInvestigator,
        this.mapersArray});

  GetCOTteamRoleMapReport.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    orgId = json['orgId'].toString();
    name = json['name'];
    shaper = json['shaper'].toString();
    coordinator = json['coordinator'].toString();
    completerFinisher = json['completerFinisher'].toString();
    teamworker = json['teamworker'].toString();
    implementer = json['implementer'].toString();
    monitorEvaluator = json['monitorEvaluator'].toString();
    plant = json['plant'].toString();
    resourceInvestigator = json['resourceInvestigator'].toString();
    mapersArray = json['mapersArray'] != null
        ? MapersArray.fromJson(json['mapersArray'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['orgId'] = orgId;
    data['name'] = name;
    data['shaper'] = shaper;
    data['coordinator'] = coordinator;
    data['completerFinisher'] = completerFinisher;
    data['teamworker'] = teamworker;
    data['implementer'] = implementer;
    data['monitorEvaluator'] = monitorEvaluator;
    data['plant'] = plant;
    data['resourceInvestigator'] = resourceInvestigator;
    if (mapersArray != null) {
      data['mapersArray'] = mapersArray!.toJson();
    }
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

class GetCOTpersonalityTypeOld {
  int? st;
  int? sf;
  int? nf;
  int? nt;
  String? stValue;
  String? sfValue;
  String? nfValue;
  String? ntValue;

  GetCOTpersonalityTypeOld(
      {this.st,
        this.sf,
        this.nf,
        this.nt,
        this.stValue,
        this.sfValue,
        this.nfValue,
        this.ntValue});

  GetCOTpersonalityTypeOld.fromJson(Map<String, dynamic> json) {
    st = json['st'];
    sf = json['sf'];
    nf = json['nf'];
    nt = json['nt'];
    stValue = json['stValue'];
    sfValue = json['sfValue'];
    nfValue = json['nfValue'];
    ntValue = json['ntValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['st'] = st;
    data['sf'] = sf;
    data['nf'] = nf;
    data['nt'] = nt;
    data['stValue'] = stValue;
    data['sfValue'] = sfValue;
    data['nfValue'] = nfValue;
    data['ntValue'] = ntValue;
    return data;
  }
}

class GetCOTpersonalityType {
  String? title;
  int? categoryId;
  String? score;
  double? percentage;

  GetCOTpersonalityType(
      {this.title, this.categoryId, this.score, this.percentage});

  GetCOTpersonalityType.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    categoryId = json['categoryId'];
    score = json['score'].toString();
    percentage = double.parse(json['percentage'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['categoryId'] = categoryId;
    data['score'] = score;
    data['percentage'] = percentage;
    return data;
  }
}

class GetSOTcultureStructureReport {
  bool? isQuestionnaireAnswerFilled;
  bool? isUserFilledAnswer;
  // List<Null>? sotDetailArray;
  List<SotSummary>? sotSummaryDetailArray;

  GetSOTcultureStructureReport(
      {this.isQuestionnaireAnswerFilled,
        this.isUserFilledAnswer,
        // this.sotDetailArray,
        this.sotSummaryDetailArray});

  GetSOTcultureStructureReport.fromJson(Map<String, dynamic> json) {
    isQuestionnaireAnswerFilled = json['IsQuestionnaireAnswerFilled'];
    isUserFilledAnswer = json['IsUserFilledAnswer'];
    /*if (json['sotDetailArray'] != null) {
      sotDetailArray = <Null>[];
      json['sotDetailArray'].forEach((v) {
        sotDetailArray!.add(Null.fromJson(v));
      });
    }*/
    if (json['sotSummaryDetailArray'] != null) {
      sotSummaryDetailArray = <SotSummary>[];
      json['sotSummaryDetailArray'].forEach((v) {
        sotSummaryDetailArray!.add(SotSummary.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['IsQuestionnaireAnswerFilled'] = isQuestionnaireAnswerFilled;
    data['IsUserFilledAnswer'] = isUserFilledAnswer;
    /*if (sotDetailArray != null) {
      data['sotDetailArray'] =
          sotDetailArray!.map((v) => v.toJson()).toList();
    }*/
    if (sotSummaryDetailArray != null) {
      data['sotSummaryDetailArray'] =
          sotSummaryDetailArray!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetDiagnosticReportForGraph {
  int? categoryId;
  String? title;
  String? score;
  String? percentage;

  GetDiagnosticReportForGraph(
      {this.categoryId, this.title, this.score, this.percentage});

  GetDiagnosticReportForGraph.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    title = json['title'];
    score = json['score'].toString();
    percentage = json['percentage'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['title'] = title;
    data['score'] = score;
    data['percentage'] = percentage;
    return data;
  }
}

class OrgStatus {
  bool? motivationStatus;
  bool? diagnosticStatus;
  bool? tribeometerStatus;
  bool? isTribeometerAnsDone;
  bool? isDiagnosticAnsDone;
  bool? personalityTypeStatus;

  OrgStatus(
      {this.motivationStatus,
        this.diagnosticStatus,
        this.tribeometerStatus,
        this.isTribeometerAnsDone,
        this.isDiagnosticAnsDone,
        this.personalityTypeStatus});

  OrgStatus.fromJson(Map<String, dynamic> json) {
    motivationStatus = json['motivationStatus'];
    diagnosticStatus = json['diagnosticStatus'];
    tribeometerStatus = json['tribeometerStatus'];
    isTribeometerAnsDone = json['isTribeometerAnsDone'];
    isDiagnosticAnsDone = json['isDiagnosticAnsDone'];
    personalityTypeStatus = json['personalityTypeStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['motivationStatus'] = motivationStatus;
    data['diagnosticStatus'] = diagnosticStatus;
    data['tribeometerStatus'] = tribeometerStatus;
    data['isTribeometerAnsDone'] = isTribeometerAnsDone;
    data['isDiagnosticAnsDone'] = isDiagnosticAnsDone;
    data['personalityTypeStatus'] = personalityTypeStatus;
    return data;
  }
}

class GetHappyIndexMonthGraphCount {
  String? monthName;
  String? sad;
  String? average;
  String? happy;
  String? year;
  String? month;

  GetHappyIndexMonthGraphCount(
      {this.monthName,
        this.sad,
        this.average,
        this.happy,
        this.year,
        this.month});

  GetHappyIndexMonthGraphCount.fromJson(Map<String, dynamic> json) {
    monthName = json['monthName'];
    sad = json['sad'].toString();
    average = json['average'].toString();
    happy = json['happy'].toString();
    year = json['year'].toString();
    month = json['month'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['monthName'] = monthName;
    data['sad'] = sad;
    data['average'] = average;
    data['happy'] = happy;
    data['year'] = year;
    data['month'] = month;
    return data;
  }
}

class CultureIndex {
  double? data;
  String? monthName;

  CultureIndex({this.data, this.monthName});

  CultureIndex.fromJson(Map<String, dynamic> json) {
    data=double.tryParse(json['data'].toString()) ?? 0;
    monthName = json['monthName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data;
    data['monthName'] = monthName;
    return data;
  }
}

class ModelAdminReportDOT {
  final int? beliefId;
  final String? beliefName;
  final String? beliefRatings;
  final List<BeliefValue>? beliefValues;

  ModelAdminReportDOT({
    this.beliefId,
    this.beliefName,
    this.beliefRatings,
    this.beliefValues,
  });

  factory ModelAdminReportDOT.fromJson(Map<String, dynamic> json) {
    return ModelAdminReportDOT(
      beliefId: json['beliefId'] != null ? int.tryParse(json['beliefId'].toString()) : null,
      beliefName: json['beliefName'] as String?,
      beliefRatings: json['beliefRatings'] as String?,
      beliefValues: json['beliefValues'] != null
          ? (json['beliefValues'] as List)
          .map((e) => BeliefValue.fromJson(e as Map<String, dynamic>))
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'beliefId': beliefId,
      'beliefName': beliefName,
      'beliefRatings': beliefRatings,
      'beliefValues': beliefValues?.map((e) => e.toJson()).toList(),
    };
  }
}

class ModelMotivationGraph {
  final String? score;
  final String? title;

  ModelMotivationGraph({
    this.score,
    this.title,
  });

  factory ModelMotivationGraph.fromJson(Map<String, dynamic> json) {
    return ModelMotivationGraph(
      score: json['score'] as String?,
      title: json['title'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'title': title,
    };
  }
}

class SotSummary {
  final String id;
  final String type;
  final String title;
  final String imgUrl;
  final String sotCount;
  final List<String> summaries;

  SotSummary({
    required this.id,
    required this.type,
    required this.title,
    required this.imgUrl,
    required this.sotCount,
    required this.summaries,
  });

  factory SotSummary.fromJson(Map<String, dynamic> json) {
    final List<String> summariesList = (json['summary'] as List<dynamic>?)
        ?.map((e) => e['summary'].toString())
        .toList() ??
        [];

    return SotSummary(
      id: json['id'].toString(),
      type: json['type'] ?? "",
      title: json['title'] ?? "",
      imgUrl: json['imgUrl'] ?? "",
      sotCount: json['SOTCount'] ?? "",
      summaries: summariesList,
    );
  }

  // ✅ Add this
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "type": type,
      "title": title,
      "imgUrl": imgUrl,
      "SOTCount": sotCount,
      "summary": summaries.map((s) => {"summary": s}).toList(),
    };
  }
}
