import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/free_version/hptm/widgets/hptmprinciplesmainsubitem.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/images.dart';

import '../controllers/hptm_controller.dart';
import '../domain/models/subchecklistitem.dart';

class HptmPrinciplesMainItem extends StatelessWidget {
  final String title;
 final List<SubChecklistItem> subItems;
 final bool isExpanded;
   const HptmPrinciplesMainItem({super.key,required this.title,required this.subItems,required this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return Consumer<HPTMController>(builder: (context, hptmProvider, _){
      return Container(
        margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                hptmProvider.toggleSection(title);
              },child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      if(hptmProvider.mainClickStatus[title]==true){
                        hptmProvider.toggleMain(title, false);
                      }
                      else{
                        hptmProvider.toggleMain(title, true);
                      }
                    },child: Image.asset(
                    hptmProvider.mainClickStatus[title]==true?Images.imgGreenCheck: Images.imgCircleUnchecked,
                      width: 24,
                      height: 24,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'roboto',
                          color: ColorResources.color333333
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    isExpanded ==true?Images.imgUpArrowRed :Images.imgDownArrowRed,
                    width: 20,
                    height: 20,
                  ),
                ],
              ),
            ),
            if (isExpanded)
            const SizedBox(height: 10),
            if (isExpanded)
            ListView.builder(
              itemCount: subItems.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, childIndex) {
                return HptmPrinciplesMainSubItem(title: title,i: childIndex,subItems: subItems,);
              },
            ),
          ],
        ),
      );
    });
  }
}
