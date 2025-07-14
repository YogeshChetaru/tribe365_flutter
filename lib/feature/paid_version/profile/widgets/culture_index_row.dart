import 'package:flutter/material.dart';
import 'package:tribe365_new/utill/color_resources.dart';

class CultureIndexRow extends StatelessWidget {
  final int index;
  final String title;
  final double score;
  final double alpha;

  const CultureIndexRow({
    super.key,
    required this.index,
    required this.title,
    required this.score,
    required this.alpha,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 30,
              child: Center(
                child: Text(
                  "${index + 1} -",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: SizedBox(
                height: 40,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Opacity(
                      opacity: alpha,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: ColorResources.mainColor,
                      ),
                    ),
                    Text(
                      score.toStringAsFixed(2),
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Divider(color: Color(0xFFbdbfbe), thickness: 0.5),
      ],
    );
  }
}
