import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/common/basewidget/custom_header_widget.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../controllers/risk_controller.dart';
import '../widgets/build_buttons_row.dart';
import '../widgets/build_drop_down.dart';
import '../widgets/build_risk_list_or_message.dart';

class RiskScreen extends StatefulWidget {
  const RiskScreen({super.key});

  @override
  RiskScreenState createState() => RiskScreenState();
}

class RiskScreenState extends State<RiskScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    loadAPI();
    super.initState();
  }

  void loadAPI() {
    RiskController controller = Provider.of<RiskController>(context, listen: false);
    controller.updateIsType("ongoing", false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Consumer<RiskController>(builder: (context, riskProvider, _) {
          return Stack(
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                color: ColorResources.screenBg,
                child: Column(
                  children: [
                    CustomHeader(),
                    const SizedBox(height: 20),
                    if (riskProvider.swotList != null) buildDropdown(riskProvider),
                    buildButtonsRow(riskProvider, context),
                    Expanded(
                      child: buildRiskListOrMessage(riskProvider),
                    ),
                  ],
                ),
              ),
              if (riskProvider.isLoading)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.4),
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }






}
