import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/localization/language_constrants.dart';

import '../../../../main.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../controllers/home_controller.dart';
import '../widgets/belief_horizontal_list.dart';

class DotDetailsScreen extends StatefulWidget {
  const DotDetailsScreen({super.key});

  @override
  DotDetailsScreenState createState() => DotDetailsScreenState();
}

class DotDetailsScreenState extends State<DotDetailsScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    apiLoad();
    super.initState();
  }
  void apiLoad() {
    HomeController homeController = Provider.of<HomeController>(Get.context!, listen: false);
    homeController.getDotDetails();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Consumer<HomeController>(builder: (context, homeProvider, _) {
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
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            Images.imgCircleBackRed,
                            width: 24,
                            height: 24,
                          )),
                      Expanded(child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "",
                          style: TextStyle(
                            fontSize: Dimensions.sp18,
                            fontWeight:FontWeight.w600,
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
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: homeProvider.isPopupLoading?
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height/1.5,
                      width: MediaQuery.sizeOf(context).width,
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ) :
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSection(
                          context,
                          title: 'VISION',
                          evidenceVisible: false,
                          content: homeProvider.dotDetailsData!.vision!,
                        ),
                        const SizedBox(height: 10),
                        _buildSection(
                          context,
                          title: 'MISSION',
                          evidenceVisible: false,
                          content: homeProvider.dotDetailsData!.mission!,
                        ),
                        const SizedBox(height: 10),
                        _buildSection(
                          context,
                          title: 'FOCUS',
                          evidenceVisible: false,
                          content: homeProvider.dotDetailsData!.focus!,
                        ),
                        const SizedBox(height: 10),
                        homeProvider.beliefList==null?
                         Text(
                          getTranslated("belief_and_values_are_not_available", context)!,
                          style: TextStyle(fontFamily: 'Roboto', fontSize: 14),
                        ):
                        homeProvider.beliefList!.isEmpty?
                         Text(
                           getTranslated("belief_and_values_are_not_available", context)!,
                          style: TextStyle(fontFamily: 'Roboto', fontSize: 14),
                        ):
                        _buildBeliefEvidenceRow(context),
                        const SizedBox(height: 10),
                        BeliefHorizontalList(
                          beliefs: homeProvider.beliefList!,
                        ),
                        const SizedBox(height: 10),
                        _buildValueEvidenceRow(context),
                        const SizedBox(height: 10),
                        _buildHorizontalList(title: 'Values'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
  Widget _buildSection(BuildContext context, {required String title, required bool evidenceVisible, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontFamily: 'RobotoMedium', fontSize: 14, color: Colors.black),
            ),
            if (evidenceVisible)
              Row(
                children: [
                  IconButton(icon: const Icon(Icons.add, color: Colors.red), onPressed: () {}),
                  Container(width: 0.5, height: 20, color: Colors.grey),
                  IconButton(icon: const Icon(Icons.remove_red_eye, color: Colors.red), onPressed: () {}),
                ],
              )
          ],
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          margin: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(
            content,
            style: const TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.black87),
          ),
        )
      ],
    );
  }

  Widget _buildBeliefEvidenceRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('BELIEF', style: TextStyle(fontFamily: 'RobotoMedium', fontSize: 16)),
      ],
    );
  }

  Widget _buildValueEvidenceRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('VALUE', style: TextStyle(fontFamily: 'RobotoMedium', fontSize: 16)),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey.shade200,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          child: const Text(
            'EVIDENCE',
            style: TextStyle(color: Colors.black, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontalList({required String title}) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) => Container(
          width: 100,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade100,
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Center(child: Text('$title $index')),
        ),
      ),
    );
  }


}

