import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/login/controllers/login_controller.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/dimensions.dart';
import 'package:tribe365_new/utill/images.dart';
import '../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocus = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    emailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 25,
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                color: Theme.of(context).primaryColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          Images.imgCircleBackWhite,
                          width: 30,
                          height: 30,
                        )),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 75,
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 50, 20, 10),
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                decoration: BoxDecoration(
                  color: ColorResources.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                ),
                child: SingleChildScrollView(
                  child: Consumer<LoginController>(builder: (context, loginProvider, _) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Image.asset(
                          Images.imgTribe365,
                          height: Dimensions.dp40,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          getTranslated("forgot_password2", context)!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: Dimensions.sp14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        Text(
                          getTranslated("enter_your_email_below_to_reset_your_password", context)!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: Dimensions.sp12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                            border: Border.all(color: ColorResources.color9a9a9a, width: 0.5),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                          ),
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Row(
                            children: [
                              Image.asset(
                                Images.imgMailBlack,
                                width: 18,
                                height: 18,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 1,
                                child: TextField(
                                  controller: emailController,
                                  focusNode: emailFocus,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.done,
                                  style: const TextStyle(
                                    fontSize: Dimensions.sp14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto',
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    hintText: getTranslated("email", context),
                                    hintStyle: const TextStyle(
                                      color: ColorResources.color9a9a9a,
                                      fontSize: Dimensions.sp14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        loginProvider.isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).primaryColor,
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  String email = emailController.text.toString().trim();
                                  if(email.isEmpty){
                                    showCustomSnackBar(getTranslated('please_enter_email_address', context), context,isError: true);
                                  }
                                  else if(!AppConstants.emailRegex.hasMatch(email)){
                                    showCustomSnackBar(getTranslated('please_enter_valid_email_address', context), context,isError: true);
                                  }
                                  else{
                                    loginProvider.forgotPassword(email);
                                  }
                                },
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width,
                                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
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
                          height: 12,
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
