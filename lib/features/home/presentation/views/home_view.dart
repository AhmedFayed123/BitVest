import 'package:bitvest/features/home/presentation/views/widgets/drawer_body.dart';
import 'package:bitvest/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constant/colors.dart';
import '../../../market/presentation/views/market_view.dart';
import '../../../trade/presentation/views/Trade_view.dart';
import '../../../wallet/presentation/views/wallet_view.dart';
import '../controllers/navigation_bar_controller/bottom_nav_controller.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final BottomNavController _bottomNavController =
      Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomeViewBody(
        scaffoldKey: scaffoldKey,
      ),
      MarketView(),
      TradeView(coinId: 'bitcoin',),
      WalletView(),
    ];
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: DrawerBody(),
        body: Obx(() => _pages[_bottomNavController.selectedIndex.value]),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            selectedItemColor: kAmberColor,
            currentIndex: _bottomNavController.selectedIndex.value,
            onTap: _bottomNavController.updateIndex,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                backgroundColor: kPrimaryColor,
                icon: Icon(Icons.home),
                label: "Home".tr,
              ),
              BottomNavigationBarItem(
                backgroundColor: kPrimaryColor,
                icon: Icon(Icons.show_chart),
                label: "Market".tr,
              ),
              BottomNavigationBarItem(
                backgroundColor: kPrimaryColor,
                icon: Icon(Icons.swap_horiz),
                label: "Trade".tr,
              ),
              BottomNavigationBarItem(
                backgroundColor: kPrimaryColor,
                icon: Icon(Icons.account_balance_wallet),
                label: "Wallet".tr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
