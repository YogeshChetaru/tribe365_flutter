class ViewSupportHistoryListResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  List<ViewSupportHistoryListData>? data;
  int? totalPageCount;
  int? currentPage;

  ViewSupportHistoryListResponse(
      {this.code,
        this.status,
        this.serviceName,
        this.message,
        this.data,
        this.totalPageCount,
        this.currentPage});

  ViewSupportHistoryListResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ViewSupportHistoryListData>[];
      json['data'].forEach((v) {
        data!.add(ViewSupportHistoryListData.fromJson(v));
      });
    }
    totalPageCount = json['totalPageCount'];
    currentPage = json['currentPage'];
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
    data['totalPageCount'] = totalPageCount;
    data['currentPage'] = currentPage;
    return data;
  }
}

class ViewSupportHistoryListData {
  int? id;
  String? message;
  String? image;
  String? createdAt;
  String? status;
  List<SupportMessage>? messages;

  ViewSupportHistoryListData(
      {this.id,
        this.message,
        this.image,
        this.createdAt,
        this.status,
        this.messages});

  ViewSupportHistoryListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    image = json['image'];
    createdAt = json['createdAt'];
    status = json['status'];
    if (json['messages'] != null) {
      messages = <SupportMessage>[];
      json['messages'].forEach((v) {
        messages!.add(SupportMessage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = message;
    data['image'] = image;
    data['createdAt'] = createdAt;
    data['status'] = status;
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SupportMessage {
  final int? id;
  final int? sendTo;
  final int? sendFrom;
  final String? name;
  final String? message;
  final String? createdAt;
  final String? userImageUrl;
  final String? msgImageUrl;
  final String? userType;

  SupportMessage({
    this.id,
    this.sendTo,
    this.sendFrom,
    this.name,
    this.message,
    this.createdAt,
    this.userImageUrl,
    this.msgImageUrl,
    this.userType,
  });

  factory SupportMessage.fromJson(Map<String, dynamic> json) {
    return SupportMessage(
      id: json['id'] as int?,
      sendTo: json['sendTo'] as int?,
      sendFrom: json['sendFrom'] as int?,
      name: json['name'] as String?,
      message: json['message'] as String?,
      createdAt: json['created_at'] as String?,
      userImageUrl: json['userImageUrl'] as String?,
      msgImageUrl: json['msgImageUrl'] as String?,
      userType: json['userType'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sendTo': sendTo,
      'sendFrom': sendFrom,
      'name': name,
      'message': message,
      'created_at': createdAt,
      'userImageUrl': userImageUrl,
      'msgImageUrl': msgImageUrl,
      'userType': userType,
    };
  }
}
