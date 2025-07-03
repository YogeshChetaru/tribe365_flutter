class ViewActionListResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  List<ViewActionListData>? data;

  ViewActionListResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ViewActionListResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ViewActionListData>[];
      json['data'].forEach((v) {
        data!.add(ViewActionListData.fromJson(v));
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

class ViewActionListData {
  String? id;
  String? userId;
  String? tier;
  String? tierId;
  String? responsibleName;
  String? responsibleUserId;
  String? description;
  String? startedDate;
  String? dueDate;
  String? orgStatus;
  String? orgId;
  String? offDeptName;
  String? offDeptId;
  String? name;
  List<ModelTheme>? themes;
  int? linkedActionOffloads;

  ViewActionListData(
      {this.id,
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
        this.linkedActionOffloads});

  ViewActionListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    tier = json['tier'];
    tierId = json['tierId'];
    responsibleName = json['responsibleName'];
    responsibleUserId = json['responsibleUserId'];
    description = json['description'];
    startedDate = json['startedDate'];
    dueDate = json['dueDate'];
    orgStatus = json['orgStatus'];
    orgId = json['orgId'];
    offDeptName = json['offDeptName'];
    offDeptId = json['offDeptId'];
    name = json['name'];
    if (json['themes'] != null) {
      themes = <ModelTheme>[];
      json['themes'].forEach((v) {
        themes!.add(ModelTheme.fromJson(v));
      });
    }
    linkedActionOffloads = json['linkedActionOffloads'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['tier'] = tier;
    data['tierId'] = tierId;
    data['responsibleName'] = responsibleName;
    data['responsibleUserId'] = responsibleUserId;
    data['description'] = description;
    data['startedDate'] = startedDate;
    data['dueDate'] = dueDate;
    data['orgStatus'] = orgStatus;
    data['orgId'] = orgId;
    data['offDeptName'] = offDeptName;
    data['offDeptId'] = offDeptId;
    data['name'] = name;
    if (themes != null) {
      data['themes'] = themes!.map((v) => v.toJson()).toList();
    }
    data['linkedActionOffloads'] = linkedActionOffloads;
    return data;
  }
}

class ModelTheme {
  bool isSelected;
  int? id;
  String? title;

  ModelTheme({
    this.isSelected = false,
    this.id,
    this.title,
  });

  // From JSON factory
  factory ModelTheme.fromJson(Map<String, dynamic> json) {
    return ModelTheme(
      id: json['id'] as int?,
      title: json['title'] as String?,
      isSelected: json['isSelected'] ?? false,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isSelected': isSelected,
    };
  }
}
