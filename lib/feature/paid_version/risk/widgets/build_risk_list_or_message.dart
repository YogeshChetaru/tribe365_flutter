import 'package:flutter/material.dart';
import 'package:tribe365_new/feature/paid_version/risk/screens/risk_list_details_screen.dart';
import 'package:tribe365_new/feature/paid_version/risk/widgets/risk_list_widget.dart';
import 'package:tribe365_new/utill/custom_route.dart';

import '../../../../main.dart';
import '../controllers/risk_controller.dart';

Widget buildRiskListOrMessage(RiskController riskProvider) {
  if (riskProvider.riskArr == null || riskProvider.riskArr!.isEmpty) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: InkWell(
          onTap: (){
            routePush(Get.context!, RiskListDetailsScreen());
          },child: Text(
            riskProvider.noRiskMsg,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ),
    );
  } else {
    return ListView.builder(
      itemCount: riskProvider.riskArr!.length,
      itemBuilder: (context, index) {
        return RiskListWidget(
          riskList: riskProvider.riskArr!,
          onRiskTap: (risk) {
            routePush(context, RiskListDetailsScreen(riskItemData: riskProvider.riskArr![index]));
          },
        );
      },
    );
  }
}