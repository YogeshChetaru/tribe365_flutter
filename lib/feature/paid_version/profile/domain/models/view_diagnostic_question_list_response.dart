class ViewDiagnosticQuestionListResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  List<ViewDiagnosticQuestionListData>? data;

  ViewDiagnosticQuestionListResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ViewDiagnosticQuestionListResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ViewDiagnosticQuestionListData>[];
      json['data'].forEach((v) {
        data!.add(ViewDiagnosticQuestionListData.fromJson(v));
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
class ViewDiagnosticQuestionListData {
  int? questionId;
  String? question;
  List<ViewDiagnosticQuestionListOptions>? options;
  String answer = "";

  ViewDiagnosticQuestionListData({
    this.questionId,
    this.question,
    this.options,
    this.answer = "",
  });

  ViewDiagnosticQuestionListData.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    question = json['question'];
    if (json['options'] != null) {
      options = <ViewDiagnosticQuestionListOptions>[];
      json['options'].forEach((v) {
        options!.add(ViewDiagnosticQuestionListOptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['questionId'] = questionId;
    data['question'] = question;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    data['answer'] = answer;
    return data;
  }
}

class ViewDiagnosticQuestionListOptions {
  int? optionId;
  String? optionName;

  ViewDiagnosticQuestionListOptions({this.optionId, this.optionName});

  ViewDiagnosticQuestionListOptions.fromJson(Map<String, dynamic> json) {
    optionId = json['optionId'];
    optionName = json['optionName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['optionId'] = optionId;
    data['optionName'] = optionName;
    return data;
  }
}
