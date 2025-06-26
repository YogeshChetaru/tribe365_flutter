class ViewCotMapperSummaryResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  List<ViewCotMapperSummaryData>? data;

  ViewCotMapperSummaryResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ViewCotMapperSummaryResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ViewCotMapperSummaryData>[];
      json['data'].forEach((v) {
        data!.add(ViewCotMapperSummaryData.fromJson(v));
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

class ViewCotMapperSummaryData {
  String? title;
  String? shortDescription;
  String? longDescription;

  ViewCotMapperSummaryData({this.title, this.shortDescription, this.longDescription});

  ViewCotMapperSummaryData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['short_description'] = shortDescription;
    data['long_description'] = longDescription;
    return data;
  }
}