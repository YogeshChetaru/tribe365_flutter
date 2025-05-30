import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/free_version/free_dashboard/controllers/free_dashboard_controller.dart';
import 'package:tribe365_new/feature/free_version/free_dashboard/widgets/builddaytext.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/images.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/dimensions.dart';

class FreeDashboardScreen extends StatefulWidget {
  const FreeDashboardScreen({super.key});

  @override
  FreeDashboardScreenState createState() => FreeDashboardScreenState();
}

class FreeDashboardScreenState extends State<FreeDashboardScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Consumer<FreeDashboardController>(builder: (context, dashboardProvider, _) {
          return Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            color: ColorResources.screenBg,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: ColorResources.mainColor, width: 1),
                            image: DecorationImage(
                              image: AssetImage(Images.imgTribe365),

                            ),
                          ),
                        ),
                        Expanded(flex: 1,child: SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Yogesh Kahar",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: Dimensions.sp16,
                                  color: ColorResources.mainColor,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Roboto',
                                ),),
                              Text("Yogesh@chetaru.com",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: Dimensions.sp14,
                                  color: ColorResources.color9a9a9a,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Roboto',
                                ),),
                              Text("Apps, Central office",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: Dimensions.sp14,
                                  color: ColorResources.black,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Roboto',
                                ),),

                            ],
                          ),
                        ),),
                        Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(Images.imgRedMenuDot,width: 24,height: 24,),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: 0.5,
                    color:Colors.black.withAlpha((0.4 * 255).toInt()),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                    width: MediaQuery.sizeOf(context).width,
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ColorResources.mainColor,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(getTranslated("how_s_things_at_work_today", context)!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: Dimensions.sp16,
                            color: ColorResources.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto',
                          ),),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: SizedBox(
                                width: 55,
                                height: 55,
                                child: Image.asset(
                                  Images.imgHappyEmoji, // Ensure this path matches your asset setup
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(width: 20,),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: SizedBox(
                                width: 55,
                                height: 55,
                                child: Image.asset(
                                  Images.imgNeutralEmoji, // Ensure this path matches your asset setup
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(width: 20,),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: SizedBox(
                                width: 55,
                                height: 55,
                                child: Image.asset(
                                  Images.imgSadEmoji, // Ensure this path matches your asset setup
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),


                          ],
                        ),
                        SizedBox(height: 10,),
                        Text(getTranslated("i_m_not_in_work_today", context)!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: Dimensions.sp16,
                            color: ColorResources.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto',
                            decoration: TextDecoration.underline,
                            decorationColor: ColorResources.white,
                          ),),

                      ],
                    ),

                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                    width: MediaQuery.sizeOf(context).width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(getTranslated("sentiment_index", context)!,
                          style: const TextStyle(
                            fontSize: Dimensions.sp18,
                            color: ColorResources.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Roboto',
                          ),),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        value: dashboardProvider.officeSelectedValue,
                                        items: dashboardProvider.officeList.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value,style: const TextStyle(
                                              fontSize: Dimensions.sp14,
                                              color: ColorResources.black,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Roboto',
                                            ),),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          dashboardProvider.updateOfficeSelectedValue(newValue);
                                        },
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 15,),
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        value: dashboardProvider.departmentSelectedValue,
                                        items: dashboardProvider.departmentList.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value,style: const TextStyle(
                                              fontSize: Dimensions.sp14,
                                              color: ColorResources.black,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Roboto',
                                            ),),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          dashboardProvider.updateDepartmentSelectedValue(newValue);
                                        },
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15,),
                        Container(
                          width: MediaQuery.sizeOf(context).width,
                          color: ColorResources.white,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          value: dashboardProvider.monthSelectedValue,
                                          items: dashboardProvider.monthList.map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value,style: const TextStyle(
                                                fontSize: Dimensions.sp14,
                                                color: ColorResources.black,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Roboto',
                                              ),),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            dashboardProvider.updateMonthSelectedValue(newValue);
                                          },
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 30,),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          value: dashboardProvider.yearSelectedValue,
                                          items: dashboardProvider.yearList.map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value,style: const TextStyle(
                                                fontSize: Dimensions.sp14,
                                                color: ColorResources.black,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Roboto',
                                              ),),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            dashboardProvider.updateYearSelectedValue(newValue);
                                          },
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15,),
                        Column(
                          children: [
                            Row(
                              children: [
                                BuildDayText(day: getTranslated("sun", context)!, color: ColorResources.mainColor), // colorPrimary
                                BuildDayText(day: getTranslated("mon", context)!,color: Colors.black,),
                                BuildDayText(day: getTranslated("tue", context)!,color: Colors.black,),
                                BuildDayText(day: getTranslated("wed", context)!,color: Colors.black,),
                                BuildDayText(day: getTranslated("thu", context)!,color: Colors.black,),
                                BuildDayText(day: getTranslated("fri", context)!,color: Colors.black,),
                                BuildDayText(day: getTranslated("sat", context)!, color: ColorResources.mainColor),
                              ],
                            ),
                            SizedBox(height: 10,),
                            GridView.builder(
                              physics: NeverScrollableScrollPhysics(), // disables scrolling
                              shrinkWrap: true,
                              itemCount:dashboardProvider.calendarData.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 7,
                                mainAxisSpacing: 2,
                                crossAxisSpacing: 2,
                                childAspectRatio: 0.8,
                              ),
                              itemBuilder: (context, index) {
                                final data = dashboardProvider.calendarData[index];
                                final day = data['day'];
                                final mood = data['mood'];
                                final isWeekend = index % 7 == 0 || index % 7 == 6;
                                return Container(
                                  decoration: BoxDecoration(
                                    color: ColorResources.white,
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        day,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: isWeekend ? ColorResources.mainColor : Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        dashboardProvider.getEmoji(mood),
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),


                          ],
                        ),


                      ],
                    ),

                  ),

                ],
              ),
            ),
          );
        }),
      ),
      bottomNavigationBar: Container(
        height: 50,
        alignment: Alignment.center,
        width: MediaQuery.sizeOf(context).width,
        color: ColorResources.mainColor,
        child:  Text(getTranslated("hptm", context)!,
          style: const TextStyle(
            fontSize: Dimensions.sp18,
            color: ColorResources.white,
            fontWeight: FontWeight.w600,
            fontFamily: 'Roboto',
          ),),
      ),
    );
  }
}



