import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../../../../common/basewidget/custom_header_back_widget.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../controllers/profile_controller.dart';

class ProfileActionsCommentsScreen extends StatefulWidget {
  const ProfileActionsCommentsScreen({super.key});

  @override
  ProfileActionsCommentsScreenState createState() => ProfileActionsCommentsScreenState();
}

class ProfileActionsCommentsScreenState extends State<ProfileActionsCommentsScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

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
                CustomHeaderBack(
                  title: getTranslated("actions", context)!,
                ),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                            color: ColorResources.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: ColorResources.colorAAADC4,
                                blurRadius: 1.0,
                              ),
                            ],
                          ),
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: ColorResources.mainColor, width: 1),
                                      image: DecorationImage(
                                        image: AssetImage(Images.imgUserCircleGray),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Alex",
                                      style: TextStyle(
                                        fontSize: Dimensions.sp14,
                                        fontWeight: FontWeight.w600,
                                        color: ColorResources.color9a9a9a,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Test",
                                  style: TextStyle(
                                    fontSize: Dimensions.sp12,
                                    fontWeight: FontWeight.w500,
                                    color: ColorResources.color9a9a9a,
                                    fontFamily: 'Roboto',
                                  )),
                              SizedBox(height: 5,),
                              Container(
                                width: MediaQuery.sizeOf(context).width,
                                height: 0.5,
                                color: ColorResources.color9a9a9a,
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 30,
                                    child: Text(
                                      "${getTranslated("start_date", context)!}:",
                                      style: TextStyle(
                                        fontSize: Dimensions.sp13,
                                        fontWeight: FontWeight.w500,
                                        color: ColorResources.color9a9a9a,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 70,
                                    child: Text(
                                      "05-06-2025",
                                      style: TextStyle(
                                        fontSize: Dimensions.sp14,
                                        fontWeight: FontWeight.w600,
                                        color: ColorResources.color9a9a9a,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 30,
                                    child: Text(
                                      "${getTranslated("due_date", context)!}:",
                                      style: TextStyle(
                                        fontSize: Dimensions.sp13,
                                        fontWeight: FontWeight.w500,
                                        color: ColorResources.color9a9a9a,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 70,
                                    child: Text(
                                      "30-09-2025",
                                      style: TextStyle(
                                        fontSize: Dimensions.sp14,
                                        fontWeight: FontWeight.w600,
                                        color: ColorResources.color9a9a9a,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 30,
                                    child: Text(
                                      "${getTranslated("status", context)!}:",
                                      style: TextStyle(
                                        fontSize: Dimensions.sp13,
                                        fontWeight: FontWeight.w500,
                                        color: ColorResources.color9a9a9a,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 70,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 14,
                                          height: 14,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: ColorResources.mainColor,
                                          ),

                                        ),
                                        SizedBox(width: 5,),
                                        Text("not started",textAlign: TextAlign.center,style: TextStyle(
                                          fontSize: Dimensions.sp12,
                                          fontWeight: FontWeight.w500,
                                          color: ColorResources.mainColor,
                                          fontFamily: 'Roboto',
                                        ),),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 30,
                                    child: Text(
                                      "${getTranslated("responsible", context)!}:",
                                      style: TextStyle(
                                        fontSize: Dimensions.sp13,
                                        fontWeight: FontWeight.w500,
                                        color: ColorResources.color9a9a9a,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 70,
                                    child: Text(
                                      "yogesh",
                                      style: TextStyle(
                                        fontSize: Dimensions.sp14,
                                        fontWeight: FontWeight.w600,
                                        color: ColorResources.color9a9a9a,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                            color: ColorResources.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: ColorResources.colorAAADC4,
                                blurRadius: 1.0,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 10,),
                              Expanded(flex: 75,child:TextField(
                                maxLines: 1,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                  fontSize: Dimensions.sp14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Roboto',
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  border: InputBorder.none,
                                  hint: Text(getTranslated("type_your_comment", context)!,style: const TextStyle(
                                    color: ColorResources.color9a9a9a,
                                    fontSize: Dimensions.sp14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto',
                                  ),),
                                ),
                              ) ),
                              SizedBox(width: 10,),
                              Expanded(flex: 25,child:Container(
                                alignment: Alignment.center,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: ColorResources.mainColor,
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),topRight: Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorResources.colorAAADC4,
                                      blurRadius: 1.0,
                                    ),
                                  ],
                                ),
                                child: Text(getTranslated("send", context)!,style: TextStyle(
                                  fontSize: Dimensions.sp16,
                                  fontWeight: FontWeight.w700,
                                  color: ColorResources.white,
                                  fontFamily: 'Roboto',
                                ),),
                              ) ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                          child: Text(getTranslated("comments", context)!,style: TextStyle(
                            fontSize: Dimensions.sp18,
                            fontWeight: FontWeight.w700,
                            color: ColorResources.color9a9a9a,
                            fontFamily: 'Roboto',
                          ),),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                            color: ColorResources.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: ColorResources.colorAAADC4,
                                blurRadius: 1.0,
                              ),
                            ],
                          ),
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: ColorResources.mainColor, width: 1),
                                          image: DecorationImage(
                                            image: AssetImage(Images.imgUserCircleGray),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Alex",
                                          style: TextStyle(
                                            fontSize: Dimensions.sp12,
                                            fontWeight: FontWeight.w600,
                                            color: ColorResources.color9a9a9a,
                                            fontFamily: 'Roboto',
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          textAlign: TextAlign.end,
                                          "05 Jun 2025, 09:43 am",
                                          style: TextStyle(
                                            fontSize: Dimensions.sp10,
                                            fontWeight: FontWeight.w400,
                                            color: ColorResources.color9a9a9a,
                                            fontFamily: 'Roboto',
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("Test",
                                      style: TextStyle(
                                        fontSize: Dimensions.sp12,
                                        fontWeight: FontWeight.w500,
                                        color: ColorResources.color9a9a9a,
                                        fontFamily: 'Roboto',
                                      )),
                                  SizedBox(height: 5,),
                                  Container(
                                    width: MediaQuery.sizeOf(context).width,
                                    height: 0.5,
                                    color: ColorResources.color9a9a9a,
                                  ),
                                  SizedBox(height: 10,),
                                ],
                              );
                            },
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




