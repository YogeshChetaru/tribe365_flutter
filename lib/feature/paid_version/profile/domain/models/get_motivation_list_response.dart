/// Top-level response model
class SOTMotivationQuestionListResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  List<SOTMotivationQuestion>? data;

  SOTMotivationQuestionListResponse({
    this.code,
    this.status,
    this.serviceName,
    this.message,
    this.data,
  });

  factory SOTMotivationQuestionListResponse.fromJson(Map<String, dynamic> json) {
    return SOTMotivationQuestionListResponse(
      code: json['code'] as int?,
      status: json['status'] as bool?,
      serviceName: json['service_name'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SOTMotivationQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'status': status,
      'service_name': serviceName,
      'message': message,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class SOTMotivationQuestion {
  bool flag;
  List<SOTMotivationOption>? option;
  int? questionId;
  String? questionName;

  SOTMotivationQuestion({
    this.flag = false,
    this.option,
    this.questionId,
    this.questionName,
  });

  factory SOTMotivationQuestion.fromJson(Map<String, dynamic> json) {
    return SOTMotivationQuestion(
      questionId: json['questionId'],
      questionName: json['questionName'],
      option: (json['option'] as List<dynamic>?)
          ?.map((e) => SOTMotivationOption.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'questionName': questionName,
      'option': option?.map((e) => e.toJson()).toList(),
    };
  }
}

class SOTMotivationOption {
  int? optionId;
  String? option;
  int? categoryId;
  String? rating; // nullable

  SOTMotivationOption({
    this.optionId,
    this.option,
    this.categoryId,
    this.rating, // no default
  });

  factory SOTMotivationOption.fromJson(Map<String, dynamic> json) {
    return SOTMotivationOption(
      optionId: json['OptionId'],
      option: json['option'],
      categoryId: json['categoryId'],
      rating: json['rating']?.toString(), // no ?? "0"
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'OptionId': optionId,
      'option': option,
      'categoryId': categoryId,
      'rating': rating,
    };
  }
}
