class ViewNotificationListResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  int? totalPageCount;
  String? currentPage;
  List<ViewNotificationListData>? data;

  ViewNotificationListResponse(
      {this.code,
        this.status,
        this.serviceName,
        this.message,
        this.totalPageCount,
        this.currentPage,
        this.data});

  ViewNotificationListResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    totalPageCount = json['totalPageCount'];
    currentPage = json['currentPage'];
    if (json['data'] != null) {
      data = <ViewNotificationListData>[];
      json['data'].forEach((v) {
        data!.add(new ViewNotificationListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    data['service_name'] = serviceName;
    data['message'] = message;
    data['totalPageCount'] = totalPageCount;
    data['currentPage'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ViewNotificationListData {
  int? id;
  String? title;
  String? description;
  String? feedbackId;
  String? supportId;
  String? reflectionId;
  String? notificationType;
  String? createdAt;
  String? lastMessage;
  bool? file;
  int? fromUserId;
  String? teamFeedbackId;
  bool? isRead;

  ViewNotificationListData(
      {this.id,
        this.title,
        this.description,
        this.feedbackId,
        this.supportId,
        this.reflectionId,
        this.notificationType,
        this.createdAt,
        this.lastMessage,
        this.file,
        this.fromUserId,
        this.teamFeedbackId,
        this.isRead});

  ViewNotificationListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    feedbackId = json['feedbackId'];
    supportId = json['supportId'];
    reflectionId = json['reflectionId'];
    notificationType = json['notificationType'];
    createdAt = json['created_at'];
    lastMessage = json['lastMessage'];
    file = json['file'];
    fromUserId = json['fromUserId'];
    teamFeedbackId = json['teamFeedbackId'];
    isRead = json['isRead'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['feedbackId'] = feedbackId;
    data['supportId'] = supportId;
    data['reflectionId'] = reflectionId;
    data['notificationType'] = notificationType;
    data['created_at'] = createdAt;
    data['lastMessage'] = lastMessage;
    data['file'] = file;
    data['fromUserId'] = fromUserId;
    data['teamFeedbackId'] = teamFeedbackId;
    data['isRead'] = isRead;
    return data;
  }
}