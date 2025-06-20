import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import 'package:tribe365_new/utill/custom_route.dart';
import '../../../../common/basewidget/custom_header_back_widget.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../main.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/know_controller.dart';
import '../domain/models/view_kudos_award_response.dart';
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
    KnowController knowController = Provider.of<KnowController>(context,listen: false);
    knowController.viewUserByTypeList().then((onValue){
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
            child: Stack(
              children: [
                Column(
                  children: [
                    CustomHeaderBack(title: getTranslated("kudos_awards", context)!),
                    Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
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
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () =>  customShowDialog(context, KnowUserListDialog(wayFrom: "user",)),
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

                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: knowProvider.groupedAwards.isNotEmpty
                                        ? ListView.builder(
                                      itemCount: knowProvider.groupKudosList.length,
                                      itemBuilder: (context, index) {
                                        final group = knowProvider.groupKudosList[index];
                                        return AwardGroupCard(
                                          group: group,
                                          onGroupTap: (awardValue, userList) {
                                            showDialog(
                                              context: context,
                                              builder: (_) => AlertDialog(
                                                title: Text(awardValue),
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: userList
                                                      .map((e) => ListTile(
                                                    leading: CircleAvatar(
                                                      backgroundImage: NetworkImage(e.userImage!),
                                                    ),
                                                    title: Text(e.userName!),
                                                  ))
                                                      .toList(),
                                                ),
                                              ),
                                            );
                                          },
                                            knowController:knowProvider
                                        );
                                      },
                                    )
                                        : const Center(
                                      child: Text(
                                        "No awards yet",
                                        style: TextStyle(fontSize: 16, color: Colors.grey, fontFamily: 'Roboto'),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  void showDialog1(BuildContext context, Widget workNotDialog) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        barrierColor: Colors.black54,
        pageBuilder: (context, animation, secondaryAnimation) {
          return Center(child: workNotDialog);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // From right
          const end = Offset(-1.0, 0.0); // To left when popping
          final tween = Tween(begin: begin, end: Offset.zero);
          final reverseTween = Tween(begin: Offset.zero, end: end);
          final offsetAnimation = animation.drive(tween);
          final reverseOffset = secondaryAnimation.drive(reverseTween);

          return SlideTransition(
            position: animation.status == AnimationStatus.reverse ? reverseOffset : offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }
}
class AwardGroupCard extends StatelessWidget {
  final GroupKudosList group;
  final Function(String awardValue, List<ViewKudosAwardData> userList) onGroupTap;
 final KnowController knowController;
  const AwardGroupCard({
    super.key,
    required this.group,
    required this.onGroupTap,
    required this.knowController
  });

  @override
  Widget build(BuildContext context) {
    final first = group.kudosAwardLists.first;

    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          if (group.kudosAwardLists.length > 1) {
            onGroupTap(first.awardValue!, group.kudosAwardLists);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                first.awardDescription!,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              if (first.awardValue!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    first.awardValue!,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              const SizedBox(height: 8),
              Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundImage: NetworkImage(first.userImage!),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      group.kudosAwardLists.length > 1
                          ? '${first.userName} & ${group.kudosAwardLists.length - 1} more'
                          : first.userName!,
                      style: const TextStyle(fontSize: 14),
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  knowController.getDate(first.awardDate!),
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

