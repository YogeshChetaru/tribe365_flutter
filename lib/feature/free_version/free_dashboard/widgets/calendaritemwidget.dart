import 'package:flutter/material.dart';

class CalendarItemWidget extends StatelessWidget {
  final String title;

  const CalendarItemWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(title),
        trailing: Icon(Icons.calendar_today),
      ),
    );
  }
}
