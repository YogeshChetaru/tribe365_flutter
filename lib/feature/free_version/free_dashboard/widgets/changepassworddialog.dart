import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/dimensions.dart';

import '../../../../utill/images.dart';
import '../controllers/free_dashboard_controller.dart';

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({super.key});

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confPasswordController = TextEditingController();
  final FocusNode currentPasswordFocus = FocusNode();
  final FocusNode newPasswordFocus = FocusNode();
  final FocusNode confPasswordFocus = FocusNode();

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confPasswordController.dispose();
    currentPasswordFocus.dispose();
    newPasswordFocus.dispose();
    confPasswordFocus.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<FreeDashboardController>(builder: (context, dashboardProvider, _) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                getTranslated("change_password", context)!,
                style: TextStyle(
                  fontSize: Dimensions.sp16,
                  color: ColorResources.mainColor, // Replace with ColorResources.mainColor
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  border: Border.all(color: ColorResources.color9a9a9a, width: 0.5),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                ),
                padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      Images.imgPasswordBlack,
                      width: 18,
                      height: 18,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: TextField(
                        textAlign: TextAlign.start,
                        controller: currentPasswordController,
                        focusNode: currentPasswordFocus,
                        obscureText: dashboardProvider.obscureCurrentPasswordText,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction:TextInputAction.next,
                        style: const TextStyle(
                          fontSize: Dimensions.sp14,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Roboto',
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          hintText: getTranslated("current_password", context),
                          hintStyle: const TextStyle(
                            color: ColorResources.color9a9a9a,
                            fontSize: Dimensions.sp14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        dashboardProvider.obscureCurrentPasswordText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: dashboardProvider.toggleCurrentPasswordVisibility,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  border: Border.all(color: ColorResources.color9a9a9a, width: 0.5),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                ),
                padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      Images.imgPasswordBlack,
                      width: 18,
                      height: 18,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: TextField(
                        textAlign: TextAlign.start,
                        controller: newPasswordController,
                        focusNode: newPasswordFocus,
                        obscureText: dashboardProvider.obscureNewPasswordText,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction:TextInputAction.next,
                        style: const TextStyle(
                          fontSize: Dimensions.sp14,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Roboto',
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          hintText: getTranslated("new_password", context),
                          hintStyle: const TextStyle(
                            color: ColorResources.color9a9a9a,
                            fontSize: Dimensions.sp14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        dashboardProvider.obscureNewPasswordText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: dashboardProvider.toggleNewPasswordVisibility,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  border: Border.all(color: ColorResources.color9a9a9a, width: 0.5),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                ),
                padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      Images.imgPasswordBlack,
                      width: 18,
                      height: 18,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: TextField(
                        textAlign: TextAlign.start,
                        controller: confPasswordController,
                        focusNode: confPasswordFocus,
                        obscureText: dashboardProvider.obscureConfPasswordText,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction:TextInputAction.done,
                        style: const TextStyle(
                          fontSize: Dimensions.sp14,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Roboto',
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          hintText: getTranslated("confirm_password", context),
                          hintStyle: const TextStyle(
                            color: ColorResources.color9a9a9a,
                            fontSize: Dimensions.sp14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        dashboardProvider.obscureConfPasswordText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: dashboardProvider.toggleConfPasswordVisibility,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 120,
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                  decoration: BoxDecoration(
                    color: ColorResources.mainColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                  ),
                  child: Text(
                    getTranslated("save", context)!,
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
