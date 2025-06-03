import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/free_version/hptm/controllers/hptm_controller.dart';
import 'package:tribe365_new/feature/free_version/hptm/widgets/hptmprinciplesmainitem.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/color_resources.dart';

import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../widgets/hptmprinciplesitem.dart';

class HPTMScreen extends StatefulWidget {
  const HPTMScreen({super.key});

  @override
  HPTMScreenState createState() => HPTMScreenState();
}

class HPTMScreenState extends State<HPTMScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Consumer<HPTMController>(builder: (context, hptmProvider, _) {
          return Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            color: ColorResources.screenBg,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: ColorResources.white,
                    boxShadow: [
                      BoxShadow(
                        color: ColorResources.colorAAADC4,
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  width: MediaQuery.sizeOf(context).width,
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            Images.imgCircleBackRed,
                            width: 24,
                            height: 24,
                          )),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: ColorResources.mainColor, width: 1),
                          image: DecorationImage(
                            image: AssetImage(Images.imgTribe365),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                getTranslated("hptm", context)!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: Dimensions.sp16,
                                  color: ColorResources.mainColor,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                "1450",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: Dimensions.sp16,
                                  color: ColorResources.color333333,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Roboto',
                                ),
                              ),
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
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                          decoration: BoxDecoration(
                            color: ColorResources.white,
                            boxShadow: [
                              BoxShadow(
                                color: ColorResources.colorAAADC4,
                                blurRadius: 5.0,
                              ),
                            ],
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                          ),
                          width: MediaQuery.sizeOf(context).width,
                          padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  hptmProvider.updateHPTMStatus();
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "The 5 HPTM Principles",
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          fontSize: Dimensions.sp16,
                                          color: ColorResources.color333333,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Image.asset(
                                      hptmProvider.hPTMStatus == true ? Images.imgDownArrowBlack : Images.imgRightArrowBlack,
                                      width: 18,
                                      height: 18,
                                    ),
                                  ],
                                ),
                              ),
                              if (hptmProvider.hPTMStatus == true)
                                SizedBox(
                                  height: 15,
                                ),
                              hptmProvider.hPTMStatus == true
                                  ? GridView.builder(
                                      itemCount: 5,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      // disable scroll if inside another scroll view
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2, // 2 columns
                                        crossAxisSpacing: 15,
                                        mainAxisSpacing: 15,
                                        childAspectRatio: 2.5 / 2, // adjust as needed
                                      ),
                                      itemBuilder: (context, index) {
                                        return HptmPrinciplesItem(indexMain: index);
                                      },
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                          width: MediaQuery.sizeOf(context).width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(getTranslated("self_learning_checklist", context)!,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    fontSize: Dimensions.sp14,
                                    color: ColorResources.color333333,
                                    fontWeight: FontWeight.w600,
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 50, // height for horizontal list
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: hptmProvider.selfLearningListItems.length,
                                  itemBuilder: (context, index) {
                                    final isSelected = index == hptmProvider.selectedSelfLearningListIndex;
                                    return InkWell(
                                      onTap: () {
                                        hptmProvider.updateSelectedSelfLearningListItem(index);
                                      },
                                      child: Container(
                                        height: 40,
                                        margin: EdgeInsets.only(right: 15, top: 5, bottom: 5),
                                        decoration: BoxDecoration(
                                          color: isSelected ? ColorResources.mainColor : Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: ColorResources.colorAAADC4,
                                              blurRadius: 3.0,
                                            ),
                                          ],
                                        ),
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child: Text(
                                          hptmProvider.selfLearningListItems[index],
                                          style: TextStyle(color: isSelected ? Colors.white : ColorResources.color333333, fontWeight: FontWeight.w600, fontFamily: 'Roboto', fontSize: Dimensions.sp14),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:hptmProvider.data.length,
                                itemBuilder: (context, parentIndex) {
                                  final category = hptmProvider.data[parentIndex];
                                  return HptmPrinciplesMainItem(category);
                                },
                              )
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
