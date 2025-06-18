class ViewMessageDetailsResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  ViewMessageDetailsData? data;

  ViewMessageDetailsResponse({this.code, this.status, this.serviceName, this.message, this.data});

  ViewMessageDetailsResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    data = json['data'] != null ? ViewMessageDetailsData.fromJson(json['data']) : null;
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

class ViewMessageDetailsData {
  Feedback? feedback;
  List<Messages>? messages;

  ViewMessageDetailsData({this.feedback, this.messages});

  ViewMessageDetailsData.fromJson(Map<String, dynamic> json) {
    feedback = json['feedback'] != null
        ? Feedback.fromJson(json['feedback'])
        : null;
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (feedback != null) {
      data['feedback'] = feedback!.toJson();
    }
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Feedback {
  String? initialMessage;
  String? initialMsgDate;
  String? msgImageUrl;

  Feedback({this.initialMessage, this.initialMsgDate, this.msgImageUrl});

  Feedback.fromJson(Map<String, dynamic> json) {
    initialMessage = json['initialMessage'];
    initialMsgDate = json['initialMsgDate'];
    msgImageUrl = json['msgImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['initialMessage'] = initialMessage;
    data['initialMsgDate'] = initialMsgDate;
    data['msgImageUrl'] = msgImageUrl;
    return data;
  }
}
class Messages {
  int? id;
  int? sendTo;
  int? sendFrom;
  String? name;
  String? message;
  String? createdAt;
  String? userImageUrl;
  String? msgImageUrl;
  String? userType;

  Messages(
      {this.id,
        this.sendTo,
        this.sendFrom,
        this.name,
        this.message,
        this.createdAt,
        this.userImageUrl,
        this.msgImageUrl,
        this.userType});

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sendTo = json['sendTo'];
    sendFrom = json['sendFrom'];
    name = json['name'];
    message = json['message'];
    createdAt = json['created_at'];
    userImageUrl = json['userImageUrl'];
    msgImageUrl = json['msgImageUrl'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sendTo'] = sendTo;
    data['sendFrom'] = sendFrom;
    data['name'] = name;
    data['message'] = message;
    data['created_at'] = createdAt;
    data['userImageUrl'] = userImageUrl;
    data['msgImageUrl'] = msgImageUrl;
    data['userType'] = userType;
    return data;
  }
}
