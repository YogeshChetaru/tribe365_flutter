class ViewDiagnosticCompletedQuestionListResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  List<ViewDiagnosticCompletedQuestionListData>? data;

  ViewDiagnosticCompletedQuestionListResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ViewDiagnosticCompletedQuestionListResponse.fromJson(
      Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ViewDiagnosticCompletedQuestionListData>[];
      json['data'].forEach((v) {
        data!.add(new ViewDiagnosticCompletedQuestionListData.fromJson(v));
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

class ViewDiagnosticCompletedQuestionListData {
  int? questionId;
  String? question;
  List<ViewDiagnosticCompletedQuestionListOptions>? options;
  int? answerId;

  ViewDiagnosticCompletedQuestionListData({this.questionId, this.question, this.options, this.answerId});

  ViewDiagnosticCompletedQuestionListData.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    question = json['question'];
    if (json['options'] != null) {
      options = <ViewDiagnosticCompletedQuestionListOptions>[];
      json['options'].forEach((v) {
        options!.add(new ViewDiagnosticCompletedQuestionListOptions.fromJson(v));
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

class ViewDiagnosticCompletedQuestionListOptions {
  int? optionId;
  String? optionName;
  bool? isChecked;
  int? answerId;

  ViewDiagnosticCompletedQuestionListOptions({this.optionId, this.optionName, this.isChecked, this.answerId});

  ViewDiagnosticCompletedQuestionListOptions.fromJson(Map<String, dynamic> json) {
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