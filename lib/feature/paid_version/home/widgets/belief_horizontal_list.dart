import 'package:flutter/material.dart';
import 'package:tribe365_new/feature/paid_version/home/controllers/home_controller.dart';

import '../../../../localization/language_constrants.dart';
import '../domain/models/view_dot_details_response.dart';
import 'belief_vertical_list.dart';
import 'open_link_dialog.dart';

class BeliefHorizontalList extends StatelessWidget {
  final List<Belief> beliefs;
  final HomeController controller;

  const BeliefHorizontalList({
    required this.beliefs,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // <-- optional, for Row children
        children: beliefs.map((belief) {
          return Container(
            width: 100,
            margin: const EdgeInsets.only(right: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    openLinkDialog(
                      context,
                      title: getTranslated("belief", context)!,
                      subTitle: belief.name ?? '',
                      description: belief.beliefDesc ?? '',
                      videoURL: belief.beliefUrl ?? '',
                    );
                  },
                  child: Container(
                    height: 60,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        belief.name ?? '',
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto",
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                BeliefVerticalList(
                  beliefValues: belief.beliefValue ?? [],
                  role: "3",
                  controller: controller,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
