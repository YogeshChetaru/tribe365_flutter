import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/home/controllers/home_controller.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/dimensions.dart';

class HomeOutOfficeModeDialog extends StatefulWidget {
  const HomeOutOfficeModeDialog({super.key});

  @override
  State<HomeOutOfficeModeDialog> createState() => _HomeOutOfficeModeDialogState();
}

class _HomeOutOfficeModeDialogState extends State<HomeOutOfficeModeDialog> {
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
                getTranslated("ready_to_resume_work", context)!,
                style: TextStyle(
                  fontSize: Dimensions.sp16,
                  color: ColorResources.black, // Replace with ColorResources.mainColor
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              dashboardProvider.isPopupLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        dashboardProvider.userChangeLeaveStatus();
                      },
                      child: Container(
                        width: 120,
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        decoration: BoxDecoration(
                          color: ColorResources.mainColor,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                        ),
                        child: Text(
                          getTranslated("DISABLE", context)!,
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
