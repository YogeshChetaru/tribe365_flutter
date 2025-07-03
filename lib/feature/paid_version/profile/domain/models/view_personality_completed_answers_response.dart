class ViewPersonalityCompletedAnswersResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  List<ViewPersonalityCompletedAnswersData>? data;

  ViewPersonalityCompletedAnswersResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ViewPersonalityCompletedAnswersResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ViewPersonalityCompletedAnswersData>[];
      json['data'].forEach((v) {
        data!.add(ViewPersonalityCompletedAnswersData.fromJson(v));
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


class ViewPersonalityCompletedAnswersOptions {
  int? optionId;
  String? optionName;
  bool? isChecked;
  int? answerId;

  ViewPersonalityCompletedAnswersOptions({this.optionId, this.optionName, this.isChecked, this.answerId});

  ViewPersonalityCompletedAnswersOptions.fromJson(Map<String, dynamic> json) {
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

class ViewPersonalityCompletedAnswersData {
  int? questionId;
  String? question;
  String answer;
  int? answerId;
  List<ViewPersonalityCompletedAnswersOptions>? options;
  bool flag; // <-- added flag

  ViewPersonalityCompletedAnswersData({
    this.questionId,
    this.question,
    this.answer = '',
    this.answerId,
    this.options,
    this.flag = false, // default value
  });

  factory ViewPersonalityCompletedAnswersData.fromJson(Map<String, dynamic> json) {
    return ViewPersonalityCompletedAnswersData(
      questionId: json['questionId'],
      question: json['question'],
      answer: json['answer'] ?? '',
      answerId: json['answerId'],
      options: json['options'] != null
          ? (json['options'] as List)
          .map((e) => ViewPersonalityCompletedAnswersOptions.fromJson(e))
          .toList()
          : [],
      flag: json['flag'] ?? false, // safely parse flag
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'question': question,
      'answer': answer,
      'answerId': answerId,
      'options': options?.map((e) => e.toJson()).toList(),
      'flag': flag,
    };
  }
}

