import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/dimensions.dart';

import '../../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../../utill/images.dart';
import '../../../../utill/utility.dart';
import '../controllers/home_controller.dart';

class HomeWorkNotDialog extends StatelessWidget {
  const HomeWorkNotDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(builder: (context, dashboardProvider, _) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                getTranslated("please_select_the_dates_you_aim_to_be_back_at_work", context)!,
                style: TextStyle(
                  fontSize: Dimensions.sp16,
                  color: ColorResources.mainColor,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  dashboardProvider.pickStartDate(context, "start");
                },
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorResources.color9a9a9a, width: 0.5),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                  ),
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${getTranslated("start_date", context)!}:",
                        style: TextStyle(fontSize: Dimensions.sp14, color: ColorResources.black, fontFamily: 'Roboto', fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          textAlign: TextAlign.center,
                          dashboardProvider.selectedStartDate,
                          style: TextStyle(fontSize: Dimensions.sp14, color: ColorResources.black, fontFamily: 'Roboto', fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        Images.imgCalenderGray,
                        width: 18,
                        height: 22,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  dashboardProvider.pickStartDate(context, "end");
                },
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorResources.color9a9a9a, width: 0.5),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                  ),
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${getTranslated("end_date", context)!}:",
                        style: TextStyle(fontSize: Dimensions.sp14, color: ColorResources.black, fontFamily: 'Roboto', fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          textAlign: TextAlign.center,
                          dashboardProvider.selectedEndDate,
                          style: TextStyle(fontSize: Dimensions.sp14, color: ColorResources.black, fontFamily: 'Roboto', fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        Images.imgCalenderGray,
                        width: 18,
                        height: 22,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () {
                  if(dashboardProvider.selectedEndDate==""){
                    showCustomSnackBar(getTranslated('please_select_end_date', context), context,isError: true);
                  }
                  else{
                    final start = Utility.changeDateDMYtoYMD(dashboardProvider.selectedStartDate);
                    final end = Utility.changeDateDMYtoYMD(dashboardProvider.selectedEndDate);

                    Provider.of<HomeController>(context,listen: false).userApplyLeave(start,end);
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  width: 120,
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                  decoration: BoxDecoration(
                    color: ColorResources.mainColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                  ),
                  child: Text(
                    getTranslated("submit", context)!,
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
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      );
    });
  }
}
