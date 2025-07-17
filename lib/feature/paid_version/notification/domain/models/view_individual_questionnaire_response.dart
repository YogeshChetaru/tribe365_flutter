class ViewIndividualQuestionnaireResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  ViewIndividualQuestionnaireData? data;

  ViewIndividualQuestionnaireResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ViewIndividualQuestionnaireResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    data = json['data'] != null ? ViewIndividualQuestionnaireData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    data['service_name'] = serviceName;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ViewIndividualQuestionnaireData {
  String? userName;
  List<ViewIndividualQuestionArr>? questionArr;

  ViewIndividualQuestionnaireData({this.userName, this.questionArr});

  ViewIndividualQuestionnaireData.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    if (json['questionArr'] != null) {
      questionArr = <ViewIndividualQuestionArr>[];
      json['questionArr'].forEach((v) {
        questionArr!.add(ViewIndividualQuestionArr.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    if (questionArr != null) {
      data['questionArr'] = questionArr!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ViewIndividualQuestionArr {
  int? questionId;
  String? question;
  List<ViewIndividualOptions>? options;
  String mAnswer; // selected answer

  ViewIndividualQuestionArr({
    this.questionId,
    this.question,
    this.options,
    this.mAnswer = '',
  });

  factory ViewIndividualQuestionArr.fromJson(Map<String, dynamic> json) {
    return ViewIndividualQuestionArr(
      questionId: json['questionId'],
      question: json['question'],
      options: json['options'] != null
          ? List<ViewIndividualOptions>.from(
          json['options'].map((x) => ViewIndividualOptions.fromJson(x)))
          : [],
      mAnswer: json['mAnswer'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'question': question,
      'options': options?.map((x) => x.toJson()).toList(),
      'mAnswer': mAnswer,
    };
  }
}

class ViewIndividualOptions {
  int? optionId;
  String? optionName;
  bool answerFlag; // indicates if selected

  ViewIndividualOptions({
    this.optionId,
    this.optionName,
    this.answerFlag = false,
  });

  factory ViewIndividualOptions.fromJson(Map<String, dynamic> json) {
    return ViewIndividualOptions(
      optionId: json['optionId'],
      optionName: json['optionName'],
      answerFlag: json['answerFlag'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'optionId': optionId,
      'optionName': optionName,
      'answerFlag': answerFlag,
    };
  }
}
