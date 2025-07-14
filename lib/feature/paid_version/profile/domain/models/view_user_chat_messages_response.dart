class ViewUserChatMessagesResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  ViewUserChatMessagesData? data;

  ViewUserChatMessagesResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ViewUserChatMessagesResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    data = json['data'] != null ? ViewUserChatMessagesData.fromJson(json['data']) : null;
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

class ViewUserChatMessagesData {
  SupportMessage? supportMessage;
  List<ViewUserChatMessages>? messages;

  ViewUserChatMessagesData({this.supportMessage, this.messages});

  ViewUserChatMessagesData.fromJson(Map<String, dynamic> json) {
    supportMessage = json['supportMessage'] != null
        ? SupportMessage.fromJson(json['supportMessage'])
        : null;
    if (json['messages'] != null) {
      messages = <ViewUserChatMessages>[];
      json['messages'].forEach((v) {
        messages!.add(ViewUserChatMessages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (supportMessage != null) {
      data['supportMessage'] = supportMessage!.toJson();
    }
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SupportMessage {
  String? initialMessage;
  String? initialMsgDate;
  String? msgImageUrl;

  SupportMessage({this.initialMessage, this.initialMsgDate, this.msgImageUrl});

  SupportMessage.fromJson(Map<String, dynamic> json) {
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

class ViewUserChatMessages {
  int? id;
  int? sendTo;
  int? sendFrom;
  String? name;
  String? message;
  String? createdAt;
  String? userImageUrl;
  String? msgImageUrl;
  String? userType;

  ViewUserChatMessages(
      {this.id,
        this.sendTo,
        this.sendFrom,
        this.name,
        this.message,
        this.createdAt,
        this.userImageUrl,
        this.msgImageUrl,
        this.userType});

  ViewUserChatMessages.fromJson(Map<String, dynamic> json) {
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