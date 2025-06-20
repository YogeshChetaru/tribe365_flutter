import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/know/controllers/know_controller.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/dimensions.dart';

import '../domain/models/model_add_action_user_response.dart';

class SelectActionUserItem extends StatelessWidget {
  final ModelAddActionUserData userData;
  final String wayFrom;

  const SelectActionUserItem({super.key, required this.userData,required this.wayFrom});

  @override
  Widget build(BuildContext context) {
    String name = "${userData.name!} ${userData.lastName ?? ""}";
    return InkWell(
      onTap: () {
        if(wayFrom=="member"){
          Provider.of<KnowController>(context, listen: false).updateMemberData(userData);
        }
        else{
          Provider.of<KnowController>(context, listen: false).updateUserData(userData);
        }
        Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 0, right: 15, left: 15),
              child: Text(
                name,
                style: const TextStyle(fontSize: Dimensions.sp14, fontWeight: FontWeight.w600, fontFamily: 'roboto', color: ColorResources.black),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width,
              height: 0.5,
              color: ColorResources.color9a9a9a,
            )
          ],
        ),
      ),
    );
  }
}
