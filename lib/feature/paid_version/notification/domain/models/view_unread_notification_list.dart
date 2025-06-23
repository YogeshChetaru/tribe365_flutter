class ViewUnreadNotificationList {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  List<ViewUnreadNotificationData>? data;
  AnsStatus? ansStatus;
  ToDoList? toDoList;
  ReminderList? reminderList;
  int? totalPageCount;
  int? currentPage;
  List<NotificationAction>? actions;

  ViewUnreadNotificationList(
      {this.code,
        this.status,
        this.serviceName,
        this.message,
        this.data,
        this.ansStatus,
        this.toDoList,
        this.reminderList,
        this.totalPageCount,
        this.currentPage,
        this.actions});

  ViewUnreadNotificationList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ViewUnreadNotificationData>[];
      json['data'].forEach((v) {
        data!.add(ViewUnreadNotificationData.fromJson(v));
      });
    }
    ansStatus = json['ansStatus'] != null
        ? AnsStatus.fromJson(json['ansStatus'])
        : null;
    toDoList = json['toDoList'] != null
        ? ToDoList.fromJson(json['toDoList'])
        : null;
    reminderList = json['reminderList'] != null
        ? ReminderList.fromJson(json['reminderList'])
        : null;
    totalPageCount = json['totalPageCount'];
    currentPage = json['currentPage'];
    if (json['actions'] != null) {
      actions = <NotificationAction>[];
      json['actions'].forEach((v) {
        actions!.add(NotificationAction.fromJson(v));
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
    if (ansStatus != null) {
      data['ansStatus'] = ansStatus!.toJson();
    }
    if (toDoList != null) {
      data['toDoList'] = toDoList!.toJson();
    }
    if (reminderList != null) {
      data['reminderList'] = reminderList!.toJson();
    }
    data['totalPageCount'] = totalPageCount;
    data['currentPage'] = currentPage;
    if (actions != null) {
      data['actions'] = actions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ViewUnreadNotificationData {
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
  int? teamFeedbackId;
  bool? isRead;



  ViewUnreadNotificationData(
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

  ViewUnreadNotificationData.fromJson(Map<String, dynamic> json) {
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

class AnsStatus {
  bool? tribeValue;
  bool? functionalLens;
  bool? teamRoleAnswers;
  bool? cultureStructure;
  bool? motivation;
  bool? tribeometer;
  bool? diagnostic;

  AnsStatus(
      {this.tribeValue,
        this.functionalLens,
        this.teamRoleAnswers,
        this.cultureStructure,
        this.motivation,
        this.tribeometer,
        this.diagnostic});

  AnsStatus.fromJson(Map<String, dynamic> json) {
    tribeValue = json['tribeValue'];
    functionalLens = json['functionalLens'];
    teamRoleAnswers = json['teamRoleAnswers'];
    cultureStructure = json['cultureStructure'];
    motivation = json['motivation'];
    tribeometer = json['tribeometer'];
    diagnostic = json['diagnostic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tribeValue'] = tribeValue;
    data['functionalLens'] = functionalLens;
    data['teamRoleAnswers'] = teamRoleAnswers;
    data['cultureStructure'] = cultureStructure;
    data['motivation'] = motivation;
    data['tribeometer'] = tribeometer;
    data['diagnostic'] = diagnostic;
    return data;
  }
}

class ToDoList {
  bool? tribeValue;
  bool? functionalLens;
  bool? teamRoleAnswers;
  bool? cultureStructure;
  bool? motivation;
  bool? tribeometer;
  bool? diagnostic;
  bool? bubbleRatings;

  ToDoList(
      {this.tribeValue,
        this.functionalLens,
        this.teamRoleAnswers,
        this.cultureStructure,
        this.motivation,
        this.tribeometer,
        this.diagnostic,
        this.bubbleRatings});

  ToDoList.fromJson(Map<String, dynamic> json) {
    tribeValue = json['tribeValue'];
    functionalLens = json['functionalLens'];
    teamRoleAnswers = json['teamRoleAnswers'];
    cultureStructure = json['cultureStructure'];
    motivation = json['motivation'];
    tribeometer = json['tribeometer'];
    diagnostic = json['diagnostic'];
    bubbleRatings = json['bubbleRatings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tribeValue'] = tribeValue;
    data['functionalLens'] = functionalLens;
    data['teamRoleAnswers'] = teamRoleAnswers;
    data['cultureStructure'] = cultureStructure;
    data['motivation'] = motivation;
    data['tribeometer'] = tribeometer;
    data['diagnostic'] = diagnostic;
    data['bubbleRatings'] = bubbleRatings;
    return data;
  }
}

class ReminderList {
  bool? tribeValue;
  bool? teamRoleAnswers;
  bool? cultureStructure;
  bool? motivation;
  bool? tribeometer;
  bool? bubbleRatings;

  ReminderList(
      {this.tribeValue,
        this.teamRoleAnswers,
        this.cultureStructure,
        this.motivation,
        this.tribeometer,
        this.bubbleRatings});

  ReminderList.fromJson(Map<String, dynamic> json) {
    tribeValue = json['tribeValue'];
    teamRoleAnswers = json['teamRoleAnswers'];
    cultureStructure = json['cultureStructure'];
    motivation = json['motivation'];
    tribeometer = json['tribeometer'];
    bubbleRatings = json['bubbleRatings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tribeValue'] = tribeValue;
    data['teamRoleAnswers'] = teamRoleAnswers;
    data['cultureStructure'] = cultureStructure;
    data['motivation'] = motivation;
    data['tribeometer'] = tribeometer;
    data['bubbleRatings'] = bubbleRatings;
    return data;
  }
}

class NotificationAction {
  int? id;
  String? name;
  String? description;
  String? dueDate;

  NotificationAction({this.id, this.name, this.description, this.dueDate});

  factory NotificationAction.fromJson(Map<String, dynamic> json) {
    return NotificationAction(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      dueDate: json['dueDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'dueDate': dueDate,
    };
  }
}