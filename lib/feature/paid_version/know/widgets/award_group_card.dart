import 'package:flutter/material.dart';

import '../../../../localization/language_constrants.dart';
import '../../../../utill/images.dart';
import '../controllers/know_controller.dart';
import '../domain/models/view_kudos_award_response.dart';

class AwardGroupCard extends StatelessWidget {
  final GroupKudosList group;
  final Function(String awardValue, List<ViewKudosAwardData> userList) onGroupTap;
  final KnowController knowController;
  const AwardGroupCard({
    super.key,
    required this.group,
    required this.onGroupTap,
    required this.knowController
  });

  @override
  Widget build(BuildContext context) {
    final first = group.kudosAwardLists.first;

    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          if (group.kudosAwardLists.length > 1) {
            onGroupTap(first.awardValue!, group.kudosAwardLists);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                first.awardDescription!,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              if (first.awardValue!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    first.awardValue!,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              const SizedBox(height: 8),
              Row(
                children: [
                  group.kudosAwardLists.length > 1?
                  Container(
                    width: 24.0,
                    height: 24.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(Images.imgGroupCircleRed),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ):
                  first.userImage==""?
                  Container(
                    width: 24.0,
                    height: 24.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(Images.imgUserCircleGray),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ):
                  Container(
                    width: 24.0,
                    height: 24.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(first.userImage!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      group.kudosAwardLists.length > 1
                          ? '${first.userName} & ${group.kudosAwardLists.length - 1} ${getTranslated("more", context)}'
                          : first.userName!,
                      style: const TextStyle(fontSize: 14),
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  knowController.getDate(first.awardDate!),
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}