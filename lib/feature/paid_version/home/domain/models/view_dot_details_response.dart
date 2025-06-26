class ViewDotDetailsResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  ViewDotDetailsData? data;

  ViewDotDetailsResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ViewDotDetailsResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    data = json['data'] != null ? ViewDotDetailsData.fromJson(json['data']) : null;
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

class ViewDotDetailsData {
  int? id;
  String? vision;
  String? visionUrl;
  String? visionDesc;
  String? mission;
  String? missionUrl;
  String? missionDesc;
  String? focus;
  String? focusUrl;
  String? focusDesc;
  int? orgId;
  List<Belief>? belief;

  ViewDotDetailsData(
      {this.id,
        this.vision,
        this.visionUrl,
        this.visionDesc,
        this.mission,
        this.missionUrl,
        this.missionDesc,
        this.focus,
        this.focusUrl,
        this.focusDesc,
        this.orgId,
        this.belief});

  ViewDotDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vision = json['vision'];
    visionUrl = json['visionUrl'];
    visionDesc = json['visionDesc'];
    mission = json['mission'];
    missionUrl = json['missionUrl'];
    missionDesc = json['missionDesc'];
    focus = json['focus'];
    focusUrl = json['focusUrl'];
    focusDesc = json['focusDesc'];
    orgId = json['orgId'];
    if (json['belief'] != null) {
      belief = <Belief>[];
      json['belief'].forEach((v) {
        belief!.add(Belief.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vision'] = vision;
    data['visionUrl'] = visionUrl;
    data['visionDesc'] = visionDesc;
    data['mission'] = mission;
    data['missionUrl'] = missionUrl;
    data['missionDesc'] = missionDesc;
    data['focus'] = focus;
    data['focusUrl'] = focusUrl;
    data['focusDesc'] = focusDesc;
    data['orgId'] = orgId;
    if (belief != null) {
      data['belief'] = belief!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Belief {
  int? id;
  String? name;
  String? beliefUrl;
  String? beliefDesc;
  int? dotId;
  List<BeliefValue>? beliefValue;

  Belief(
      {this.id,
        this.name,
        this.beliefUrl,
        this.beliefDesc,
        this.dotId,
        this.beliefValue});

  Belief.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    beliefUrl = json['beliefUrl'];
    beliefDesc = json['beliefDesc'];
    dotId = json['dotId'];
    if (json['belief_value'] != null) {
      beliefValue = <BeliefValue>[];
      json['belief_value'].forEach((v) {
        beliefValue!.add(BeliefValue.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['beliefUrl'] = beliefUrl;
    data['beliefDesc'] = beliefDesc;
    data['dotId'] = dotId;
    if (beliefValue != null) {
      data['belief_value'] = beliefValue!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BeliefValue {
  int? id;
  String? name;
  String? valueId;
  String? valueUrl;
  String? valueDesc;
  int? beliefId;
  int? dotId;
  String? ratings;
  String isSelected = "";

  BeliefValue(
      {this.id,
        this.name,
        this.valueId,
        this.valueUrl,
        this.valueDesc,
        this.beliefId,
        this.dotId,
        this.ratings});

  BeliefValue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    valueId = json['valueId'];
    valueUrl = json['valueUrl'];
    valueDesc = json['valueDesc'];
    beliefId = json['beliefId'];
    dotId = json['dotId'];
    ratings = json['ratings'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['valueId'] = valueId;
    data['valueUrl'] = valueUrl;
    data['valueDesc'] = valueDesc;
    data['beliefId'] = beliefId;
    data['dotId'] = dotId;
    data['ratings'] = ratings;
    data['isSelected'] = isSelected;
    return data;
  }
}