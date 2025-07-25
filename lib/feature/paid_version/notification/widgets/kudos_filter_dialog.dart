import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/notification/controllers/notification_controller.dart';
import 'package:tribe365_new/feature/paid_version/notification/screens/notification_awards_screen.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/custom_route.dart';
import 'package:tribe365_new/utill/images.dart';

import '../domain/models/view_home_kudos_count_response.dart';
import 'home_belief_item.dart';

class KudosFilterDialog extends StatelessWidget {
  final List<ViewHomeKudosCountBelief> kudosList;
  final String amazingValueKey;
  final int todayAwardCount;
  final int yesterdayAwardCount;
  final int thisWeekAwardCount;
  final int lastWeekAwardCount;
  final int thisMonthAwardCount;
  final int lastMonthAwardCount;
  final int totalAwardCount;

  const KudosFilterDialog({
    super.key,
    required this.kudosList,
    required this.amazingValueKey,
    required this.todayAwardCount,
    required this.yesterdayAwardCount,
    required this.thisWeekAwardCount,
    required this.lastWeekAwardCount,
    required this.thisMonthAwardCount,
    required this.lastMonthAwardCount,
    required this.totalAwardCount,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationController>(
      builder: (context, provider, _) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 5,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: ColorResources.color9a9a9a.withAlpha(51),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back),
                                  onPressed: provider.goPreviousTop,
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      provider.currentTopTitle,
                                      style: const TextStyle(
                                        color: ColorResources.mainColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.arrow_forward),
                                  onPressed: provider.goNextTop,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back),
                                  onPressed: () {
                                    provider.goPreviousTitle();
                                    provider.updateAmazingValue(
                                      today: todayAwardCount,
                                      yesterday: yesterdayAwardCount,
                                      thisWeek: thisWeekAwardCount,
                                      lastWeek: lastWeekAwardCount,
                                      thisMonth: thisMonthAwardCount,
                                      lastMonth: lastMonthAwardCount,
                                      total: totalAwardCount,
                                    );
                                  },
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      provider.currentTitle,
                                      style: const TextStyle(
                                        color: ColorResources.mainColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.arrow_forward),
                                  onPressed: () {
                                    provider.goNextTitle();
                                    provider.updateAmazingValue(
                                      today: todayAwardCount,
                                      yesterday: yesterdayAwardCount,
                                      thisWeek: thisWeekAwardCount,
                                      lastWeek: lastWeekAwardCount,
                                      thisMonth: thisMonthAwardCount,
                                      lastMonth: lastMonthAwardCount,
                                      total: totalAwardCount,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: kudosList.length,
                        itemBuilder: (context, index) {
                          ViewHomeKudosCountBelief item = kudosList[index];
                          return HomeBeliefItem(
                            item: item,
                            showText: provider.currentTitle,
                            topTitle: provider.currentTopTitle,
                          );
                        },
                      ),
                      if (provider.isKudosAwards)
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: ColorResources.mainColor,
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  amazingValueKey,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16
                                  ),
                                ),
                              ),
                              Text(
                                provider.amazingValue,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                if (provider.isKudosAwards)
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      routePush(context, NotificationAwardsScreen());
                    },
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.only(top: 12),
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Images.imgAwardsCircleRed),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
