import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../../../core/services/storage_service.dart';
import '../../../../onboarding/presentation/views/welcome_screen.dart';
import '../../../../profile/presentation/controller/profile_controller.dart';
import '../../../../profile/presentation/views/profile_view.dart';
import '../../../../settings/presentation/views/settings.dart';
import 'PrivacyPolicyScreen.dart';

class DrawerBody extends StatelessWidget {
  const DrawerBody({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Drawer(
      child: Container(
        color: kBackgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Obx(() {
              if (controller.isLoading.value) {
                return Skeletonizer(
                  enabled: true,
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: kBackgroundColor),
                    accountName: Container(width: 120, height: 20, color: Colors.white),
                    accountEmail: Container(width: 180, height: 16, color: Colors.white),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.account_circle, size: 50.0),
                    ),
                  ),
                );
              } else if (controller.errorMessage.value != null) {
                return UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: kBackgroundColor),
                  accountName: Text(
                    "Error",
                    style: TextStyle(color: Colors.red),
                  ),
                  accountEmail: Text(
                    controller.errorMessage.value!,
                    style: TextStyle(color: Colors.red),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.error, color: Colors.red, size: 50.0),
                  ),
                );
              } else if (controller.profile.value != null) {
                return UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: kBackgroundColor),
                  accountName: Text(
                    controller.profile.value!.name??'',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  accountEmail: Text(
                    controller.profile.value!.email??'',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.account_circle, size: 50.0),
                  ),
                );
              } else {
                return UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: kBackgroundColor),
                  accountName: Text(
                    "No Data",
                    style: TextStyle(color: Colors.grey),
                  ),
                  accountEmail: Text(
                    "No email available",
                    style: TextStyle(color: Colors.grey),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.account_circle, size: 50.0),
                  ),
                );
              }
            }),
            ListTile(
              leading: Icon(Icons.person, color: Colors.blue),
              title: Text('Edit Profile', style: TextStyle(color: Colors.white)),
              onTap: () {
                Get.to(ProfileView());
              },
            ),
            ListTile(
              leading: Icon(Icons.trending_up, color: Colors.green),
              title: Text('Trending Up', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.account_balance, color: Colors.purple),
              title: Text('My Wallet', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.attach_money, color: Colors.orange),
              title: Text('Transactions', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.bar_chart, color: Colors.red),
              title: Text('Charts', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.security, color: Colors.blueGrey),
              title: Text('Security', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.grey),
              title: Text('Settings', style: TextStyle(color: Colors.white)),
              onTap: () {
                Get.to(SettingsScreen());
              },
            ),
            ListTile(
              leading: Icon(Icons.help, color: Colors.blue),
              title: Text('Help', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.article, color: Colors.black),
              title: Text('Terms & Conditions', style: TextStyle(color: Colors.white)),
              onTap: () {
                Get.to(PrivacyPolicyScreen());
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.red),
              title: Text('Logout', style: TextStyle(color: Colors.white)),
              onTap: () async {
                bool? confirmLogout = await Get.defaultDialog(
                  title: "Logout",
                  middleText: "Are you sure you want to log out?",
                  textConfirm: "Yes",
                  textCancel: "No",
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    Get.back(result: true);
                  },
                  onCancel: () {
                    Get.back(result: false);
                  },
                );

                if (confirmLogout == true) {
                  await sl<StorageService>().logOut();
                  Get.offAll(WelcomeScreen());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
