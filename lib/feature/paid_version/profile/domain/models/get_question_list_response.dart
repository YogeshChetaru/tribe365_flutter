class GetQuestionListResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  List<GetQuestionListData>? data;

  GetQuestionListResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

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

class GetQuestionListData {
  int? questionId;
  String? questionName;
  List<Option>? option;
  bool? flag = false;

  GetQuestionListData({this.questionId, this.questionName, this.option,this.flag});

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['questionId'] = questionId;
    data['questionName'] = questionName;
    data['flag'] = flag;
    if (option != null) {
      data['option'] = option!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Option {
  int? optionId;
  String? option;
  String? roleMapId;
  String? label;
  String? answer="0";
  bool? flag;
  String? oldValue;


  Option({this.optionId, this.option, this.roleMapId,  this.label,
    this.answer = "0",
    this.flag = false,
    this.oldValue,});

  Option.fromJson(Map<String, dynamic> json) {
    optionId = json['OptionId'];
    option = json['option'];
    roleMapId = json['roleMapId'];
    label = json['label'];
    answer= json['answer'] ?? "0";
    oldValue= json['answer'] ?? "0";

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OptionId'] = optionId;
    data['option'] = option;
    data['roleMapId'] = roleMapId;
    data['label'] = label;
    data['answer'] = answer;
    data['answer'] = oldValue;
    return data;
  }
}
