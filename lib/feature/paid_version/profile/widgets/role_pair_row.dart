import 'package:flutter/material.dart';
import 'package:tribe365_new/utill/color_resources.dart';

class RolePairRow extends StatelessWidget {
  final String leftLabel;
  final String leftValue;
  final String rightLabel;
  final String rightValue;

  const RolePairRow({
    super.key,
    required this.leftLabel,
    required this.leftValue,
    required this.rightLabel,
    required this.rightValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color:ColorResources.mainColor, // Replace with your color
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    leftLabel,
                    style: const TextStyle(color: Colors.white,
                        fontSize: 13),
                  ),
                ),
                Text(
                  '$leftValue%',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ],
            ),
          ),
          SizedBox(width: 5,),
          Container(
            width: 1,
            height: 20,
            color: Colors.white24,
          ),
          SizedBox(width: 5,),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      rightLabel,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                ),
                Text(
                  '$rightValue%',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
