import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/free_version/hptm/controllers/hptm_controller.dart';
import 'package:tribe365_new/feature/free_version/hptm/widgets/hptmprinciplesmainitem.dart';
import 'package:tribe365_new/feature/paid_version/profile/controllers/profile_controller.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/color_resources.dart';

import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../domain/models/subchecklistitem.dart';
import '../widgets/hptmprinciplesitem.dart';

class HPTMScreen extends StatefulWidget {
  const HPTMScreen({super.key});

  @override
  HPTMScreenState createState() => HPTMScreenState();
}

class HPTMScreenState extends State<HPTMScreen> {
  @override
  void initState() {
    loadApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Consumer<HPTMController>(builder: (context, hptmProvider, _) {
          return Consumer<ProfileController>(builder: (context, profileProvider, _) {
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
                              image: profileProvider.userProfileData!.organisationLogo == null
                                  ? AssetImage(Images.imgTribe365) as ImageProvider
                                  : NetworkImage(profileProvider.userProfileData!.organisationLogo!) as ImageProvider,
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
                                hptmProvider.viewHPTMPrinciplesData == null
                                    ? SizedBox.fromSize()
                                    : Text(
                                        hptmProvider.viewHPTMPrinciplesData!.hPTMScore.toString(),
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
                          hptmProvider.isLoading
                              ? Container(
                                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
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
                                                getTranslated("the_5_HPTM_principles", context)!,
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
                                              itemCount: hptmProvider.hPTMPrincipleList!.length,
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2, // 2 columns
                                                crossAxisSpacing: 15,
                                                mainAxisSpacing: 15,
                                                childAspectRatio: 2.3 / 2, // adjust as needed
                                              ),
                                              itemBuilder: (context, index) {
                                                return HptmPrinciplesItem(
                                                  indexMain: index,
                                                  principleData: hptmProvider.hPTMPrincipleList![index],
                                                );
                                              },
                                            )
                                          : const SizedBox.shrink(),
                                    ],
                                  ),
                                ),
                          hptmProvider.hPTMPrincipleList == null
                              ? SizedBox.fromSize()
                              : Container(
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
                                          itemCount: hptmProvider.hPTMPrincipleList!.length,
                                          itemBuilder: (context, index) {
                                            final isSelected = index == hptmProvider.selectedSelfLearningListIndex;
                                            return InkWell(
                                              onTap: () {
                                                hptmProvider.updateSelectedSelfLearningListItem(index,hptmProvider.hPTMPrincipleList![index]);
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
                                                  hptmProvider.hPTMPrincipleList![index].title!,
                                                  style: TextStyle(
                                                      color: isSelected ? Colors.white : ColorResources.color333333, fontWeight: FontWeight.w600, fontFamily: 'Roboto', fontSize: Dimensions.sp14),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),

                                      hptmProvider.checklistModel == null
                                          ? SizedBox.fromSize()
                                          : ListView.builder(
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              itemCount: hptmProvider.checklistModel!.learningCheckList.length,
                                              itemBuilder: (context, parentIndex) {
                                                final String title = hptmProvider.checklistModel!.learningCheckList.keys.elementAt(parentIndex);
                                                List<SubChecklistItem> subItems = hptmProvider.checklistModel!.learningCheckList[title]!;
                                                bool isExpanded = hptmProvider.sectionExpanded[title] ?? false;
                                                return HptmPrinciplesMainItem(
                                                  title: title,
                                                  subItems: subItems,
                                                  isExpanded: isExpanded,

                                                );
                                              },
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
          });
        }),
      ),
    );
  }

  void loadApi() {
    HPTMController controller = Provider.of<HPTMController>(context, listen: false);
    controller.getHPTMPrinciplesList(0);
  }
}
