import 'package:flutter/material.dart';

import '../controllers/risk_controller.dart';
import 'build_button.dart';

Widget buildButtonsRow(RiskController riskProvider, BuildContext context) {
  return Container(
    margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
    child: Row(
      children: [
        buildButton(
          label: "${riskProvider.firstTitle}\n${riskProvider.firstValue}",
          isSelected: riskProvider.isType == "new",
          onTap: () => riskProvider.updateIsType("new", true),
        ),
        const SizedBox(width: 10),
        buildButton(
          label: "${riskProvider.secondTitle}\n${riskProvider.secondValue}",
          isSelected: riskProvider.isType == "ongoing",
          onTap: () => riskProvider.updateIsType("ongoing", true),
        ),
        const SizedBox(width: 10),
        buildButton(
          label: "${riskProvider.thirdTitle}\n${riskProvider.thirdValue}",
          isSelected: riskProvider.isType == "managed",
          onTap: () => riskProvider.updateIsType("managed", true),
        ),
      ],
    ),
  );
}