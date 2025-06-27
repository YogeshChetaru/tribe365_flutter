class GetUpdateQuestionListResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  List<GetUpdateQuestionListData>? data;

  GetUpdateQuestionListResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  GetUpdateQuestionListResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetUpdateQuestionListData>[];
      json['data'].forEach((v) {
        data!.add(new GetUpdateQuestionListData.fromJson(v));
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

class GetUpdateQuestionListData {
  int? questionId;
  String? question;
  List<Options>? options;
  int? answerId;

  GetUpdateQuestionListData({this.questionId, this.question, this.options, this.answerId});

  GetUpdateQuestionListData.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    question = json['question'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
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

class Options {
  String oldValue;
  String newValue;
  bool flag;
   int? answerId;
   int? optionId;
   String? optionName;
   String? point;
   String? answer;
   String? alphabate;

  Options({
    this.oldValue = "",
    this.newValue = "",
    this.flag = false,
    this.answerId,
    this.optionId,
    this.optionName,
    this.point,
    this.answer = "",
    this.alphabate = "",
  });

  /// Factory constructor to create from JSON
  factory Options.fromJson(Map<String, dynamic> json) {
    return Options(
      answerId: json['answerId'] as int?,
      optionId: json['optionId'] as int?,
      optionName: json['optionName'] as String?,
      point: json['point'] as String?,
      answer: (json['answer'] as String?) ??
          (json['point'] as String?) ??
          "0",
      alphabate: json['alphabate'] as String? ?? "",
    );
  }

  /// Convert this object to JSON
  Map<String, dynamic> toJson() {
    return {
      'answerId': answerId,
      'optionId': optionId,
      'optionName': optionName,
      'point': point,
      'answer': answer,
      'alphabate': alphabate,
    };
  }
}
