class ViewSotQuestionAnswersListResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  List<ViewSotQuestionAnswersListData>? data;

  ViewSotQuestionAnswersListResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ViewSotQuestionAnswersListResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ViewSotQuestionAnswersListData>[];
      json['data'].forEach((v) {
        data!.add(ViewSotQuestionAnswersListData.fromJson(v));
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

class ViewSotQuestionAnswersListData {
  String? question;
  List<ViewSotQuestionAnswersListOption>? option;

  ViewSotQuestionAnswersListData({this.question, this.option});

  ViewSotQuestionAnswersListData.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    if (json['option'] != null) {
      option = <ViewSotQuestionAnswersListOption>[];
      json['option'].forEach((v) {
        option!.add(ViewSotQuestionAnswersListOption.fromJson(v));
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

class ViewSotQuestionAnswersListOption {
  int? id;
  String? section;
  String? question;
  String? type;
  bool? isChecked;

  ViewSotQuestionAnswersListOption({this.id, this.section, this.question, this.type, this.isChecked});

  ViewSotQuestionAnswersListOption.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    section = json['section'];
    question = json['question'];
    type = json['type'];
    isChecked = json['isChecked'];
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