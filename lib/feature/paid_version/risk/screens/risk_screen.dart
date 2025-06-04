import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/common/basewidget/custom_header_widget.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/dimensions.dart';
import '../controllers/risk_controller.dart';

class RiskScreen extends StatefulWidget {
  const RiskScreen({super.key});

  @override
  RiskScreenState createState() => RiskScreenState();
}

class RiskScreenState extends State<RiskScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Consumer<RiskController>(builder: (context, riskProvider, _) {
          return Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            color: ColorResources.screenBg,
            child: Column(
              children: [
                CustomHeader(),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          decoration: BoxDecoration(
                            color: ColorResources.white,
                            boxShadow: [
                              BoxShadow(
                                color: ColorResources.colorAAADC4,
                                blurRadius: 3.0,
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: riskProvider.riskTypeSelectedValue,
                                  items: riskProvider.riskTypeList.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                          fontSize: Dimensions.sp14,
                                          color: ColorResources.black,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    riskProvider.updateRiskTypeSelectedValue(newValue);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    riskProvider.updateIsType("new");
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.fromLTRB(0, 13, 0, 15),
                                    width: MediaQuery.sizeOf(context).width,
                                    decoration: BoxDecoration(
                                      color: riskProvider.isType == "new" ? ColorResources.mainColor : ColorResources.white,
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorResources.colorAAADC4,
                                          blurRadius: 3.0,
                                        ),
                                      ],
                                    ),
                                    child: Text(

                                      "${getTranslated("new", context)!}\n0",
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: Dimensions.sp14,
                                          fontWeight: FontWeight.w600,
                                          color: riskProvider.isType == "new" ? ColorResources.white : ColorResources.black),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    riskProvider.updateIsType("ongoing");
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.fromLTRB(0, 13, 0, 15),
                                    width: MediaQuery.sizeOf(context).width,
                                    decoration: BoxDecoration(
                                      color: riskProvider.isType == "ongoing" ? ColorResources.mainColor : ColorResources.white,
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorResources.colorAAADC4,
                                          blurRadius: 3.0,
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      "${getTranslated("ongoing", context)!}\n0",
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: Dimensions.sp14,
                                          fontWeight: FontWeight.w600,
                                          color: riskProvider.isType == "ongoing" ? ColorResources.white : ColorResources.black),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    riskProvider.updateIsType("managed");
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.fromLTRB(0, 13, 0, 15),
                                    width: MediaQuery.sizeOf(context).width,
                                    decoration: BoxDecoration(
                                      color: riskProvider.isType == "managed" ? ColorResources.mainColor : ColorResources.white,
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorResources.colorAAADC4,
                                          blurRadius: 3.0,
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      "${getTranslated("managed", context)!}\n0",
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: Dimensions.sp14,
                                          fontWeight: FontWeight.w600,
                                          color: riskProvider.isType == "managed" ? ColorResources.white : ColorResources.black),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
