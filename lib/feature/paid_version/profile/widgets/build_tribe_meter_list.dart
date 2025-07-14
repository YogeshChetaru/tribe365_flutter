import 'package:flutter/material.dart';

import '../controllers/profile_controller.dart';
import '../domain/models/view_studies_list_response.dart';

Widget buildTribeMeterList(ProfileController profileProvider) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      children: List.generate(profileProvider.getTribeMeterReportList!.length, (index) {
        GetCOTpersonalityType data =  profileProvider.getTribeMeterReportList![index];
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
                  style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400,fontFamily: 'Roboto',color: Colors.black),
                ),
              ),
              Text(
                '${data.percentage!.toStringAsFixed(2)}%',
                style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400,fontFamily: 'Roboto',color: Colors.black),
              ),
            ],
          ),
        );
      }),
    ),
  );
}