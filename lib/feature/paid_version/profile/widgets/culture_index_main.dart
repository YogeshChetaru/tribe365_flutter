import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tribe365_new/feature/paid_version/profile/controllers/profile_controller.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/images.dart';

import '../../../../localization/language_constrants.dart';
import '../../../../utill/dimensions.dart';
import 'culture_index_row.dart';

class CultureIndexMain extends StatelessWidget {
 final ProfileController profileProvider;

   const CultureIndexMain({
    super.key,
    required this.profileProvider
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: (){
                profileProvider.updateCultureStatus();
              },
              child: Row(
                children: [
                  Expanded(
                    flex: 1,child: Text(getTranslated("culture_index", context)!,
                        style:
                        const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Roboto', color: ColorResources.color333333)
                  ),
                  ),
                  Image.asset(profileProvider.isCultureVisible==true?Images.imgUpArrowRed:Images.imgDownArrowRed,width: 20,height: 20,)
                ],
              ),
            ),
            if(profileProvider.isCultureVisible)
            Column(
              children: [
                const SizedBox(height: 20),
                profileProvider.cultureIndexList == null
                    ? Center(child: Text(getTranslated("no_data_available", context)!))
                    : profileProvider.cultureIndexList!.isNotEmpty
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 350,
                      child: LineChart(
                          LineChartData(
                            minY: -2000,
                            maxY: 600,
                            gridData: FlGridData(show: false),
                            borderData: FlBorderData(
                              show: true,
                              border: const Border(
                                bottom: BorderSide(),
                                left: BorderSide(),
                              ),
                            ),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 400, // <- shows 400, 0, -400, etc.
                                  reservedSize: 45,
                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                      value.toInt().toString(),
                                      style: const TextStyle(fontSize: 10),
                                    );
                                  },
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 2, // <- shows alternate months
                                  getTitlesWidget: (value, meta) {
                                    final index = value.toInt();
                                    final label = profileProvider.cultureIndexLabels[index];
                                    return SideTitleWidget(
                                      axisSide: meta.axisSide,
                                      child: Text(
                                        label ?? '',
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false), // Hides top X axis
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false), // Hides right Y axis
                              ),
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                spots: profileProvider.cultureIndexSpots,
                                isCurved: false,
                                color: Colors.red,
                                barWidth: 3,
                                isStrokeCapRound: true,
                                dotData: FlDotData(
                                  show: true,
                                  getDotPainter: (spot, percent, barData, index) {
                                    return FlDotCirclePainter(
                                      radius: 6,
                                      color: Colors.white,
                                      strokeWidth: 3,
                                      strokeColor: Colors.red,
                                    );
                                  },
                                ),
                                belowBarData: BarAreaData(show: false),
                              ),
                            ],
                            showingTooltipIndicators: List.generate(
                              profileProvider.cultureIndexList!.length,
                                  (index) => ShowingTooltipIndicators([
                                LineBarSpot(
                                  LineChartBarData(spots: profileProvider.cultureIndexSpots),
                                  0,
                                  profileProvider.cultureIndexSpots[index],
                                ),
                              ]),
                            ),
                            lineTouchData: LineTouchData(
                              enabled: false,
                              touchTooltipData: LineTouchTooltipData(
                                tooltipBgColor: Colors.transparent,
                                tooltipPadding: EdgeInsets.zero,
                                tooltipMargin: 4,
                                getTooltipItems: (spots) {
                                  return spots.map((spot) {
                                    return LineTooltipItem(
                                      '${spot.y.toInt()}',
                                      const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }).toList();
                                },
                              ),
                            ),
                          )

                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text("-${getTranslated("month", context)}",
                          style: TextStyle(fontSize: Dimensions.sp12, color: ColorResources.mainColor)),
                    ),
                    SizedBox(height: 20,),
                    ListView.builder(
                      itemCount: profileProvider.cultureIndexList!.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = profileProvider.cultureIndexList![index];

                        // Calculate alpha based on rank
                        double alpha = 0.0;
                        for (int i = 0; i < profileProvider.sortedUniqueScores.length; i++) {
                          if (profileProvider.sortedUniqueScores[i] == item.data) {
                            alpha = (0.2 * (i + 1)).clamp(0.0, 1.0);
                            break;
                          }
                        }

                        return CultureIndexRow(
                          index: index,
                          title: item.monthName!,
                          score: item.data!,
                          alpha: alpha,
                        );
                      },
                    )
                  ],
                )
                    : Center(child: Text(getTranslated("no_data_available", context)!)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
