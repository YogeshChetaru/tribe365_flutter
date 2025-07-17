import 'package:flutter/material.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/utility.dart';

import '../domain/models/view_kudos_award_detail_response.dart';

class NotificationKudosAwardItem extends StatefulWidget {
  final ViewKudosAwardDetailData award;


  const NotificationKudosAwardItem({
    super.key,
    required this.award,
  });

  @override
  NotificationKudosAwardState createState() => NotificationKudosAwardState();
}

class NotificationKudosAwardState extends State<NotificationKudosAwardItem> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final award = widget.award;
    return Card(

      margin: EdgeInsets.fromLTRB(15, 5, 15, 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      award.dotName!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    award.awardCount.toString(),
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(width: 5,),
                InkWell(
                  onTap: award.dotValAward!.isNotEmpty
                      ? () {
                    setState(() {
                      expanded = !expanded;
                    });
                  }
                      : null,
                  child: Icon(
                    expanded
                        ? Icons.expand_less
                        : (award.dotValAward!.isNotEmpty
                        ? Icons.expand_more
                        : Icons.expand_more_outlined),
                    color: award.dotValAward!.isNotEmpty
                        ? ColorResources.mainColor
                        : Colors.grey,
                  ),
                )
              ],
            ),
            if (expanded)
              Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: award.dotValAward!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(award.dotValAward![index].description!),
                            Container(
                              alignment: Alignment.centerRight,
                              width: MediaQuery.sizeOf(context).width,
                                child: Text(Utility.convertDataIntoddMMMyyyyhhmma(award.dotValAward![index].createdAt!)))
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
