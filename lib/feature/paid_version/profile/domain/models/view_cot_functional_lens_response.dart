class ViewCotFunctionalLensResponse {
  int? code;
  bool? status;
  String? serviceName;
  String? message;
  ViewCotFunctionalLensData? data;

  ViewCotFunctionalLensResponse(
      {this.code, this.status, this.serviceName, this.message, this.data});

  ViewCotFunctionalLensResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    serviceName = json['service_name'];
    message = json['message'];
    data = json['data'] != null ? ViewCotFunctionalLensData.fromJson(json['data']) : null;
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

class ViewCotFunctionalLensData {
  bool? isCOTfunclensAnswersDone;
  List<FuncLensKeyDetail>? funcLensKeyDetail;
  List<InitialValue>? initialValueList;
  List<ValueCombination>? valueCombination;
  List<TribeTipsArray>? tribeTipsArray;

  ViewCotFunctionalLensData(
      {this.isCOTfunclensAnswersDone,
        this.funcLensKeyDetail,
        this.initialValueList,
        this.valueCombination,
        this.tribeTipsArray});

  ViewCotFunctionalLensData.fromJson(Map<String, dynamic> json) {
    isCOTfunclensAnswersDone = json['isCOTfunclensAnswersDone'];
    if (json['funcLensKeyDetail'] != null) {
      funcLensKeyDetail = <FuncLensKeyDetail>[];
      json['funcLensKeyDetail'].forEach((v) {
        funcLensKeyDetail!.add(FuncLensKeyDetail.fromJson(v));
      });
    }
    if (json['initialValueList'] != null) {
      initialValueList = <InitialValue>[];
      json['initialValueList'].forEach((v) {
        initialValueList!.add(InitialValue.fromJson(v));
      });
    }
    if (json['valueCombination'] != null) {
      valueCombination = <ValueCombination>[];
      json['valueCombination'].forEach((v) {
        valueCombination!.add(ValueCombination.fromJson(v));
      });
    }
    if (json['tribeTipsArray'] != null) {
      tribeTipsArray = <TribeTipsArray>[];
      json['tribeTipsArray'].forEach((v) {
        tribeTipsArray!.add(TribeTipsArray.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isCOTfunclensAnswersDone'] = isCOTfunclensAnswersDone;
    if (funcLensKeyDetail != null) {
      data['funcLensKeyDetail'] =
          funcLensKeyDetail!.map((v) => v.toJson()).toList();
    }
    if (initialValueList != null) {
      data['initialValueList'] =
          initialValueList!.map((v) => v.toJson()).toList();
    }
    if (valueCombination != null) {
      data['valueCombination'] =
          valueCombination!.map((v) => v.toJson()).toList();
    }
    if (tribeTipsArray != null) {
      data['tribeTipsArray'] =
          tribeTipsArray!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FuncLensKeyDetail {
  String? value;
  String? title;
  String? description;

  FuncLensKeyDetail({this.value, this.title, this.description});

  FuncLensKeyDetail.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}

class InitialValue {
  final String? allowableWeaknesses;
  final String? positives;
  final int? score;
  final String? title;
  final String? value;

  InitialValue({
    this.allowableWeaknesses,
    this.positives,
    this.score,
    this.title,
    this.value,
  });

  factory InitialValue.fromJson(Map<String, dynamic> json) {
    return InitialValue(
      allowableWeaknesses: json['allowableWeaknesses'] as String?,
      positives: json['positives'] as String?,
      score: json['score'] != null ? (json['score'] as num).toInt() : null,
      title: json['title'] as String?,
      value: json['value'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'allowableWeaknesses': allowableWeaknesses,
      'positives': positives,
      'score': score,
      'title': title,
      'value': value,
    };
  }
}


class ValueCombination {
  String? value;
  String? title;
  String? summary;

  ValueCombination({this.value, this.title, this.summary});

  ValueCombination.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    title = json['title'];
    summary = json['summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['title'] = title;
    data['summary'] = summary;
    return data;
  }
}

class TribeTipsArray {
  String? value;
  String? title;
  String? summary;
  List<PersuadeArray>? persuadeArray;
  List<PersuadeArray>? seekArray;

  TribeTipsArray(
      {this.value,
        this.title,
        this.summary,
        this.persuadeArray,
        this.seekArray});

  TribeTipsArray.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    title = json['title'];
    summary = json['summary'];
    if (json['PersuadeArray'] != null) {
      persuadeArray = <PersuadeArray>[];
      json['PersuadeArray'].forEach((v) {
        persuadeArray!.add(PersuadeArray.fromJson(v));
      });
    }
    if (json['seekArray'] != null) {
      seekArray = <PersuadeArray>[];
      json['seekArray'].forEach((v) {
        seekArray!.add(PersuadeArray.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['title'] = title;
    data['summary'] = summary;
    if (persuadeArray != null) {
      data['PersuadeArray'] =
          persuadeArray!.map((v) => v.toJson()).toList();
    }
    if (seekArray != null) {
      data['seekArray'] = seekArray!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PersuadeArray {
  String? value;
  String? valueType;

  PersuadeArray({this.value, this.valueType});

  PersuadeArray.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    valueType = json['valueType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['valueType'] = valueType;
    return data;
  }
}