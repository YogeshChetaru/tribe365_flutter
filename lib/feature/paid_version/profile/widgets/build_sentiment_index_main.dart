import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/profile/controllers/profile_controller.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/images.dart';

class BuildSentimentIndexMain extends StatelessWidget {
  const BuildSentimentIndexMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileController>(
      builder: (context, profileProvider, child) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    profileProvider.updateSentimentIndexVisibleStatus();
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          getTranslated("sentiment_index", context)!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Roboto',
                            color: ColorResources.color333333,
                          ),
                        ),
                      ),
                      Image.asset(
                        profileProvider.isSentimentIndexVisible
                            ? Images.imgUpArrowRed
                            : Images.imgDownArrowRed,
                        width: 20,
                        height: 20,
                      )
                    ],
                  ),
                ),
                if (profileProvider.isSentimentIndexVisible)
                  profileProvider.viewHappyIndexMonthGraphList!.isNotEmpty?
                Column(
                  children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 300,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 100,
                          minY: 0,
                          barTouchData: BarTouchData(
                            enabled: true,
                            touchTooltipData: BarTouchTooltipData(
                              tooltipBgColor: const Color(0xFFEB1C24).withOpacity(0.7),
                              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                return BarTooltipItem(
                                  rod.toY.toStringAsFixed(1),
                                  const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                );
                              },
                            ),
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 42,
                                getTitlesWidget: (double value, TitleMeta meta) {
                                  final int index = value.toInt();
                                  if (index < 0 || index >= profileProvider.viewHappyIndexMonthGraphList!.length) {
                                    return const SizedBox.shrink();
                                  }
                                  final String monthName = profileProvider.viewHappyIndexMonthGraphList![index].monthName!;
                                  final String label = monthName.split(" ").first; // e.g., "Aug"
                                  return SideTitleWidget(
                                    axisSide: meta.axisSide,
                                    child: Text(
                                      label,
                                      style: const TextStyle(fontSize: 10),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 32,
                                interval: 20,
                                getTitlesWidget: (value, meta) {
                                  return Text('${value.toInt()}');
                                },
                              ),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          borderData: FlBorderData(show: true),
                          barGroups: profileProvider.viewHappyIndexMonthGraphList!.asMap().entries.map((entry) {
                            final int index = entry.key;
                            final item = entry.value;
                            final double yValue = double.tryParse(item.happy?.toString() ?? "0") ?? 0.0;

                            return BarChartGroupData(
                              x: index,
                              barRods: [
                                BarChartRodData(
                                  toY: yValue,
                                  color: ColorResources.mainColor,
                                  width: 18,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ],
                              showingTooltipIndicators: [],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: profileProvider.viewHappyIndexMonthGraphList!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                          child: Row(
                            children: [
                              Text('${index + 1} - ${profileProvider.viewHappyIndexMonthGraphList![index].monthName}'),
                              Spacer(),
                              Text('${double.parse(profileProvider.viewHappyIndexMonthGraphList![index].happy.toString()).toStringAsFixed(2)}%'),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ):
                  Center(child: Text(getTranslated("no_data_available", context)!)),
              ],
            ),
          ),
        );
      },
    );
  }
}
