import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tribe365_new/feature/paid_version/profile/controllers/profile_controller.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/images.dart';

class BuildPersonalityTypeMain extends StatelessWidget {
  final ProfileController profileProvider;

  const BuildPersonalityTypeMain({super.key, required this.profileProvider});

  @override
  Widget build(BuildContext context) {
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
                profileProvider.updatePersonalityTypeVisibleStatus();
              },
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      getTranslated("personality_type", context)!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Roboto',
                        color: ColorResources.color333333,
                      ),
                    ),
                  ),
                  Image.asset(
                    profileProvider.isPersonalityTypeVisible
                        ? Images.imgUpArrowRed
                        : Images.imgDownArrowRed,
                    width: 20,
                    height: 20,
                  )
                ],
              ),
            ),
            if (profileProvider.isPersonalityTypeVisible) ...[
              const SizedBox(height: 25),
              profileProvider.personalityTypes.isEmpty?
              Center(child: Text(getTranslated("no_data_available", context)!)):
              Column(
                children: [
                  SizedBox(
                    height: 250,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 100,
                        barTouchData: BarTouchData(
                          enabled: true,
                          touchTooltipData: BarTouchTooltipData(
                            tooltipBgColor: Color(0xFFEB1C24).withOpacity(0.7),
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              return BarTooltipItem(
                                '${rod.toY.toStringAsFixed(1)}%',
                                TextStyle(
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
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true, reservedSize: 28),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                final index = value.toInt();
                                if (index >= 0 && index < profileProvider.personalityTypes.length) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      profileProvider.personalityTypes[index].title!,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ),
                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        gridData: FlGridData(show: true),
                        borderData: FlBorderData(show: true),
                        barGroups: profileProvider.personalityTypes.asMap().entries.map((entry) {
                          final index = entry.key;
                          final value = entry.value.percentage;
                          return BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                toY: value!,
                                color: ColorResources.mainColor,
                                width: 18,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.square, size: 14, color: ColorResources.mainColor),
                      SizedBox(width: 4),
                      Text(
                        getTranslated("percentage", context)!,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: profileProvider.personalityTypes.length,
                    itemBuilder: (context, index) {
                      final item = profileProvider.personalityTypes[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${index + 1} -  ${item.title!}', style: const TextStyle(fontSize: 14)),
                            Text('${item.percentage!.toStringAsFixed(2)}%', style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
