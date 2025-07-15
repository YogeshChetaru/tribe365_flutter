import 'package:flutter/material.dart';

import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';

Widget buildButton({
  required String label,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return Expanded(
    child: InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(0, 13, 0, 15),
        decoration: BoxDecoration(
          color: isSelected ? ColorResources.mainColor : ColorResources.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: ColorResources.colorAAADC4,
              blurRadius: 3.0,
            ),
          ],
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: Dimensions.sp14,
            fontWeight: FontWeight.w600,
            color: isSelected ? ColorResources.white : ColorResources.black,
          ),
        ),
      ),
    ),
  );
}