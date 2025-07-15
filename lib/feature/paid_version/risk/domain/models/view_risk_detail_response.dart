class ViewRiskDetailResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  ViewRiskDetailData? data;

  ViewRiskDetailResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ViewRiskDetailResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    data = json['data'] != null ? ViewRiskDetailData.fromJson(json['data']) : null;
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


// risk_detail.dart

class ViewRiskDetailData {
  final String? title;
  final String? description;
  final String? priority;
  final String? date;
  final List<ActionList>? actions;
  final int? offloads;

  ViewRiskDetailData({
    this.title,
    this.description,
    this.priority,
    this.date,
    this.actions,
    this.offloads,
  });

  factory ViewRiskDetailData.fromJson(Map<String, dynamic> json) => ViewRiskDetailData(
    title: json['title'],
    description: json['description'],
    priority: json['priority'],
    date: json['date'],
    actions: (json['actions'] as List<dynamic>?)
        ?.map((e) => ActionList.fromJson(e))
        .toList(),
    offloads: json['linkedOffloads'],
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'priority': priority,
    'date': date,
    'actions': actions?.map((e) => e.toJson()).toList(),
    'linkedOffloads': offloads,
  };
}

// action_list.dart

class ActionList {
  final int? id;
  final String? userId;
  final String? tier;
  final int? tierId;
  final String? responsibleName;
  final int? responsibleUserId;
  final String? description;
  final String? startedDate;
  final String? dueDate;
  final String? orgStatus;
  final int? orgId;
  final String? offDeptName;
  final String? offDeptId;
  final String? name;
  final List<RiskTheme>? themes;
  final int? linkedActionOffloads;

  ActionList({
    this.id,
    this.userId,
    this.tier,
    this.tierId,
    this.responsibleName,
    this.responsibleUserId,
    this.description,
    this.startedDate,
    this.dueDate,
    this.orgStatus,
    this.orgId,
    this.offDeptName,
    this.offDeptId,
    this.name,
    this.themes,
    this.linkedActionOffloads,
  });

  factory ActionList.fromJson(Map<String, dynamic> json) => ActionList(
    id: json['id'],
    userId: json['userId'],
    tier: json['tier'],
    tierId: json['tierId'],
    responsibleName: json['responsibleName'],
    responsibleUserId: json['responsibleUserId'],
    description: json['description'],
    startedDate: json['startedDate'],
    dueDate: json['dueDate'],
    orgStatus: json['orgStatus'],
    orgId: json['orgId'],
    offDeptName: json['offDeptName'],
    offDeptId: json['offDeptId'],
    name: json['name'],
    themes: (json['themes'] as List<dynamic>?)
        ?.map((e) => RiskTheme.fromJson(e))
        .toList(),
    linkedActionOffloads: json['linkedActionOffloads'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'tier': tier,
    'tierId': tierId,
    'responsibleName': responsibleName,
    'responsibleUserId': responsibleUserId,
    'description': description,
    'startedDate': startedDate,
    'dueDate': dueDate,
    'orgStatus': orgStatus,
    'orgId': orgId,
    'offDeptName': offDeptName,
    'offDeptId': offDeptId,
    'name': name,
    'themes': themes?.map((e) => e.toJson()).toList(),
    'linkedActionOffloads': linkedActionOffloads,
  };
}

// risk_theme.dart

class RiskTheme {
  final int? id;
  final String? title;

  RiskTheme({
    this.id,
    this.title,
  });

  factory RiskTheme.fromJson(Map<String, dynamic> json) => RiskTheme(
    id: json['id'],
    title: json['title'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
  };
}

