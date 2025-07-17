import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/profile/controllers/profile_controller.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/images.dart';
import 'package:tribe365_new/utill/utility.dart';
import '../../../../utill/custom_route.dart';
import '../../profile/domain/models/viewuserprofileresponse.dart';
import '../domain/models/view_unread_notification_list.dart';
import '../screens/notification_webpage_screen.dart';

class DialogDescFull extends StatelessWidget {
  final ViewUnreadNotificationData notiList;

  const DialogDescFull({
    super.key,
    required this.notiList,
  });

  @override
  Widget build(BuildContext context) {
    ViewUserProfileData? userProfileData = Provider.of<ProfileController>(context, listen: false).userProfileData;
    final bool hasLink = notiList.lastMessage?.isNotEmpty ?? false;
    final bool isRole3 = userProfileData!.role == 3;
    return Center(
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: ColorResources.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10)),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                    width: MediaQuery.sizeOf(context).width,
                    child: InkWell(onTap: (){
                      Navigator.pop(context);
                    },child: Image.asset(Images.cancelled,width: 24,height: 24,))),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Image.asset(Images.imgDirect), // direct icon
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        notiList.title ?? '',
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14, // text_size_normal
                          color: Color(0xFF2D2D2D), // textcolor
                        ),
                      ),
                    ),
                    if (isRole3 && userProfileData.organisationLogo!.isNotEmpty)
                      Image.network(
                        userProfileData.organisationLogo!,
                        height: 30,
                        width: 30,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => Image.asset(Images.imgAppLogo),
                      ),
                  ],
                ),
                SizedBox(height: 5,),
                Text(
                  notiList.description ?? '',
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 13, // text_size_small
                    color: Color(0xFF2D2D2D), // textcolor
                  ),
                ),
                Text(
                  Utility.convertDataIntoddMMMyyyyhhmma(notiList.createdAt!),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF2D2D2D),
                  ),
                ),
               SizedBox(height: 5,),
                if (hasLink)
                InkWell(
                  onTap: (){
                    routePush(context, NotificationWebpageScreen(url:notiList.lastMessage!));
                  },child: Container(
                  padding: EdgeInsets.fromLTRB(12, 5, 12, 5),
                  decoration: BoxDecoration(
                    color: ColorResources.mainColor,
                    border: Border.all(
                        color: ColorResources.mainColor,
                        width: 0.5),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7),
                        bottomLeft: Radius.circular(7),
                        topRight: Radius.circular(7),
                        bottomRight: Radius.circular(7)),
                  ),
                  child: Text(getTranslated("open_link", context)!,style: TextStyle(
                      color: ColorResources.white,
                      fontSize:12,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Roboto"
                  ),
                  ),
                ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
