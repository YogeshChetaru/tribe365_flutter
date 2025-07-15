import 'package:flutter/material.dart';

import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../controllers/risk_controller.dart';
import '../domain/models/view_risk_register_list_response.dart';

Widget buildDropdown(RiskController riskProvider) {
  return Container(
    margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
    decoration: BoxDecoration(
      color: ColorResources.white,
      boxShadow: [
        BoxShadow(
          color: ColorResources.colorAAADC4,
          blurRadius: 3.0,
        ),
      ],
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<SwotList>(
        isExpanded: true,
        value: riskProvider.riskTypeSelectedValue,
        items: riskProvider.swotList!.map((SwotList value) {
          return DropdownMenuItem<SwotList>(
            value: value,
            child: Text(
              value.title ?? "",
              style: const TextStyle(
                fontSize: Dimensions.sp14,
                color: ColorResources.black,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
              ),
            ),
          );
        }).toList(),
        onChanged: (SwotList? newValue) {
          riskProvider.updateRiskTypeSelectedValue(newValue);
        },
      ),
    ),
  );
}