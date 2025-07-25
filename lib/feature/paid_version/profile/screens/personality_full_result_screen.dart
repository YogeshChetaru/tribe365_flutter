import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/profile/screens/update_personality_questions_screen.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/custom_route.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../controllers/profile_controller.dart';
import '../domain/models/view_personality_type_report_response.dart';

class PersonalityFullResultScreen extends StatefulWidget {


  const PersonalityFullResultScreen({super.key,});

  @override
  PersonalityFullResultScreenState createState() => PersonalityFullResultScreenState();
}

class PersonalityFullResultScreenState extends State<PersonalityFullResultScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    loadAPI();
  }

  void loadAPI() {
    ProfileController controller = Provider.of<ProfileController>(context, listen: false);
    controller.viewPersonalityTypeReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child:
            Consumer<ProfileController>(builder: (context, profileProvider, _) {
          return Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            color: ColorResources.screenBg,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: ColorResources.white,
                    boxShadow: [
                      BoxShadow(
                        color: ColorResources.colorAAADC4,
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  width: MediaQuery.sizeOf(context).width,
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop(true);
                          },
                          child: Image.asset(
                            Images.imgCircleBackRed,
                            width: 24,
                            height: 24,
                          )),
                      Expanded(
                          child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          getTranslated("personality_type_result", context)!,
                          style: TextStyle(
                            fontSize: Dimensions.sp18,
                            fontWeight: FontWeight.w600,
                            color: ColorResources.black,
                          ),
                        ),
                      )),
                      SizedBox(
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: profileProvider.isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Card(
                                  margin: const EdgeInsets.all(10),
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 16),
                                        AspectRatio(
                                          aspectRatio: 1.5,
                                          child: BarChart(
                                            BarChartData(
                                              alignment: BarChartAlignment.spaceAround,
                                              maxY: 100,
                                              minY: 0,
                                              groupsSpace: 12,
                                              gridData: FlGridData(
                                                show: true,
                                                drawVerticalLine: false,
                                                getDrawingHorizontalLine: (value) {
                                                  return FlLine(
                                                    color: Colors.grey.withAlpha(77),
                                                    strokeWidth: 0.5,
                                                    dashArray: [4,4],
                                                  );
                                                },
                                              ),
                                              borderData: FlBorderData(
                                                show: true,
                                                border: const Border(
                                                  left: BorderSide(color: Colors.grey, width: 1),
                                                  bottom: BorderSide(color: Colors.grey, width: 1),
                                                ),
                                              ),
                                              barTouchData: BarTouchData(
                                                enabled: true,
                                                touchTooltipData: BarTouchTooltipData(
                                                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                                    return BarTooltipItem(
                                                      '${rod.toY.toInt()}',
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
                                                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                                leftTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                    showTitles: true,
                                                    reservedSize: 28,
                                                    interval: 20,
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
                                                    getTitlesWidget: (value, meta) {
                                                      final index = value.toInt();
                                                      if (index >= 0 && index < profileProvider.viewPersonalityTypeReportList!.length) {
                                                        return Text(
                                                          '${index + 1}',
                                                          style: const TextStyle(fontSize: 12),
                                                        );
                                                      }
                                                      return const SizedBox.shrink();
                                                    },
                                                  ),
                                                ),
                                              ),
                                              barGroups: profileProvider.viewPersonalityTypeReportList!.asMap().entries.map((entry) {
                                                final index = entry.key;
                                                final score = double.tryParse(entry.value.score!) ?? 0;
                                                return BarChartGroupData(
                                                  x: index,
                                                  barRods: [
                                                    BarChartRodData(
                                                      toY: score,
                                                      color: ColorResources.mainColor,
                                                      width: 20,
                                                      borderRadius: BorderRadius.circular(4),
                                                      rodStackItems: [
                                                        BarChartRodStackItem(
                                                          0,
                                                          score,
                                                          ColorResources.mainColor,
                                                          BorderSide.none,

                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              }).toList(),
                                            ),
                                            swapAnimationDuration:
                                                const Duration(
                                                    milliseconds: 1500),
                                            swapAnimationCurve:
                                                Curves.easeOutCubic,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                                  decoration: BoxDecoration(
                                      color: ColorResources.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorResources.colorAAADC4,
                                          blurRadius: 5.0,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: profileProvider
                                        .viewPersonalityTypeReportList!.length,
                                    separatorBuilder: (_, __) => Divider(
                                      height: 0.5,
                                      color: Colors.grey.shade400,
                                    ),
                                    itemBuilder: (context, index) {
                                      ViewPersonalityTypeReportData item = profileProvider.viewPersonalityTypeReportList![index];
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        child: Row(
                                          children: [
                                            // Number
                                            SizedBox(
                                              child: Text(
                                                '${index + 1} -',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontFamily: 'Roboto',
                                                  color: Color(0xFF333333),
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            // Title
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                child: Text(
                                                  item.title ?? '',
                                                  style: const TextStyle(
                                                    fontFamily: 'Roboto',
                                                    color: Color(0xFF333333),
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // Score
                                            Container(
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(8),
                                              child: Text(
                                                item.score ?? '',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontFamily: 'Roboto',
                                                  color: Color(0xFF333333),
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    routePush(context, PersonalityQuestionsUpdateScreen());
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(15, 20, 15, 15),
                                    width: MediaQuery.sizeOf(context).width,
                                    padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                                    decoration: BoxDecoration(
                                      color: ColorResources.mainColor,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    child: Text(
                                      getTranslated("REDO_REVIEW_QUESTIONNAIRE",
                                          context)!,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: Dimensions.sp16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
