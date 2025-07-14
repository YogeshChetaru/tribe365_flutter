class ViewRiskRegisterListResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  ViewRiskRegisterListData? data;

  ViewRiskRegisterListResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ViewRiskRegisterListResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    data = json['data'] != null ? ViewRiskRegisterListData.fromJson(json['data']) : null;
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

class ViewRiskRegisterListData {
  List<RiskCount>? riskCount;
  List<RiskArr>? riskArr;
  List<SwotList>? swotList;

  ViewRiskRegisterListData({this.riskCount, this.riskArr, this.swotList});

  ViewRiskRegisterListData.fromJson(Map<String, dynamic> json) {
    if (json['riskCount'] != null) {
      riskCount = <RiskCount>[];
      json['riskCount'].forEach((v) {
        riskCount!.add(RiskCount.fromJson(v));
      });
    }
    if (json['riskArr'] != null) {
      riskArr = <RiskArr>[];
      json['riskArr'].forEach((v) {
        riskArr!.add(RiskArr.fromJson(v));
      });
    }
    if (json['swotList'] != null) {
      swotList = <SwotList>[];
      json['swotList'].forEach((v) {
        swotList!.add(SwotList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (riskCount != null) {
      data['riskCount'] = riskCount!.map((v) => v.toJson()).toList();
    }
    if (riskArr != null) {
      data['riskArr'] = riskArr!.map((v) => v.toJson()).toList();
    }
    if (swotList != null) {
      data['swotList'] = swotList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RiskCount {
  String? statusTitle;
  int? status;
  int? count;

  RiskCount({this.statusTitle, this.status, this.count});

  RiskCount.fromJson(Map<String, dynamic> json) {
    statusTitle = json['statusTitle'];
    status = json['status'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusTitle'] = statusTitle;
    data['status'] = status;
    data['count'] = count;
    return data;
  }
}

class SwotList {
  int? id;
  String? title;

  SwotList({this.id, this.title});

  SwotList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}

class RiskArr {
  final int? id;
  final String? title;
  final String? priority;

  RiskArr({
    this.id,
    this.title,
    this.priority,
  });

  // Factory constructor to parse from JSON
  factory RiskArr.fromJson(Map<String, dynamic> json) {
    return RiskArr(
      id: json['id'] as int?,
      title: json['title'] as String?,
      priority: json['priority'] as String?,
    );
  }

  // Convert to JSON (if you need to send back)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'priority': priority,
    };
  }
}
