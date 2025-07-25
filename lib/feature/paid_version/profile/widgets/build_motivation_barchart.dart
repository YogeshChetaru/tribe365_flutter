import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../utill/color_resources.dart';
import '../controllers/profile_controller.dart';
import '../domain/models/view_studies_list_response.dart';

Widget buildMotivationBarChart(ProfileController profileProvider) {
  final reportList = profileProvider.viewSOTMotivationReportList ?? [];

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: AspectRatio(
      aspectRatio: 1.7,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 100,
          minY: 0,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: Color(0xFFEB1C24).withAlpha(179),
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
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      '${value.toInt() + 1}', // index + 1
                      style: const TextStyle(fontSize: 12),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 10,
                getTitlesWidget: (double value, TitleMeta meta) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Text(
                      value.toInt().toString(),
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                },
              ),
            ),

            // Hide right and top titles
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(show: true),
          barGroups: reportList.asMap().entries.map((entry) {
            int index = entry.key;
            ModelMotivationGraph item = entry.value;
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: double.parse(item.score.toString()),
                  color: ColorResources.mainColor,
                  width: 16,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
              showingTooltipIndicators: [],
            );
          }).toList(),
        ),
      ),
    ),
  );
}
