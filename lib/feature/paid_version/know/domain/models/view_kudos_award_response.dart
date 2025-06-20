class ViewKudosAwardResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  List<ViewKudosAwardData>? data;

  ViewKudosAwardResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ViewKudosAwardResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ViewKudosAwardData>[];
      json['data'].forEach((v) {
        data!.add(ViewKudosAwardData.fromJson(v));
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

class ViewKudosAwardData {
  String? userName;
  String? userImage;
  String? awardDescription;
  String? awardDate;
  String? awardValue;

  ViewKudosAwardData(
      {this.userName,
        this.userImage,
        this.awardDescription,
        this.awardDate,
        this.awardValue});

  ViewKudosAwardData.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    userImage = json['userImage'];
    awardDescription = json['awardDescription'];
    awardDate = json['awardDate'];
    awardValue = json['awardValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['userImage'] = userImage;
    data['awardDescription'] = awardDescription;
    data['awardDate'] = awardDate;
    data['awardValue'] = awardValue;
    return data;
  }
}
class GroupKudosList {
  final String keyDescription;
  final List<ViewKudosAwardData> kudosAwardLists;

  GroupKudosList({
    required this.keyDescription,
    required this.kudosAwardLists,
  });
}