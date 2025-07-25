import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/custom_route.dart';
import '../../../../common/basewidget/custom_header_back_widget.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../main.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/know_controller.dart';
import '../widgets/award_group_card.dart';
import '../widgets/show_group_user_dialog.dart';
import 'knowuserlistdialog.dart';

class KudosAwardsScreen extends StatefulWidget {
  const KudosAwardsScreen({super.key});

  @override
  KudosAwardsScreenState createState() => KudosAwardsScreenState();
}

class KudosAwardsScreenState extends State<KudosAwardsScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  ProfileController profileController = Provider.of<ProfileController>(Get.context!, listen: false);

  @override
  void initState() {
    super.initState();
    loadAPI();
  }

  void loadAPI() {
    KnowController knowController = Provider.of<KnowController>(context, listen: false);
    knowController.viewUserByTypeList().then((onValue) {
      knowController.viewKudosAward("");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Consumer<KnowController>(builder: (context, knowProvider, _) {
          return Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            color: ColorResources.screenBg,
            child: Column(
              children: [
                CustomHeaderBack(title: getTranslated("kudos_awards", context)!),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () => customShowDialog(
                        context,
                        KnowUserListDialog(
                          wayFrom: "user",
                        )),
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            knowProvider.selectedUserName,
                            style: const TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: knowProvider.isLoading
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            knowProvider.groupKudosList.isNotEmpty
                                ? Expanded(
                                    flex: 1,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: knowProvider.groupKudosList.length,
                                      itemBuilder: (context, index) {
                                        final group = knowProvider.groupKudosList[index];
                                        return AwardGroupCard(
                                            group: group,
                                            onGroupTap: (awardValue, userList) {
                                              showGroupUserDialog(
                                                context,
                                                awardValue,
                                                userList,
                                              );
                                            },
                                            knowController: knowProvider);
                                      },
                                    ),
                                  )
                                : Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        getTranslated("no_awards_yet", context)!,
                                        style: TextStyle(fontSize: 16, color: Colors.grey, fontFamily: 'Roboto'),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )
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
