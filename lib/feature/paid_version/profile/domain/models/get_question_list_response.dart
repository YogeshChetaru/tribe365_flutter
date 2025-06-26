class GetQuestionListResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  List<GetQuestionListData>? data;

  GetQuestionListResponse({
    this.code,
    this.status,
    this.serviceName,
    this.message,
    this.data,
  });

  GetQuestionListResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetQuestionListData>[];
      json['data'].forEach((v) {
        data!.add(GetQuestionListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'status': status,
      'service_name': serviceName,
      'message': message,
      'data': data?.map((v) => v.toJson()).toList(),
    };
  }
}

class GetQuestionListData {
  int? questionId;
  String? questionName;
  List<Option>? option;
  bool? flag = false;

  GetQuestionListData({
    this.questionId,
    this.questionName,
    this.option,
    this.flag,
  });

  GetQuestionListData.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    questionName = json['questionName'];
    flag = json['flag'];
    if (json['option'] != null) {
      option = <Option>[];
      json['option'].forEach((v) {
        option!.add(Option.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'questionName': questionName,
      'flag': flag,
      'option': option?.map((v) => v.toJson()).toList(),
    };
  }
}

class Option {
  int? optionId;
  String? option;
  String? roleMapId;
  String? label;
  String? answer;
  bool? flag;

  Option({
    this.optionId,
    this.option,
    this.roleMapId,
    this.label,
    this.answer = "0",
    this.flag = false,
  });

  Option.fromJson(Map<String, dynamic> json) {
    optionId = json['OptionId'];
    option = json['option'];
    roleMapId = json['roleMapId'];
    label = json['label'];
    answer = json['answer'] ?? "0";
    flag = json['flag'] ?? false;
  }

  Map<String, dynamic> toJson() {
    return {
      'OptionId': optionId,
      'option': option,
      'roleMapId': roleMapId,
      'label': label,
      'answer': answer,
      'flag': flag,
    };
  }
}
