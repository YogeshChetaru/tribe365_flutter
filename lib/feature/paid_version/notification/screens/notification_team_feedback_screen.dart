import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/common/basewidget/custom_header_back_widget.dart';
import 'package:tribe365_new/feature/paid_version/notification/controllers/notification_controller.dart';
import 'package:tribe365_new/feature/paid_version/notification/widgets/team_feedback_list_screen.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';

class NotificationTeamFeedbackScreen extends StatefulWidget {
  final int userId;
  final String date;
  final int teamId;
  const NotificationTeamFeedbackScreen({super.key,
    required this.userId,
  required this.date,
  required this.teamId});

  @override
  NotificationTeamFeedbackScreenState createState() => NotificationTeamFeedbackScreenState();
}

class NotificationTeamFeedbackScreenState extends State<NotificationTeamFeedbackScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    loadAPI();
    super.initState();
  }

  void loadAPI() {
    NotificationController controller = Provider.of<NotificationController>(context, listen: false);
    if (widget.date!="") {
     controller.getFeedbackUserAnswerStatus(widget.userId.toString(),widget.date);
    } else {
      controller.viewIndividualQuestionnaireAPI(widget.userId.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Consumer<NotificationController>(builder: (context, notificationProvider, _) {
          return Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            color: ColorResources.screenBg,
            child: Column(
              children: [
                CustomHeaderBack(
                  title: getTranslated("team_feedback", context)!,
                ),
                SizedBox(
                  height: 20,
                ),
                notificationProvider.isLoading?
                Expanded(
                  flex: 1,child: SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ):
                Expanded(
                    flex: 1,
                    child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Text(
                        notificationProvider.teamTitle,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                    if(notificationProvider.teamQuestionStatus)
                      Expanded(flex: 1,child: TeamFeedbackListScreen())
                  ],
                ))
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: SafeArea(
          child: Consumer<NotificationController>(builder: (context, notProvider, _) {
        return  notProvider.isLoading==true?
        SizedBox.shrink() :
        notProvider.isLoadingBtn==true?
        Container(
          height: 70,
          color: ColorResources.white,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
            ),
          ),
        ) :
        notProvider.teamQuestionStatus?
        Container(
          width: MediaQuery.sizeOf(context).width,
          height: 70,
          color: ColorResources.white,
          child: InkWell(
            onTap: () {
              notProvider.validateAndSubmit(context,widget.userId.toString(),widget.date,widget.teamId.toString());
            },
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.sizeOf(context).width,
              margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
              decoration: BoxDecoration(
                color: ColorResources.mainColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
              ),
              child: Text(
                getTranslated("submit", context)!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: Dimensions.sp16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          ),
        ):SizedBox.shrink();
      })),
    );
  }
}



