import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/dimensions.dart';
import '../controllers/profile_controller.dart';

class BuildChartCard extends StatefulWidget {
  final String title;
  final List<double> data;
  final List<String> labels;

  const BuildChartCard({super.key, required this.title, required this.data, required this.labels});

  @override
  State<BuildChartCard> createState() => _BuildChartCardState();
}

class _BuildChartCardState extends State<BuildChartCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileController>(builder: (context, profileController, _) {
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Roboto', color: ColorResources.color333333)),
              const SizedBox(height: 12),
              SizedBox(
                height: 300,
                child: LineChart(getLineChartData(widget.data, widget.labels)),
              ),
              const SizedBox(height: 8),
              Text(getTranslated("month", context)!, style: TextStyle(fontSize: Dimensions.sp12, color: ColorResources.mainColor)),
            ],
          ),
        ),
      );
    });
  }

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
}
