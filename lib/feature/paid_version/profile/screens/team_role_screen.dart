import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/main.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../../../../common/basewidget/custom_header_back_widget.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/dimensions.dart';
import '../controllers/profile_controller.dart';
import '../widgets/team_role_build_statement.dart';

class TeamRoleScreen extends StatefulWidget {
  const TeamRoleScreen({super.key});

  @override
  TeamRoleScreenState createState() => TeamRoleScreenState();
}

class TeamRoleScreenState extends State<TeamRoleScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  ProfileController profileController = Provider.of<ProfileController>(Get.context!,listen: false);

  @override
  void initState() {
    super.initState();
    profileController.initCounters();

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
                  title: getTranslated("team_role", context)!,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                        child: Text(
                          getTranslated("what_i_enjoy_contributing_to_my_team_10_points_across_8_statements", context)!,
                          style: TextStyle(
                            fontSize: Dimensions.sp16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Roboto',
                            color: ColorResources.color333333
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          itemCount:profileProvider.statements.length,
                          itemBuilder: (context, index) => TeamRoleBuildStatement(index: index),
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
      bottomNavigationBar: SafeArea(child: Consumer<ProfileController>(builder: (context, profileProvider, _) {
        return Container(
          width: MediaQuery.sizeOf(context).width,
          height: 120,
          color: ColorResources.white,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorResources.white,
                  boxShadow: [
                    BoxShadow(
                      color: ColorResources.colorAAADC4,
                      blurRadius: 5.0,
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                width: MediaQuery.sizeOf(context).width,
                margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                padding: EdgeInsets.fromLTRB(15, 7, 15, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      getTranslated("total", context)!,
                      style: TextStyle(fontSize: Dimensions.sp16, fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto', color: ColorResources.color9a9a9a),
                    ),
                    Text(
                      '${profileProvider.totalPoints}',
                      style:TextStyle(fontSize: Dimensions.sp16, fontWeight: FontWeight.w600,
                          fontFamily: 'Roboto', color: ColorResources.color333333),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {

                },
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  width: MediaQuery.sizeOf(context).width,
                  margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
                  decoration: BoxDecoration(
                    color: ColorResources.mainColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                  ),
                  child: Text(
                    getTranslated("next_question", context)!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: Dimensions.sp16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      })),
    );
  }


}
