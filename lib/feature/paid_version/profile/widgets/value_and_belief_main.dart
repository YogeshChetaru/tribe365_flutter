import 'package:flutter/material.dart';
import 'package:tribe365_new/feature/paid_version/profile/controllers/profile_controller.dart';
import 'package:tribe365_new/utill/color_resources.dart';

import '../../../../localization/language_constrants.dart';
import '../../../../utill/images.dart';

class ValueAndBeliefMain extends StatelessWidget {
 final ProfileController  profileProvider;
   const ValueAndBeliefMain({
    super.key,
    required this.profileProvider
  });

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> values = [
      {'title': 'ZERO WASTE', 'score': '4.5', 'border': true},
      {'title': 'STRAIGHT FORWARD', 'score': '4', 'border': true},
      {'title': 'Forward Thinking', 'score': '5.0', 'color': Color(0xFFEB1C24)},
      {'title': 'People Focused', 'score': '3.5', 'color': Colors.red.shade300},
      {'title': 'Direct', 'score': '4.0', 'color': Color(0xFFEB1C24)},
      {'title': 'Logical', 'score': '4.5', 'color': Color(0xFFEB1C24)},
    ];

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: (){
                profileProvider.updateValueStatus();
              },
              child: Row(
                children: [
                  Expanded(
                    flex: 1,child:
                  Text(getTranslated("values_and_belief", context)!, style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Roboto', color: ColorResources.color333333)),
                  ),
                  Image.asset(profileProvider.isValueVisible==true?
                  Images.imgUpArrowRed:
                  Images.imgDownArrowRed,width: 20,height: 20,),

                ],
              ),
            ),
            if(profileProvider.isValueVisible)
              Column(
              children: [
                const SizedBox(height: 12),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: values.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 2),
                  itemBuilder: (context, index) {
                    var item = values[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: item['border'] == true ? Colors.white : item['color'] as Color,
                        borderRadius: BorderRadius.circular(8),
                        border: item['border'] == true ? Border.all(color: ColorResources.mainColor) : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item['title'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: item['border'] == true ? FontWeight.w500 : FontWeight.normal,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['score'],
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
