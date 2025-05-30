import 'package:flutter/material.dart';

class BuildDayText extends StatefulWidget {
  final String day;
  final Color color;

  const BuildDayText({super.key, required this.day, required this.color});

  @override
  State<BuildDayText> createState() => BuildDayTextState();
}

class BuildDayTextState extends State<BuildDayText> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        alignment: Alignment.center,
        child: Text(
          widget.day,
          style: const TextStyle(fontFamily: 'Roboto', fontSize: 16, fontWeight: FontWeight.w500).copyWith(color: widget.color),
        ),
      ),
    );
  }
}
