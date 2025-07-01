class ViewPersonalityTypeQuestionListResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  List<ViewPersonalityTypeQuestionListData>? data;

  ViewPersonalityTypeQuestionListResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ViewPersonalityTypeQuestionListResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ViewPersonalityTypeQuestionListData>[];
      json['data'].forEach((v) {
        data!.add(ViewPersonalityTypeQuestionListData.fromJson(v));
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

class ViewPersonalityTypeQuestionListData {
  bool flag;
  List<ViewPersonalityTypeQuestionListOptions>? options;
  String? question;
  String answer;
  int? questionId;


  ViewPersonalityTypeQuestionListData({ this.flag = false,
    this.options,
    this.question,
    this.answer = "",
    this.questionId,});

  factory ViewPersonalityTypeQuestionListData.fromJson(Map<String, dynamic> json) {
    return ViewPersonalityTypeQuestionListData(
      flag: false,
      options: json["options"] != null
          ? List<ViewPersonalityTypeQuestionListOptions>.from(
        json["options"].map((x) => ViewPersonalityTypeQuestionListOptions.fromJson(x)),
      )
          : [],
      question: json["question"],
      answer: json["answer"] ?? "",
      questionId: json["questionId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "options": options?.map((x) => x.toJson()).toList(),
      "question": question,
      "answer": answer,
      "questionId": questionId,
    };
  }
}

class ViewPersonalityTypeQuestionListOptions {
  int? optionId;
  String? optionName;

  ViewPersonalityTypeQuestionListOptions({this.optionId, this.optionName});

  ViewPersonalityTypeQuestionListOptions.fromJson(Map<String, dynamic> json) {
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