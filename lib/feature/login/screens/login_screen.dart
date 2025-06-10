import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/login/controllers/login_controller.dart';
import 'package:tribe365_new/feature/login/screens/forgot_password_screen.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/app_constants.dart';
import 'package:tribe365_new/utill/custom_route.dart';
import 'package:tribe365_new/utill/dimensions.dart';
import 'package:tribe365_new/utill/images.dart';
import '../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../utill/color_resources.dart';
import '../widgets/helpdialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confPasswordController = TextEditingController();
  final FocusNode usernameFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confPasswordFocus = FocusNode();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confPasswordController.dispose();
    usernameFocus.dispose();
    passwordFocus.dispose();
    confPasswordFocus.dispose();
    super.dispose();
  }
  @override
  void initState() {
   Provider.of<LoginController>(context,listen: false).getDeviceToken();
    super.initState();
  }

  void showAnimatedDialog(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        barrierColor: Colors.black54,
        pageBuilder: (context, animation, secondaryAnimation) {
          return const Center(child: HelpDialog());
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // From right
          const end = Offset(-1.0, 0.0); // To left when popping
          final tween = Tween(begin: begin, end: Offset.zero);
          final reverseTween = Tween(begin: Offset.zero, end: end);
          final offsetAnimation = animation.drive(tween);
          final reverseOffset = secondaryAnimation.drive(reverseTween);

          return SlideTransition(
            position: animation.status == AnimationStatus.reverse ? reverseOffset : offsetAnimation,
            child: child,
          );
        },
      ),
    );
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
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                color: Theme.of(context).primaryColor,
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
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  loginProvider.updateIsLogin("oldUser");
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.fromLTRB(0, 13, 0, 15),
                                  width: MediaQuery.sizeOf(context).width,
                                  decoration: BoxDecoration(
                                    color: loginProvider.isLoginUser == true ? ColorResources.mainColor : ColorResources.white,
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ColorResources.colorAAADC4,
                                        blurRadius: 3.0,
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    getTranslated("existing_user", context)!,
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: Dimensions.sp14,
                                        fontWeight: FontWeight.w600,
                                        color: loginProvider.isLoginUser == true ? ColorResources.white : ColorResources.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  loginProvider.updateIsLogin("newUser");
                                  confPasswordController.text = "";
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.fromLTRB(0, 13, 0, 15),
                                  width: MediaQuery.sizeOf(context).width,
                                  decoration: BoxDecoration(
                                    color: loginProvider.isLoginUser != true ? ColorResources.mainColor : ColorResources.white,
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ColorResources.colorAAADC4,
                                        blurRadius: 3.0,
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    getTranslated("new_user", context)!,
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: Dimensions.sp14,
                                        fontWeight: FontWeight.w600,
                                        color: loginProvider.isLoginUser != true ? ColorResources.white : ColorResources.black),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                                Images.imgUserBlack,
                                width: 18,
                                height: 18,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 1,
                                child: TextField(
                                  controller: usernameController,
                                  focusNode: usernameFocus,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  style: const TextStyle(
                                    fontSize: Dimensions.sp14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto',
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    hintText: getTranslated("username", context),
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
                          height: 15,
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
                                  controller: passwordController,
                                  focusNode: passwordFocus,
                                  obscureText: loginProvider.obscurePasswordText,
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: loginProvider.isLoginUser == true ? TextInputAction.done : TextInputAction.next,
                                  style: const TextStyle(
                                    fontSize: Dimensions.sp14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto',
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    hintText: getTranslated("password", context),
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
                                  loginProvider.obscurePasswordText ? Icons.visibility_off : Icons.visibility,
                                  color: Colors.grey,
                                ),
                                onPressed: loginProvider.togglePasswordVisibility,
                              )
                            ],
                          ),
                        ),
                        if (loginProvider.isLoginUser != true)
                          SizedBox(
                            height: 15,
                          ),
                        if (loginProvider.isLoginUser != true)
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
                                    obscureText: loginProvider.obscureConfPasswordText,
                                    keyboardType: TextInputType.visiblePassword,
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
                                    loginProvider.obscureConfPasswordText ? Icons.visibility_off : Icons.visibility,
                                    color: Colors.grey,
                                  ),
                                  onPressed: loginProvider.toggleConfPasswordVisibility,
                                )
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
                            :  InkWell(
                          onTap: () {
                            String userName = usernameController.text.toString().trim();
                            String password = passwordController.text.toString().trim();
                            String confPassword = confPasswordController.text.toString().trim();
                            if(userName.isEmpty){
                              showCustomSnackBar(getTranslated('please_enter_user_name', context), context,isError: true);
                            }
                            else if(!AppConstants.emailRegex.hasMatch(userName)){
                              showCustomSnackBar(getTranslated('please_enter_valid_user_name', context), context,isError: true);
                            }
                            else if(password.isEmpty){
                              showCustomSnackBar(getTranslated('please_enter_password', context), context,isError: true);
                            }
                            else if(password.length < 6){
                              showCustomSnackBar(getTranslated('password_must_be_at_least_6_characters_long', context), context,isError: true);
                            }
                            else{

                              if (loginProvider.isLoginUser == true) {
                                //login api calling here
                                loginProvider.getDeviceToken();
                                loginProvider.login(userName, password);
                              }
                              else {
                                if(confPassword.isEmpty){
                                  showCustomSnackBar(getTranslated('please_enter_confirm_password', context), context,isError: true);
                                }
                                else if(confPassword.length<6){
                                  showCustomSnackBar(getTranslated('confirm_password_must_be_at_least_6_characters_long', context), context,isError: true);
                                }
                                else if(password!= confPassword){
                                  showCustomSnackBar(getTranslated('password_and_confirm_password_do_not_match', context), context, isError: true);
                                }
                                else{
                                  // signup api calling here
                                  loginProvider.getDeviceToken();
                                  loginProvider.signup(userName, password);
                                }
                              }
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
                              getTranslated("sign_in", context)!,
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
                        InkWell(
                          onTap: () {
                            routePush(context, ForgotPasswordScreen());
                          },
                          child: Text(
                            getTranslated("forgot_password", context)!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: Dimensions.sp12,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        InkWell(
                          onTap: () {
                            showAnimatedDialog(context);
                          },
                          child: Text(
                            getTranslated("help", context)!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: Dimensions.sp12,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        )
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
