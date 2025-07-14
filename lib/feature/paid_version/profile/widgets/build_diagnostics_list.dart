import 'package:flutter/material.dart';
import '../controllers/profile_controller.dart';
import '../domain/models/view_studies_list_response.dart';

Widget buildDiagnosticsList(ProfileController profileProvider) {
  return Column(
    children: List.generate(profileProvider.getDiagnosticReportList!.length, (index) {
      GetDiagnosticReportForGraph data = profileProvider.getDiagnosticReportList![index];
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Text(
              '${index + 1} - ',
              style:
              const TextStyle(fontSize: 16,fontWeight: FontWeight.w400,fontFamily: 'Roboto',color: Colors.black),
            ),
            Expanded(
              child: Text(
                data.title!,
                style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400,fontFamily: 'Roboto',color: Colors.black),
              ),
            ),
            Text(
              '${double.parse(data.percentage.toString()).toStringAsFixed(2)}%',
              style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400,fontFamily: 'Roboto',color: Colors.black),
            ),
          ],
        ),
      );
    }),
  );
}