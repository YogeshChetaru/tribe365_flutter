import 'package:flutter/material.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/utility.dart';
import '../../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../../data/model/api_response.dart';
import '../../../../helper/api_checker.dart';
import '../../../../main.dart';
import '../domain/models/view_risk_detail_response.dart';
import '../domain/models/view_risk_register_list_response.dart';
import '../domain/services/risk_service_interface.dart';


class RiskController extends ChangeNotifier {
  final RiskServiceInterface? riskServiceInterface;

  RiskController({required this.riskServiceInterface});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  SwotList? riskTypeSelectedValue;
  String isType = "ongoing";
  String swotId = "";

  void updateRiskTypeSelectedValue(SwotList? data) {
    riskTypeSelectedValue = data!;
    if (riskTypeSelectedValue!.title=="SWOT"){
      swotId="";
      viewRiskRegisterList(swotId,isType);
    }else {
      if (int.parse(swotId==""?"0":swotId)!=riskTypeSelectedValue!.id!) {
        swotId = riskTypeSelectedValue!.id.toString();
        viewRiskRegisterList(swotId,isType);
      }
    }

    notifyListeners();
  }

  void updateIsType(String s,bool isNotify) {
    if (s == 'new') {
      isType = "new";
    } else if(s=="ongoing") {
      isType = "ongoing";
    }
    else {
      isType = "managed";
    }
    viewRiskRegisterList(swotId, isType);
    if(isNotify){
      notifyListeners();
    }

  }

  String firstValue = "";
  String firstTitle = "";
  String secondValue = "";
  String secondTitle = "";
  String thirdValue = "";
  String thirdTitle = "";
  String noRiskMsg = '';
  List<SwotList>? swotList;
  List<RiskCount>?  riskCount;
  List<RiskArr>? riskArr;

  String capitalize(String? s) {
    if (s == null || s.isEmpty) return '';
    return s[0].toUpperCase() + s.substring(1);
  }

  String actionTitle = "";
  String actionDesc = "";
  String actionDate = "";
  String actionRisk = "";
  String numOffloadStatus = "";
  List<ActionList>? actionsList;
  //-------------API calling---------------
  Future<void> viewRiskRegisterList(String swotId,String statusData) async {
    _isLoading = true;
    String status = "";
    if(statusData=="new"){
      status = "1";
    }
    else if(statusData =="ongoing"){
      status = "2";
    }
    else if(statusData =="managed"){
      status = "3";
    }

    Map<String, dynamic> request = {"swotId": swotId, "status": status};
    ApiResponse apiResponse = await riskServiceInterface!.viewRiskRegisterList(request);
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewRiskRegisterListResponse response = ViewRiskRegisterListResponse.fromJson(map);

      riskArr = response.data!.riskArr!;

      if (status=="1"){
        noRiskMsg=getTranslated("no_new_risk", Get.context!)!;
      }else if (status=="2"){
        noRiskMsg=getTranslated("no_ongoing_risk", Get.context!)!;
      }else if (status=="3"){
        noRiskMsg=getTranslated("no_risk_closed_yet", Get.context!)!;
      }

      if(swotList==null){
        swotList = [];
        swotList!.add(SwotList(id: 0,title: "SWOT"));
        for(int i = 0;i<response.data!.swotList!.length;i++ ){
          swotList!.add(
              SwotList(
                  id: response.data!.swotList![i].id,
                  title: capitalize(response.data!.swotList![i].title)
              )
          );
        }
        riskTypeSelectedValue = swotList![0];
      }
      riskCount = response.data!.riskCount;

      if(riskCount!.isNotEmpty){
        for (int i=0;i<riskCount!.length;i++){
          if (i==0){
            firstTitle = riskCount![0].statusTitle!;
            firstValue = riskCount![0].count.toString();
          }else if (i==1){
            secondTitle = riskCount![1].statusTitle!;
            secondValue = riskCount![1].count.toString();
          }else if (i==2){
            thirdTitle = riskCount![2].statusTitle!;
            thirdValue = riskCount![2].count.toString();
          }
        }
      }

    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }


  Future<void> viewRiskDetail(String id) async {
    _isLoading = true;
    Map<String, dynamic> request = {"riskId": id, };
    ApiResponse apiResponse = await riskServiceInterface!.viewRiskDetail(request);
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String, dynamic> map = apiResponse.response!.data;
      ViewRiskDetailResponse response = ViewRiskDetailResponse.fromJson(map);
      ViewRiskDetailData? data = response.data;
      actionTitle = data!.title!;
      actionDesc=data.description!;
      actionDate= "Created on ${Utility.changeDateDMYtoYMD(data.date!)} with ";
      actionRisk = data.priority!;

      actionsList = data.actions;

      if(data.offloads!=null){
        numOffloadStatus = "Linked Offloads : ${data.offloads}";
      }

    } else {
      showCustomSnackBar(apiResponse.error, Get.context!, isError: true);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

}
