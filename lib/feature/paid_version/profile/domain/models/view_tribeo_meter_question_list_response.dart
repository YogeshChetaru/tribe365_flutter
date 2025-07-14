class ViewTribeMeterQuestionListResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  List<ViewTribeMeterQuestionListData>? data;

  ViewTribeMeterQuestionListResponse({
    this.code,
    this.status,
    this.serviceName,
    this.message,
    this.data,
  });

  ViewTribeMeterQuestionListResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ViewTribeMeterQuestionListData>[];
      json['data'].forEach((v) {
        data!.add(ViewTribeMeterQuestionListData.fromJson(v));
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

class ViewTribeMeterQuestionListData {
  int? questionId;
  String? question;
  List<ViewTribeMeterQuestionListOptions>? options;
  String? answer;

  ViewTribeMeterQuestionListData({
    this.questionId,
    this.question,
    this.options,
    this.answer,
  });

  ViewTribeMeterQuestionListData.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    question = json['question'];
    if (json['options'] != null) {
      options = <ViewTribeMeterQuestionListOptions>[];
      json['options'].forEach((v) {
        options!.add(ViewTribeMeterQuestionListOptions.fromJson(v));
      });
    }
    answer = "";
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

class ViewTribeMeterQuestionListOptions {
  int? optionId;
  String? optionName;

  /// This is the UI selection flag
  bool isSelected;

  ViewTribeMeterQuestionListOptions({
    this.optionId,
    this.optionName,
    this.isSelected = false, // Default not selected
  });

  ViewTribeMeterQuestionListOptions.fromJson(Map<String, dynamic> json)
      : optionId = json['optionId'],
        optionName = json['optionName'],
        isSelected = false; // Always initialize

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['optionId'] = optionId;
    data['optionName'] = optionName;
    // Optionally include this if you want
    // data['isSelected'] = isSelected;
    return data;
  }
}
