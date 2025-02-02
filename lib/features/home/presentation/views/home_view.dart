import 'package:bitvest/features/home/presentation/views/widgets/drawer_body.dart';
import 'package:bitvest/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constant/colors.dart';
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
      HomeViewBody(scaffoldKey: scaffoldKey,),
      Center(child: Text('Market Page',style: TextStyle(color: kWhiteColor),)),
      Center(child: Text('Trade Page',style: TextStyle(color: kWhiteColor),)),
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
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                backgroundColor: kPrimaryColor,
                icon: Icon(Icons.home),
                label: "Home",
              ),

              BottomNavigationBarItem(
                backgroundColor: kPrimaryColor,
                icon: Icon(Icons.show_chart),
                label: "Market",
              ),
              BottomNavigationBarItem(
                backgroundColor: kPrimaryColor,
                icon: Icon(Icons.swap_horiz),
                label: "Trade",
              ),
              BottomNavigationBarItem(
                backgroundColor: kPrimaryColor,
                icon: Icon(Icons.account_balance_wallet),
                label: "Wallet",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
