import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/profile/controllers/profile_controller.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/dimensions.dart';
import '../../../../main.dart';
import '../../../../utill/images.dart';


class SelectTierDialog extends StatefulWidget {
  const SelectTierDialog({super.key});

  @override
  State<SelectTierDialog> createState() => _SelectTierDialogState();
}

class _SelectTierDialogState extends State<SelectTierDialog> {

  ProfileController profileController = Provider.of<ProfileController>(Get.context!,listen: false);
  @override
  void initState() {
    super.initState();
    profileController.intiData(false);
    profileController.searchController.addListener(profileController.filterActionTier);
  }

  @override
  void dispose() {
    profileController.searchController.dispose();
    profileController.searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileController>(builder: (context, controller, _) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex: 1,
                    child: Text(
                      textAlign: TextAlign.center,
                      getTranslated("select_tier", context)!,
                      style: TextStyle(
                        fontSize: Dimensions.sp16,
                        color: ColorResources.black,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                  InkWell(onTap: (){
                    Navigator.of(context).pop();
                  },child: Image.asset(Images.cancelled,width: 20,height: 20,)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  border: Border.all(color: ColorResources.mainColor, width: 1),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                ),
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  children: [
                    Image.asset(
                      Images.imgSearchGray,
                      width: 18,
                      height: 18,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: TextField(
                        controller: controller.searchController,
                        focusNode: controller.searchFocus,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        style: const TextStyle(
                          fontSize: Dimensions.sp14,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Roboto',
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          hintText: getTranslated("search", context),
                          hintStyle: const TextStyle(
                            color: ColorResources.color9a9a9a,
                            fontSize: Dimensions.sp14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.filteredActionTierList!.length,
                itemBuilder: (context, parentIndex) {
                  final user = controller.filteredActionTierList![parentIndex];
                  return InkWell(onTap: (){
                    Navigator.pop(context);
                    controller.updateFilteredActionTierList(controller.filteredActionTierList![parentIndex]);
                  },
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    user.name!,
                                    style: const TextStyle(fontSize: Dimensions.sp14, fontWeight: FontWeight.w600, fontFamily: 'roboto', color: ColorResources.color333333),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            color: ColorResources.color9a9a9a,
                          )
                        ],
                      ));
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
