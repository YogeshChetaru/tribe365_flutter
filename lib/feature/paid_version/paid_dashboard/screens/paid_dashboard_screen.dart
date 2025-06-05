import 'package:flutter/material.dart';
import 'package:tribe365_new/feature/paid_version/home/screens/home_screen.dart';
import 'package:tribe365_new/feature/paid_version/know/screens/know_screen.dart';
import 'package:tribe365_new/feature/paid_version/offloading/screens/offloading_screen.dart';
import 'package:tribe365_new/feature/paid_version/profile/screens/profile_screen.dart';
import 'package:tribe365_new/feature/paid_version/risk/screens/risk_screen.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../main.dart';
import '../../../../utill/images.dart';
import '../domain/models/navigation_model.dart';
import '../widgets/app_exit_card_widget.dart';
import '../widgets/dashboard_menu_widget.dart';

class PaidDashboardScreen extends StatefulWidget {
  const PaidDashboardScreen({super.key});

  @override
  PaidDashboardScreenState createState() => PaidDashboardScreenState();
}

class PaidDashboardScreenState extends State<PaidDashboardScreen> {
  int _pageIndex = 0;
  late List<NavigationModel> _screens;

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
    _screens = [
      NavigationModel(name: getTranslated('home', context).toString(), icon: Images.imgNavHomeGray, screen: const HomeScreen()),
      NavigationModel(name: getTranslated('know', context).toString(), icon: Images.imgNavKnowGray, screen: const KnowScreen()),
      NavigationModel(name: getTranslated('offloading', context).toString(), icon: Images.imgNavOffloadingGray, screen: const OffLoadingScreen()),
      NavigationModel(name: getTranslated('risk', context).toString(), icon: Images.imgNavRiskRed, screen: const RiskScreen()),
      NavigationModel(name: getTranslated('profile', context).toString(), icon: Images.imgNavProfileGray, screen: const ProfileScreen()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (_pageIndex != 0) {
          _setPage(0);
          return;
        } else {
          if (didPop == false) {
            Future.delayed(Duration.zero, () {
              showModalBottomSheet(backgroundColor: Colors.transparent, context: Get.context!, builder: (_) => const AppExitCard());
            });
          }
        }
      },

      child: Scaffold(
          key: _scaffoldKey,
          body: PageStorage(bucket: bucket, child: _screens[_pageIndex].screen),
          bottomNavigationBar: SafeArea(
              top: false,child: Container(
                height: 68,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  boxShadow: [BoxShadow(offset: const Offset(1, 1), blurRadius: 2, spreadRadius: 1, color: Theme.of(context).primaryColor.withAlpha(32))],
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: _getBottomWidget())),
          )),
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageIndex = pageIndex;
    });
  }

  List<Widget> _getBottomWidget() {
    List<Widget> list = [];
    for (int index = 0; index < _screens.length; index++) {
      list.add(Expanded(child: CustomMenuWidget(isSelected: _pageIndex == index, name: _screens[index].name, icon: _screens[index].icon, onTap: () => _setPage(index))));
    }
    return list;
  }
}
