import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../utill/color_resources.dart';
import '../controllers/profile_controller.dart';
import '../domain/models/view_studies_list_response.dart';

Widget buildTribeMeterBarChart(ProfileController profileProvider) {
  final reportList = profileProvider.getTribeMeterReportList ?? [];

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
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 42,
                getTitlesWidget: (double value, TitleMeta meta) {
                  final int index = value.toInt();
                  if (index < 0 || index >= reportList.length) {
                    return const SizedBox.shrink();
                  }
                  final String label = reportList[index].title ?? '${index + 1}';
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
          barGroups: reportList.asMap().entries.map((entry) {
            final int index = entry.key;
            final GetCOTpersonalityType report = entry.value;

            // Safe parsing if needed
            final double yValue = report.percentage ?? 0.0;

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
  );
}

