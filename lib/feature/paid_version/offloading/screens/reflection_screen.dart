import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../controllers/offloading_controller.dart';
import '../widgets/recent_reflection_item.dart';

class ReflectionScreen extends StatefulWidget {
  const ReflectionScreen({super.key});

  @override
  ReflectionScreenState createState() => ReflectionScreenState();
}

class ReflectionScreenState extends State<ReflectionScreen> {
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
    return SafeArea(
      child: Consumer<OffloadingController>(builder: (context, offloadingProvider, _) {
        return Column(
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
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text(
                      getTranslated("tell_us", context)!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: ColorResources.black,
                      ),
                    ),
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
                    getTranslated("recent_reflection", context)!,
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
                      getTranslated("no_reflection_submitted_yet", context)!,
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
                        return RecentReflectionItem();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
