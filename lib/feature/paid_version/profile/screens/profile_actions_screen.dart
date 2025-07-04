import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/profile/screens/profile_actions_comments_screen.dart';
import 'package:tribe365_new/feature/paid_version/profile/screens/profile_add_actions_screen.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/custom_route.dart';
import '../../../../common/basewidget/custom_header_back_widget.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../controllers/profile_controller.dart';
import '../domain/models/view_action_list_response.dart';
import '../widgets/actiondeletedialog.dart';
import '../widgets/build_action_list_item.dart';

class ProfileActionsScreen extends StatefulWidget {
  const ProfileActionsScreen({super.key});

  @override
  ProfileActionsScreenState createState() => ProfileActionsScreenState();
}

class ProfileActionsScreenState extends State<ProfileActionsScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    loadAPI();
    super.initState();
  }

  void loadAPI() {
    ProfileController controller = Provider.of<ProfileController>(context, listen: false);
    controller.viewActionListAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Consumer<ProfileController>(builder: (context, profileProvider, _) {
          return Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            color: ColorResources.screenBg,
            child: Column(
              children: [
                CustomHeaderBack(
                  title: getTranslated("view_actions", context)!,
                ),
                Expanded(
                  flex: 1,
                  child: profileProvider.isLoading
                      ? SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          height: MediaQuery.sizeOf(context).height,
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        )
                      : profileProvider.viewActionList == null || profileProvider.viewActionList!.isEmpty
                          ? Container(
                              width: MediaQuery.sizeOf(context).width,
                              height: MediaQuery.sizeOf(context).height,
                              alignment: Alignment.center,
                              child: Text(
                                getTranslated("no_action_found", context)!,
                                style: TextStyle(
                                  color: ColorResources.color9a9a9a,
                                  fontSize: Dimensions.sp18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          : SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    decoration: BoxDecoration(
                                      color: ColorResources.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorResources.colorAAADC4,
                                          blurRadius: 3.0,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            value: profileProvider.tierSelectedValue,
                                            items: profileProvider.tierList.map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style: const TextStyle(
                                                    fontSize: Dimensions.sp14,
                                                    color: ColorResources.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: 'Roboto',
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              profileProvider.updateTierSelectedValue(newValue);
                                            },
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                  profileProvider.filteredActions==null||profileProvider.filteredActions!.isEmpty?
                                      SizedBox.shrink():
                                  Container(
                                    margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: profileProvider.filteredActions!.length,
                                      itemBuilder: (context, index) {
                                        return buildActionItem(context, profileProvider.filteredActions![index], profileProvider.userProfileData!.id.toString());
                                      },
                                    ),
                                  ),

                                ],
                              ),
                            ),
                ),
              ],
            ),
          );
        }),
      ),
      floatingActionButton: RawMaterialButton(
        onPressed: () {
          routePush(context, ProfileAddActionsScreen());
        },
        fillColor: ColorResources.mainColor,
        shape: CircleBorder(),
        constraints: BoxConstraints.tightFor(
          width: 56.0,
          height: 56.0,
        ),
        child: Icon(Icons.add, size: 40, color: Colors.white),
      ),
    );
  }
}


