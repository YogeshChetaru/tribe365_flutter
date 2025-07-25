import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/home/screens/dot_details_screen.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/custom_route.dart';
import 'package:tribe365_new/utill/images.dart';
import '../controllers/home_controller.dart';
import 'open_link_dialog.dart';

class HomeVisionCardView extends StatelessWidget {
  final String visionText;
  final String subTitleName;
  final String description;
  final String videoURL;

  const HomeVisionCardView({
    super.key,
    required this.visionText,
    required this.subTitleName,
    required this.description,
    required this.videoURL
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(builder: (context, homeProvider, _) {
      return Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  homeProvider.updateHomeVisionStatus();
                },
                child: Row(
                  children: [
                    Expanded(flex:  1,
                      child: Text(
                        visionText,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color:ColorResources.mainColor,
                        ),
                        textAlign: TextAlign.start,
                      ),),
                    Image.asset(homeProvider.homeVisionStatus==true?Images.imgUpArrowRed:Images.imgDownArrowRed,width: 20,height: 20,)
                  ],
                ),
              ),
              if(homeProvider.homeVisionStatus==true)
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 12,
                  top: 10
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        openLinkDialog(
                          context,
                          title: getTranslated("vision", context)!,
                          subTitle: subTitleName,
                          description: description,
                          videoURL: videoURL,
                        );
                      },
                      child: Card(
                        elevation: 5,
                        margin: const EdgeInsets.all(6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 6),
                          child: Text(
                            getTranslated("vision", context)!,
                            style: const TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w400,fontFamily: "Roboto"),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    InkWell(
                      onTap: (){
                        routePush(context, DotDetailsScreen());
                      },child: Card(
                      elevation: 5,
                      margin: const EdgeInsets.all(6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 6),
                        child: Text(
                          getTranslated("vision_map", context)!,
                          style: const TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w400,fontFamily: "Roboto"),
                        ),
                      ),
                    ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}


