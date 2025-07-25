import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/home/controllers/home_controller.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../domain/models/viewhomeresponse.dart';

class HomeKudosListWidget extends StatelessWidget {
  final Function(int index, HomeBelief item)? onLongPress;
  final Function(int index, HomeBelief item)? onKudosTap;
  final Function(int index, HomeBelief item)? onAmazingTap;

  const HomeKudosListWidget({
    super.key,
    this.onLongPress,
    this.onKudosTap,
    this.onAmazingTap,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeController>(context);
    final items = provider.kudosList;
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(12),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items!.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.8,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        final isSelected = item.isSelected;
        String kudosValue = "";
        if (item.todayKudosCount!>99){
          kudosValue = "99+";
        }else {
          kudosValue = item.todayKudosCount.toString();
        }
        String amazingValue = "";
        if (item.todayDotValueKudoAwardCount!>99){
          amazingValue = "99+";

        }else {
          amazingValue = item.todayDotValueKudoAwardCount.toString();
        }
        return GestureDetector(
          onTap: () => provider.toggleSelectionKudos(index),
          onLongPress: (){
            onLongPress!(index,item);
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ?
              ColorResources.mainColor :
              Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                )
              ],
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      item.name!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isSelected ?
                        Colors.white :
                        ColorResources.mainColor,
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Positioned(right: 0,
                        bottom: 0,
                        child: InkWell(
                          onTap: (){
                            onKudosTap!(index,item);
                          },child: Container(
                            height: 60,
                            width: 60,
                            padding: EdgeInsets.only(right: 8,bottom: 7),
                            alignment: Alignment.center,
                            decoration:  BoxDecoration(
                              color: isSelected ?
                              ColorResources.white :
                              ColorResources.mainColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(60),
                                  bottomRight: Radius.circular(20)
                              ),
                            ),
                            child:  Text(
                              textAlign: TextAlign.start,
                              kudosValue,
                              style:  TextStyle(
                                color: isSelected ?
                                ColorResources.mainColor :
                                ColorResources.white,
                                fontSize: 14,
                                fontWeight:FontWeight.w600,

                              ),
                            ),
                          ),
                        )),
                    Positioned(
                        right: 0,
                        bottom: 0,
                        child: InkWell(
                          onTap: (){
                            onAmazingTap!(index,item);
                          },child: Container(
                            padding: EdgeInsets.fromLTRB(15, 10, 10, 5),
                            alignment: Alignment.center,
                            decoration:  BoxDecoration(
                              color: isSelected ?
                              ColorResources.mainColor :
                              Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(60),
                                  bottomRight: Radius.circular(20)
                              ),
                            ),
                            child:  Text(
                              textAlign: TextAlign.center,
                              amazingValue,
                              style:  TextStyle(
                                color: isSelected ?
                                ColorResources.white :
                                ColorResources.mainColor,
                                fontSize: 14,
                                fontWeight:FontWeight.w600,

                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}