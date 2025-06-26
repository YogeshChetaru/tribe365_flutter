import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../controllers/profile_controller.dart';
import '../widgets/cot_description_card.dart';

class TeamRoleCateDescScreen extends StatefulWidget {
  final String teamRoleName;

  const TeamRoleCateDescScreen({super.key, required this.teamRoleName});

  @override
  TeamRoleCateDescScreenState createState() => TeamRoleCateDescScreenState();
}

class TeamRoleCateDescScreenState extends State<TeamRoleCateDescScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    loadAPI();
    super.initState();
  }

  void loadAPI() {
    ProfileController controller =
        Provider.of<ProfileController>(context, listen: false);
    controller.viewCOTMapperSummary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child:
            Consumer<ProfileController>(builder: (context, profileProvider, _) {
          return Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            color: ColorResources.screenBg,
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
                  ),
                  width: MediaQuery.sizeOf(context).width,
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Image.asset(
                            Images.imgCircleBackRed,
                            width: 24,
                            height: 24,
                          )),
                      Expanded(
                          child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          getTranslated("category_description", context)!,
                          style: TextStyle(
                            fontSize: Dimensions.sp18,
                            fontWeight: FontWeight.w600,
                            color: ColorResources.black,
                          ),
                        ),
                      )),
                      SizedBox(
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: profileProvider.isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                      : profileProvider.cotMapperSummaryDataList == null
                          ?  Center(child: Text(getTranslated("no_data_found", context)!))
                          : ListView.builder(
                              itemCount: profileProvider
                                  .cotMapperSummaryDataList!.length,
                              itemBuilder: (context, index) {
                                return CotDescriptionCard(
                                    item: profileProvider
                                        .cotMapperSummaryDataList![index]);
                              },
                            ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
