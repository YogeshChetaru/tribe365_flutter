import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/home/controllers/home_controller.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/images.dart';

class UpdateAppDesign extends StatelessWidget {
  const UpdateAppDesign({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      color: ColorResources.mainColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorResources.mainColor, width: 1),
                  image: DecorationImage(
                    image: AssetImage(
                      Images.imgAppLogo,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // App update title and description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getTranslated("app_update", context)!,
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorResources.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      getTranslated(
                          "a_new_version_of_the_app_is_available_please_update_to_continue",
                          context)!,
                      style: TextStyle(
                        fontSize: 14,
                        color: ColorResources.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Provider.of<HomeController>(context,listen: false).updateAppStatus("later");
                },
                child: Container(
                  margin: const EdgeInsets.all(4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: ColorResources.mainColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    getTranslated("LATER", context)!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<HomeController>(context,listen: false).updateAppStatus("update");
                },
                child: Container(
                  margin: const EdgeInsets.all(4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:  Text(
                    getTranslated("UPDATE", context)!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
