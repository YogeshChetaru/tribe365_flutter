import 'package:flutter/material.dart';

import '../../../../utill/color_resources.dart';
import '../domain/models/view_risk_register_list_response.dart';

class RiskListWidget extends StatelessWidget {
  final List<RiskArr> riskList;
  final void Function(RiskArr) onRiskTap;

  const RiskListWidget({
    super.key,
    required this.riskList,
    required this.onRiskTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: riskList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final risk = riskList[index];
        final isHigh = risk.priority == "High";

        final color = isHigh ? ColorResources.mainColor : Colors.black;

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: InkWell(
            onTap: () => onRiskTap(risk),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${index + 1}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto',
                      ).copyWith(color: color),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 1,
                    color: Colors.grey.shade300,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        risk.title!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                        ).copyWith(color: color),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      risk.priority!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                      ).copyWith(color: color),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
