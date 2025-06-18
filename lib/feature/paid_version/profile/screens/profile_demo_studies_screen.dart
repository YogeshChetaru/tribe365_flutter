import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../../../../common/basewidget/custom_header_back_widget.dart';
import '../../../../utill/dimensions.dart';
import '../../know/controllers/know_controller.dart';
import '../controllers/profile_controller.dart';
import '../widgets/build_chart_card.dart';

class ProfileDemoStudiesScreen extends StatefulWidget {
  const ProfileDemoStudiesScreen({super.key});

  @override
  ProfileDemoStudiesScreenState createState() => ProfileDemoStudiesScreenState();
}

class ProfileDemoStudiesScreenState extends State<ProfileDemoStudiesScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Consumer<ProfileController>(builder: (context, profileProvider, _) {
          return Consumer<KnowController>(builder: (context, knowProvider, _) {
            return Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              color: ColorResources.screenBg,
              child: Column(
                children: [
                  CustomHeaderBack(
                    title: "",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            decoration: BoxDecoration(
                              color: ColorResources.white,
                              boxShadow: [
                                BoxShadow(
                                  color: ColorResources.colorAAADC4,
                                  blurRadius: 3.0,
                                ),
                              ],
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                /*DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: knowProvider.officeSelectedValue,
                                    items: knowProvider.officeList.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(
                                            fontSize: Dimensions.sp14,
                                            color: ColorResources.black,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Roboto',
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      // knowProvider.updateOfficeSelectedValue(newValue);
                                    },
                                  ),
                                ),*/
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            decoration: BoxDecoration(
                              color: ColorResources.white,
                              boxShadow: [
                                BoxShadow(
                                  color: ColorResources.colorAAADC4,
                                  blurRadius: 3.0,
                                ),
                              ],
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                /*DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: knowProvider.departmentSelectedValue,
                                    items: knowProvider.departmentList.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(
                                            fontSize: Dimensions.sp14,
                                            color: ColorResources.black,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Roboto',
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      knowProvider.updateDepartmentSelectedValue(newValue);
                                    },
                                  ),
                                ),*/
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      child: SizedBox(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            BuildChartCard(title: 'Culture Index', data: profileProvider.cultureData, labels: profileProvider.cultureLabels),
                            SizedBox(
                              height: 15,
                            ),
                            BuildChartCard(title: 'Engagement Index', data: profileProvider.engagementData, labels: profileProvider.engagementLabels),
                            SizedBox(
                              height: 15,
                            ),
                            buildValuesAndBelief(),
                            SizedBox(
                              height: 15,
                            ),
                            buildTeamRoles(),
                            SizedBox(
                              height: 15,
                            ),
                            buildBarChart(profileProvider),
                            SizedBox(
                              height: 15,
                            ),
                            Card(
                              margin: const EdgeInsets.symmetric(horizontal: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(
                                      getTranslated("culture_structure", context)!,
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  buildCultureGrid(profileProvider),
                                  const SizedBox(height: 8),
                                  buildTitlesAndButton(profileProvider),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Card(
                              margin: const EdgeInsets.symmetric(horizontal: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(
                                      getTranslated("motivation", context)!,
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  buildMotivationBarChart(profileProvider),
                                  const SizedBox(height: 12),
                                  buildMotivationList(profileProvider),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Card(
                              margin: const EdgeInsets.symmetric(horizontal: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(
                                      getTranslated("diagnostics", context)!,
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  buildDiagnosticsBarChart(profileProvider),
                                  const SizedBox(height: 12),
                                  buildDiagnosticsList(profileProvider),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                                    decoration: BoxDecoration(
                                      color: ColorResources.white,
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorResources.colorAAADC4,
                                          blurRadius: 2.0,
                                        ),
                                      ],
                                    ),
                                    width: MediaQuery.sizeOf(context).width,
                                    padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                                    child: Text(
                                      getTranslated("REDO_REVIEW_QUESTIONNAIRE", context)!,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Card(
                              margin: const EdgeInsets.symmetric(horizontal: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(
                                      getTranslated("tribeometer", context)!,
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  buildTribeMeterBarChart(profileProvider),
                                  const SizedBox(height: 12),
                                  buildTribeMeterList(profileProvider),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                                    decoration: BoxDecoration(
                                      color: ColorResources.white,
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorResources.colorAAADC4,
                                          blurRadius: 2.0,
                                        ),
                                      ],
                                    ),
                                    width: MediaQuery.sizeOf(context).width,
                                    padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                                    child: Text(
                                      getTranslated("REDO_REVIEW_QUESTIONNAIRE", context)!,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Card(
                              margin: const EdgeInsets.symmetric(horizontal: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    child: SizedBox(
                                      width: MediaQuery.sizeOf(context).width,
                                      child: Text(
                                        getTranslated("sentiment_index", context)!,
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 300,
                                    child: BarChart(
                                      BarChartData(
                                        barGroups: profileProvider.sentimentValues.asMap().entries.map((entry) {
                                          final i = entry.key;
                                          final value = entry.value;
                                          return BarChartGroupData(
                                            x: i + 1,
                                            barRods: [
                                              BarChartRodData(
                                                toY: value,
                                                color: ColorResources.mainColor,
                                                width: 10,
                                              ),
                                            ],
                                            showingTooltipIndicators: [0],
                                          );
                                        }).toList(),
                                        titlesData: FlTitlesData(
                                          leftTitles: AxisTitles(
                                            sideTitles: SideTitles(showTitles: true, reservedSize: 35),
                                          ),
                                          bottomTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: true,
                                              getTitlesWidget: (value, _) {
                                                return Text('${value.toInt()}');
                                              },
                                            ),
                                          ),
                                        ),
                                        gridData: FlGridData(show: true),
                                        borderData: FlBorderData(show: true),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: profileProvider.sentimentValues.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                        child: Row(
                                          children: [
                                            Text('${index + 1} - ${profileProvider.months[index]}'),
                                            Spacer(),
                                            Text('${profileProvider.sentimentValues[index].toStringAsFixed(2)}%'),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        }),
      ),
    );
  }

  Widget buildValuesAndBelief() {
    List<Map<String, dynamic>> values = [
      {'title': 'ZERO WASTE', 'score': '4.5', 'border': true},
      {'title': 'STRAIGHT FORWARD', 'score': '4', 'border': true},
      {'title': 'Forward Thinking', 'score': '5.0', 'color': Color(0xFFEB1C24)},
      {'title': 'People Focused', 'score': '3.5', 'color': Colors.red.shade300},
      {'title': 'Direct', 'score': '4.0', 'color': Color(0xFFEB1C24)},
      {'title': 'Logical', 'score': '4.5', 'color': Color(0xFFEB1C24)},
    ];

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(getTranslated("values_and_belief", context)!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: values.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 2),
              itemBuilder: (context, index) {
                var item = values[index];
                return Container(
                  decoration: BoxDecoration(
                    color: item['border'] == true ? Colors.white : item['color'] as Color,
                    borderRadius: BorderRadius.circular(8),
                    border: item['border'] == true ? Border.all(color: ColorResources.mainColor) : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item['title'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: item['border'] == true ? FontWeight.w500 : FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['score'],
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTeamRoles() {
    List<Map<String, String>> roles = [
      {'left': 'Value Driver', 'leftValue': '100.00%', 'right': 'Deliberator', 'rightValue': '0.00%'},
      {'left': 'Resourcer', 'leftValue': '0.00%', 'right': 'Doer', 'rightValue': '0.00%'},
      {'left': 'Auditor', 'leftValue': '50.00%', 'right': 'Motivator', 'rightValue': '50.00%'},
      {'left': 'Specialist', 'leftValue': '100.00%', 'right': 'Pioneer', 'rightValue': '0.00%'},
    ];

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(getTranslated("team_role", context)!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Column(
              children: roles.map((role) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: ColorResources.mainColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              role['left']!,
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            const Spacer(),
                            Text(
                              role['leftValue']!,
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        width: 1,
                        height: 20,
                        color: ColorResources.white,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              role['right']!,
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            const Spacer(),
                            Text(
                              role['rightValue']!,
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildBarChart(ProfileController profileProvider) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(getTranslated("personality_type", context)!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            SizedBox(
              height: 250,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 100,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 28),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              (value.toInt() + 1).toString(),
                              style: const TextStyle(fontSize: 12),
                            ),
                          );
                        },
                      ),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: false),
                  barGroups: profileProvider.percentages.asMap().entries.map((entry) {
                    int index = entry.key;
                    double value = entry.value;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: value,
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
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.square, size: 14, color: ColorResources.mainColor),
                SizedBox(width: 4),
                Text(getTranslated("percentage", context)!, style: TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(height: 8),
            buildPersonalityTable(profileProvider),
          ],
        ),
      ),
    );
  }

  Widget buildPersonalityTable(ProfileController profileProvider) {
    return Column(
      children: List.generate(profileProvider.labels.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${index + 1} -  ${profileProvider.labels[index]}', style: const TextStyle(fontSize: 14)),
              Text('${profileProvider.percentages[index].toStringAsFixed(2)}%', style: const TextStyle(fontSize: 14)),
            ],
          ),
        );
      }),
    );
  }

  Widget buildCultureGrid(ProfileController profileProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GridView.builder(
        itemCount: profileProvider.cultureItems.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.5,
        ),
        itemBuilder: (context, index) {
          final item = profileProvider.cultureItems[index];
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                )
              ],
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 40,
                  decoration: BoxDecoration(
                    color: ColorResources.mainColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Text(
                    item['label']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  item['value']!,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildTitlesAndButton(ProfileController profileProvider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Text(
            textAlign: TextAlign.center,
            getTranslated("organisation_culture_structure", context)!,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          getTranslated("summary_of_organisation_culture_structure", context)!,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
          decoration: BoxDecoration(
            color: ColorResources.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: ColorResources.colorAAADC4,
                blurRadius: 2.0,
              ),
            ],
          ),
          width: MediaQuery.sizeOf(context).width,
          padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
          child: Text(
            getTranslated("REDO_REVIEW_QUESTIONNAIRE", context)!,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildMotivationBarChart(ProfileController profileProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: AspectRatio(
        aspectRatio: 1.7,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 100,
            barTouchData: BarTouchData(enabled: false),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    return Text('${value.toInt() + 1}');
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: FlBorderData(show: false),
            barGroups: profileProvider.motivationScores.asMap().entries.map((entry) {
              int index = entry.key;
              double value = entry.value;
              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: value,
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

  Widget buildMotivationList(ProfileController profileProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: List.generate(profileProvider.motivationScores.length, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Text(
                  '${index + 1} - ',
                  style: const TextStyle(fontSize: 16),
                ),
                Expanded(
                  child: Text(
                    profileProvider.motivationLabels[index],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  '${profileProvider.motivationScores[index].toStringAsFixed(1)}%',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget buildDiagnosticsBarChart(ProfileController profileProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: AspectRatio(
        aspectRatio: 1.7,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 100,
            barTouchData: BarTouchData(enabled: false),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    return Text('${value.toInt() + 1}');
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: FlBorderData(show: false),
            barGroups: profileProvider.diagnosticsScores.asMap().entries.map((entry) {
              int index = entry.key;
              double value = entry.value;
              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: value,
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

  Widget buildDiagnosticsList(ProfileController profileProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: List.generate(profileProvider.diagnosticsScores.length, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Text(
                  '${index + 1} - ',
                  style: const TextStyle(fontSize: 16),
                ),
                Expanded(
                  child: Text(
                    profileProvider.diagnosticsLabels[index],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  '${profileProvider.diagnosticsScores[index].toStringAsFixed(2)}%',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget buildTribeMeterBarChart(ProfileController profileProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: AspectRatio(
        aspectRatio: 1.7,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 100,
            barTouchData: BarTouchData(enabled: false),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    return Text('${value.toInt() + 1}');
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: FlBorderData(show: false),
            barGroups: profileProvider.tribeMeterScores.asMap().entries.map((entry) {
              int index = entry.key;
              double value = entry.value;
              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: value,
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

  Widget buildTribeMeterList(ProfileController profileProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: List.generate(profileProvider.tribeMeterScores.length, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Text(
                  '${index + 1} - ',
                  style: const TextStyle(fontSize: 16),
                ),
                Expanded(
                  child: Text(
                    profileProvider.tribeMeterLabels[index],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  '${profileProvider.tribeMeterScores[index].toStringAsFixed(2)}%',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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
