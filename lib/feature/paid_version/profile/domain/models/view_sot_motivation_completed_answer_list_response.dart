class ViewSotMotivationCompletedAnswerListResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  List<ViewSotMotivationCompletedAnswerListData>? data;

  ViewSotMotivationCompletedAnswerListResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ViewSotMotivationCompletedAnswerListResponse.fromJson(
      Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ViewSotMotivationCompletedAnswerListData>[];
      json['data'].forEach((v) {
        data!.add(ViewSotMotivationCompletedAnswerListData.fromJson(v));
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

class ViewSotMotivationCompletedAnswerListData {
  int? questionId;
  String? questionName;
  List<ViewSotMotivationCompletedAnswerOption>? option;
  bool? flag;

  ViewSotMotivationCompletedAnswerListData({this.flag = false,this.questionId, this.questionName, this.option});

  ViewSotMotivationCompletedAnswerListData.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    questionName = json['questionName'];
    if (json['option'] != null) {
      option = <ViewSotMotivationCompletedAnswerOption>[];
      json['option'].forEach((v) {
        option!.add(ViewSotMotivationCompletedAnswerOption.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['questionId'] = questionId;
    data['questionName'] = questionName;
    if (option != null) {
      data['option'] = option!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ViewSotMotivationCompletedAnswerOption {
  int? optionId;
  String? option;
  int? points;
  int? answerId;
  String? rating; // nullable

  ViewSotMotivationCompletedAnswerOption({this.optionId, this.option, this.points, this.answerId,
  this.rating,});

  ViewSotMotivationCompletedAnswerOption.fromJson(Map<String, dynamic> json) {
    optionId = json['optionId'];
    option = json['option'];
    points = json['points'];
    answerId = json['answerId'];
    rating= json['rating']?.toString(); // no ?? "0"
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['optionId'] = optionId;
    data['option'] = option;
    data['points'] = points;
    data['answerId'] = answerId;
    data['rating'] = rating;
    return data;
  }
}