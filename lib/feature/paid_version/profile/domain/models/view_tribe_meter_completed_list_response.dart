class ViewTribeMeterCompletedListResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  List<ViewTribeMeterCompletedListData>? data;

  ViewTribeMeterCompletedListResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ViewTribeMeterCompletedListResponse.fromJson(
      Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ViewTribeMeterCompletedListData>[];
      json['data'].forEach((v) {
        data!.add(ViewTribeMeterCompletedListData.fromJson(v));
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

class ViewTribeMeterCompletedListData {
  int? questionId;
  String? question;
  List<ViewTribeMeterCompletedListOptions>? options;
  int? answerId;

  ViewTribeMeterCompletedListData({this.questionId, this.question, this.options, this.answerId});

  ViewTribeMeterCompletedListData.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    question = json['question'];
    if (json['options'] != null) {
      options = <ViewTribeMeterCompletedListOptions>[];
      json['options'].forEach((v) {
        options!.add(ViewTribeMeterCompletedListOptions.fromJson(v));
      });
    }
    answerId = json['answerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['questionId'] = questionId;
    data['question'] = question;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    data['answerId'] = answerId;
    return data;
  }
}

class ViewTribeMeterCompletedListOptions {
  int? optionId;
  String? optionName;
  bool? isChecked;
  int? answerId;

  ViewTribeMeterCompletedListOptions({this.optionId, this.optionName, this.isChecked, this.answerId});

  ViewTribeMeterCompletedListOptions.fromJson(Map<String, dynamic> json) {
    optionId = json['optionId'];
    optionName = json['optionName'];
    isChecked = json['isChecked'];
    answerId = json['answerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['optionId'] = optionId;
    data['optionName'] = optionName;
    data['isChecked'] = isChecked;
    data['answerId'] = answerId;
    return data;
  }
}