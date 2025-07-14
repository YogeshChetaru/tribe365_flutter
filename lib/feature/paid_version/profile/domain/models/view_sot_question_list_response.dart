class ViewSotQuestionListResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  List<ViewSotQuestionListData>? data;

  ViewSotQuestionListResponse({
    this.code,
    this.status,
    this.serviceName,
    this.message,
    this.data,
  });

  ViewSotQuestionListResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ViewSotQuestionListData>[];
      json['data'].forEach((v) {
        data!.add(ViewSotQuestionListData.fromJson(v));
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

class ViewSotQuestionListData {
  String? question;
  List<ViewSotQuestionListOption>? option;

  ViewSotQuestionListData({this.question, this.option});

  ViewSotQuestionListData.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    if (json['option'] != null) {
      option = <ViewSotQuestionListOption>[];
      json['option'].forEach((v) {
        option!.add(ViewSotQuestionListOption.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    if (option != null) {
      data['option'] = option!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ViewSotQuestionListOption {
  int? id;
  String? section;
  String? question;
  String? type;
  bool isChecked;

  ViewSotQuestionListOption({
    this.id,
    this.section,
    this.question,
    this.type,
    this.isChecked = false,
  });

  ViewSotQuestionListOption.fromJson(Map<String, dynamic> json)
      : isChecked = false
  {
    id = json['id'];
    section = json['section'];
    question = json['question'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['section'] = section;
    data['question'] = question;
    data['type'] = type;
    data['isChecked'] = isChecked;
    return data;
  }
}
