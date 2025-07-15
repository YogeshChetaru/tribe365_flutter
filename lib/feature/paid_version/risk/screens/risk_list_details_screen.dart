
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/profile/controllers/profile_controller.dart';
import 'package:tribe365_new/feature/paid_version/profile/screens/profile_add_actions_screen.dart';
import 'package:tribe365_new/feature/paid_version/risk/controllers/risk_controller.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/custom_route.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../domain/models/view_risk_register_list_response.dart';
import '../widgets/risk_action_item.dart';

class RiskListDetailsScreen extends StatefulWidget {
  final RiskArr? riskItemData;
   const RiskListDetailsScreen({super.key, this.riskItemData});

  @override
  RiskListDetailsScreenState createState() => RiskListDetailsScreenState();
}

class RiskListDetailsScreenState extends State<RiskListDetailsScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    loadAPI();
    super.initState();
  }
  void loadAPI(){
    RiskController controller = Provider.of<RiskController>(context,listen: false);
  controller.viewRiskDetail(widget.riskItemData==null?"1":widget.riskItemData!.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Consumer<RiskController>(builder: (context, riskProvider, _) {
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
                          onTap:() => {
                            Navigator.pop(context,true)
                          },
                          child: Image.asset(
                            Images.imgCircleBackRed,
                            width: 24,
                            height: 24,
                          )
                      ),
                      Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "",
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
                  child:riskProvider.isLoading==true?
                  Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ):
                  Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20,),
                            // Title
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                               riskProvider.actionTitle==""?"Action Title Here":riskProvider.actionTitle,
                                style: TextStyle(
                                  color: ColorResources.mainColor,
                                  fontSize: 18,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),

                            // Description
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                              child: Text(
                             riskProvider.actionDesc==""?"Action description goes here.":riskProvider.actionDesc,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ),

                            // Date / Priority Row
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                children: [
                                  Text(
                                    riskProvider.actionDate,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    riskProvider.actionRisk,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: ColorResources.mainColor,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    " risk level",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Offload text
                            if(riskProvider.numOffloadStatus!="")
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                              child: Text(
                                riskProvider.numOffloadStatus,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: ColorResources.mainColor,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              child: Text(
                                getTranslated("actions", context)!,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                riskProvider.actionsList==null?Visibility(
                                  visible: false, // set true if no actions
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      "No actions added yet",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                  ),
                                ):
                                riskProvider.actionsList!.isEmpty?Visibility(
                                  visible: false, // set true if no actions
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      "No actions added yet",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                  ),
                                ):
                                ListView.builder(
                                  itemCount: riskProvider.actionsList!.length,
                                  itemBuilder: (context, index) {
                                    return RiskActionItem(
                                      action: riskProvider.actionsList![index],
                                      currentUserId: Provider.of<ProfileController>(context,listen: false).userProfileData!.id.toString(),
                                      userRole: Provider.of<ProfileController>(context,listen: false).userProfileData!.role.toString(),
                                    );
                                  },
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),

                      // Floating Action Button
                      Positioned(
                        bottom: 16,
                        right: 16,
                        child: Visibility(
                          visible: true, // set to control FAB visibility
                          child: FloatingActionButton(
                            backgroundColor: ColorResources.mainColor,
                            onPressed: () {
                              routePush(context, ProfileAddActionsScreen(wayFrom: "add"));
                            },
                            child: Icon(Icons.add,color: ColorResources.white,size: 40,),
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

    );
  }
}
