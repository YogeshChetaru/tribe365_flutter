import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../utill/color_resources.dart';

LineChartData getLineChartData(List<double> data, List<String> labels) {
  return LineChartData(
    gridData: FlGridData(show: true),
    titlesData: FlTitlesData(
      leftTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: true, reservedSize: 30),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            int index = value.toInt();
            if (index >= 0 && index < labels.length) {
              return Text(labels[index], style: const TextStyle(fontSize: 10));
            }
            return const Text('');
          },
          reservedSize: 30,
          interval: 1,
        ),
      ),
    ),
    borderData: FlBorderData(show: true),
    minX: 0,
    maxX: (data.length - 1).toDouble(),
    minY: -6000,
    maxY: 1000,
    lineBarsData: [
      LineChartBarData(
        spots: List.generate(
          data.length,
              (index) => FlSpot(index.toDouble(), data[index]),
        ),
        isCurved: false,
        color: ColorResources.mainColor,
        barWidth: 2,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
      ),
    ],
  );
}