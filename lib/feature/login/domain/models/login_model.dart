class LoginModel {
  String? email;
  String? password;
  String? role;
  String? deviceType;
  String? deviceId;
  String? fcmToken;
  LoginModel({this.email, this.password, this.role,this.deviceType,this.deviceId,this.fcmToken});

  LoginModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    role = json['role'];
    deviceType = json['deviceType'];
    deviceId = json['deviceId'];
    fcmToken = json['fcmToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['role'] = role;
    data['deviceType'] = deviceType;
    data['deviceId'] = deviceId;
    data['fcmToken'] = fcmToken;
    return data;
  }
}
