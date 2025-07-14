import 'package:flutter/material.dart';

import '../controllers/profile_controller.dart';
import '../domain/models/view_studies_list_response.dart';

Widget buildMotivationList(ProfileController profileProvider) {
  return Column(
    children: List.generate(profileProvider.viewSOTMotivationReportList!.length, (index) {
      ModelMotivationGraph data = profileProvider.viewSOTMotivationReportList![index];
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Text(
              '${index + 1} - ',
              style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400,fontFamily: 'Roboto',color: Colors.black),
            ),
            Expanded(
              child: Text(
                data.title!,
                style: const TextStyle(
                  fontSize: 16,
                    fontWeight: FontWeight.w400,fontFamily: 'Roboto',color: Colors.black
                ),
              ),
            ),
            Text(
              '${double.parse(data.score.toString()).toStringAsFixed(1)}%',
              style: const TextStyle(
                fontSize: 16,
                  fontWeight: FontWeight.w400,fontFamily: 'Roboto',color: Colors.black
              ),
            ),
          ],
        ),
      );
    }),
  );
}