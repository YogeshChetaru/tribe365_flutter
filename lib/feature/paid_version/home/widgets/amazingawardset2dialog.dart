import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/home/controllers/home_controller.dart';
import 'package:tribe365_new/feature/paid_version/home/widgets/amazingyuseritem.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/dimensions.dart';

import '../../../../main.dart';
import '../../../../utill/images.dart';
import 'amazingawarduseritem.dart';


class AmazingAwardSet2Dialog extends StatefulWidget {
  const AmazingAwardSet2Dialog({super.key});

  @override
  State<AmazingAwardSet2Dialog> createState() => _AmazingAwardSet2DialogState();
}

class _AmazingAwardSet2DialogState extends State<AmazingAwardSet2Dialog> {

  HomeController homeProvider = Provider.of<HomeController>(Get.context!,listen: false);

  @override
  void initState() {
    super.initState();
    homeProvider.intiData(false);
    homeProvider.viewFilteredUsersList(false);
    homeProvider.searchController.addListener(homeProvider.filterUsers);
  }

  @override
  void dispose() {
    homeProvider.searchController.dispose();
    homeProvider.searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(builder: (context, homeProvider, _) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textAlign: TextAlign.start,
                getTranslated("individuals", context)!,
                style: TextStyle(
                  fontSize: Dimensions.sp16,
                  color: ColorResources.mainColor, // Replace with ColorResources.mainColor
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(
                height: 5,
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
                        controller: homeProvider.searchController,
                        focusNode: homeProvider.searchFocus,
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
                itemCount: homeProvider.filteredUsers.length,
                itemBuilder: (context, parentIndex) {
                  final user = homeProvider.filteredUsers[parentIndex];
                  return InkWell(onTap: (){
                    homeProvider.toggleSelection(parentIndex);
                  },child: AmazingAwardUserItem(
                    userName: user.name,
                    isSelected: user.isSelected,
                  ));
                },
              ),
              InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                },child: Container(
                width: MediaQuery.sizeOf(context).width,
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                decoration: BoxDecoration(
                  color: ColorResources.mainColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                ),
                child: Text(getTranslated("submit", context)!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: Dimensions.sp16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Roboto',
                  ),),
              ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
