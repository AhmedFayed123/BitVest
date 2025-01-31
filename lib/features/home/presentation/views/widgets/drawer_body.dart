import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../onboarding/presentation/views/welcome_screen.dart';
import '../../../../profile/presentation/views/profile_view.dart';
import '../../../../settings/presentation/views/settings.dart';
import 'PrivacyPolicyScreen.dart';

class DrawerBody extends StatelessWidget {
  const DrawerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: kBackgroundColor, // Set the background color
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: kBackgroundColor),
              accountName: Text('Ahmed Hesham'),
              accountEmail: Text('ahmed@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.account_circle, size: 50.0),
              ),
            ),
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
              title:
                  Text('Transactions', style: TextStyle(color: Colors.white)),
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
              title: Text('Terms & Conditions',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Get.to(PrivacyPolicyScreen());
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.red),
              title: Text('Logout', style: TextStyle(color: Colors.white)),
              onTap: () {
                Get.offAll(WelcomeScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
