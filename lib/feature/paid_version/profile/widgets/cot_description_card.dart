import 'package:flutter/material.dart';
import 'package:tribe365_new/localization/language_constrants.dart';

import '../domain/models/view_cot_mapper_summary_response.dart';

class CotDescriptionCard extends StatelessWidget {
  final ViewCotMapperSummaryData item;

  const CotDescriptionCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: "${getTranslated("title", context)!}: ",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: item.title ?? ''),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: "${getTranslated("value", context)!}: ",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: item.shortDescription ?? ''),
                ],
              ),
            ),
            if ((item.longDescription ?? '').isNotEmpty)
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text: "${getTranslated("description", context)!}: ",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: (item.longDescription ?? '').replaceAll('\n', '\n'),
                    ),
                  ],
                ),
              ),

          ],
        ),
      ),
    );
  }
}
