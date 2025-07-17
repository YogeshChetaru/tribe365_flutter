class ViewTeamFeedbackUserAnswerStatusResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  ViewTeamFeedbackUserAnswerStatusData? data;

  ViewTeamFeedbackUserAnswerStatusResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ViewTeamFeedbackUserAnswerStatusResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    data = json['data'] != null ? ViewTeamFeedbackUserAnswerStatusData.fromJson(json['data']) : null;
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

class ViewTeamFeedbackUserAnswerStatusData {
  bool? status;

  ViewTeamFeedbackUserAnswerStatusData({this.status});

  ViewTeamFeedbackUserAnswerStatusData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    return data;
  }
}