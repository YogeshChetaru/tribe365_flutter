import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/profile/screens/profile_add_actions_screen.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../../../../common/basewidget/custom_header_back_widget.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/dimensions.dart';
import '../controllers/profile_controller.dart';
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
                          : Column(
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
                              Expanded(
                                flex: 1,child: Container(
                                  margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    itemCount: profileProvider.filteredActions!.length,
                                    itemBuilder: (context, index) {
                                      return buildActionItem(context, profileProvider.filteredActions![index], profileProvider.userProfileData!.id.toString());
                                    },
                                  ),
                                ),
                              ),

                            ],
                          ),
                ),
              ],
            ),
          );
        }),
      ),
      floatingActionButton: RawMaterialButton(
        onPressed: () async {
          final result = await Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 500),
              reverseTransitionDuration: Duration(milliseconds: 500),
              pageBuilder: (context, animation, secondaryAnimation) => ProfileAddActionsScreen(wayFrom: "add",),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0); // from right
                const end = Offset.zero;
                const curve = Curves.easeInOut;
                final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                final offsetAnimation = animation.drive(tween);
                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            ),
          );
          if (result == true) {
            loadAPI();
          }
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


