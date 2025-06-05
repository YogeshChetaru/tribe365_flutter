import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/dimensions.dart';
import '../../../../common/basewidget/custom_header_back_widget.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/images.dart';
import '../controllers/profile_controller.dart';
import '../widgets/support_history_item.dart';

class ProfileSupportScreen extends StatefulWidget {
  const ProfileSupportScreen({super.key});

  @override
  ProfileSupportScreenState createState() => ProfileSupportScreenState();
}

class ProfileSupportScreenState extends State<ProfileSupportScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  final TextEditingController tellUsController = TextEditingController();
  final FocusNode tellUsFocus = FocusNode();

  @override
  void dispose() {
    tellUsController.dispose();
    tellUsFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Consumer<ProfileController>(builder: (context, profileProvider, _) {
          return Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            color: ColorResources.screenBg,
            child: Column(
              children: [
                CustomHeaderBack(title: getTranslated("support", context)!,),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: ColorResources.white,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10), topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: ColorResources.colorAAADC4,
                                blurRadius: 3.0,
                              ),
                            ],
                          ),
                          margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                        width: MediaQuery.sizeOf(context).width,
                                        child: Text(
                                          getTranslated("tell_us", context)!,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: ColorResources.black,
                                          ),
                                        ),
                                      )),
                                  Image.asset(
                                    Images.imgAttachmentBlack,
                                    width: 18,
                                    height: 18,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width,
                                decoration: BoxDecoration(
                                  color: ColorResources.colorF8F8F8,
                                  border: Border.all(color: ColorResources.colorF8F8F8, width: 0.5),
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                                ),
                                padding: EdgeInsets.fromLTRB(15, 10, 5, 10),
                                child: TextField(
                                  textAlign: TextAlign.start,
                                  controller: tellUsController,
                                  focusNode: tellUsFocus,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  maxLines: 7,
                                  style: const TextStyle(
                                    fontSize: Dimensions.sp12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto',
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    hintText: getTranslated("if_you_have_experienced_any_issues_with_the_app_please_report_them_here", context),
                                    hintStyle: const TextStyle(
                                      color: ColorResources.color9a9a9a,
                                      fontSize: Dimensions.sp10,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(60, 12, 60, 12),
                                  decoration: BoxDecoration(
                                    color: ColorResources.mainColor,
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                                  ),
                                  child: Text(
                                    getTranslated("send", context)!,
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
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                          width: MediaQuery.sizeOf(context).width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getTranslated("history", context)!,
                                style: TextStyle(
                                  fontSize: Dimensions.sp16,
                                  color: ColorResources.black,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                              /*Container(
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                    child: Text(
                      getTranslated("no_offloading_submitted_yet", context)!,
                      style: TextStyle(
                        fontSize: Dimensions.sp14,
                        color: ColorResources.color9a9a9a,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),*/
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: ListView.builder(
                                  itemCount: 1,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, childIndex) {
                                    return SupportHistoryItem();
                                  },
                                ),
                              ),

                            ],
                          ),
                        ),
                      ],
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
