import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/components/functons/show_language_selection_sheet.dart';
import '../../../../core/constant/colors.dart';
import '../../../onboarding/presentation/views/welcome_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(color: Colors.white, fontSize: 25,)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white, size: 30,),
          onPressed: () {
            Navigator.pop(context);
          },

        ),

      ),

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            SizedBox(height: 13),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.account_circle, color: Colors.white, size: 24.sp,),
              title: const Text('Profile', style: TextStyle(color: Colors.white, fontSize: 23)),
              onTap: () {},
            ),
            SizedBox(height: 14.h),
            const Divider(color: Colors.white),

            // Language section
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.language, color: Colors.white, size: 24.sp,),
              title: const Text('Language', style: TextStyle(color: Colors.white, fontSize: 23)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
              onTap: () {
                showLanguageSelectionSheet();
              },
            ),
            SizedBox(height: 14),
            const Divider(color: Colors.white),

            // Theme section
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.notifications, color: Colors.white, size: 24.sp,),
              title: const Text('Notifications', style: TextStyle(color: Colors.white, fontSize: 23)),
              trailing: Switch(
                value: true,
                onChanged: (value) {
                },
                activeColor: Colors.yellow,
              ),
              onTap: () {},
            ),
            SizedBox(height: 14),
            const Divider(color: Colors.white),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.lock, color: Colors.white, size: 24.sp,),
              title: const Text('Change Password', style: TextStyle(color: Colors.white, fontSize: 23,)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
              onTap: () {},
            ),
            SizedBox(height: 14),

            const Divider(color: Colors.white),

            SizedBox(height: 100),
            Center(

              child: GestureDetector(
                onTap: () {
                  Get.offAll(WelcomeScreen());
                },
                child: Container(
                  width: 100,
                  height: 105,
                  decoration: BoxDecoration(
                    color: kBackgroundColor,

                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.5),
                        blurRadius: 20,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.exit_to_app,
                        color: Colors.red,
                        size: 40,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
