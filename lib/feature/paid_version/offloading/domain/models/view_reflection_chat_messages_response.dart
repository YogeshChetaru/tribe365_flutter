class ViewReflectionChatMessagesResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  ViewReflectionChatMessagesData? data;

  ViewReflectionChatMessagesResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ViewReflectionChatMessagesResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    data = json['data'] != null ? ViewReflectionChatMessagesData.fromJson(json['data']) : null;
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

class ViewReflectionChatMessagesData {
  Reflection? reflection;
  List<ViewReflectionChatMessages>? messages;

  ViewReflectionChatMessagesData({this.reflection, this.messages});

  ViewReflectionChatMessagesData.fromJson(Map<String, dynamic> json) {
    reflection = json['reflection'] != null
        ? Reflection.fromJson(json['reflection'])
        : null;
    if (json['messages'] != null) {
      messages = <ViewReflectionChatMessages>[];
      json['messages'].forEach((v) {
        messages!.add(ViewReflectionChatMessages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (reflection != null) {
      data['reflection'] = reflection!.toJson();
    }
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reflection {
  String? initialMessage;
  String? initialMsgDate;
  String? msgImageUrl;

  Reflection({this.initialMessage, this.initialMsgDate, this.msgImageUrl});

  Reflection.fromJson(Map<String, dynamic> json) {
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

class ViewReflectionChatMessages {
  int? id;
  int? sendTo;
  int? sendFrom;
  String? name;
  String? message;
  String? createdAt;
  String? userImageUrl;
  String? msgImageUrl;
  String? userType;

  ViewReflectionChatMessages(
      {this.id,
        this.sendTo,
        this.sendFrom,
        this.name,
        this.message,
        this.createdAt,
        this.userImageUrl,
        this.msgImageUrl,
        this.userType});

  ViewReflectionChatMessages.fromJson(Map<String, dynamic> json) {
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