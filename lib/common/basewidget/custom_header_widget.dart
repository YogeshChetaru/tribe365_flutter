import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../feature/paid_version/profile/controllers/profile_controller.dart';
import '../../utill/color_resources.dart';
import '../../utill/images.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileController>(builder: (context, profileProvider, _) {
      return Container(
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
        padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
        child: Row(
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ColorResources.mainColor, width: 1),
                image: DecorationImage(
                  image: profileProvider.userProfileData == null
                      ? AssetImage(Images.imgTribe365) as ImageProvider
                      : NetworkImage(profileProvider.userProfileData!.organisationLogo!) as ImageProvider,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

