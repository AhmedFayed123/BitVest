import 'package:bitvest/features/onboarding/presentation/views/widgets/welcome_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Locale/Locale_Controller.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/constant/icons.dart';
import '../../../../core/constant/sizes.dart';
import '../../../../core/constant/strings.dart';
import '../../../../core/resources/images.dart';
import '../../../auth/login/presentation/views/login_screen.dart';
import '../../../auth/register/presentation/views/sign_up_screen.dart';



class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       // Toggle between English and Arabic
        //
        //     },
        //     icon: Icon(AppIcons.themeIcon, size: Sizes.iconSizeLarge,),
        //     color: kWhiteColor,
        //   ),
        // ],
        leading: IconButton(
          onPressed: () {
            showLanguageSelectionSheet();
          },
          icon: Icon(AppIcons.language, size: Sizes.iconSizeLarge,),
          color: kWhiteColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.paddingMedium),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: Sizes.spaceLargest),
              Image.asset(Images.welcomeImage),
              SizedBox(height: Sizes.kVerticalSpacing),
              Text(
                'appDescription'.tr,
                style: TextStyle(
                  color: kWhiteColor,
                  fontSize: Sizes.kHeadingSize,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: Sizes.spaceLargest),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  WelcomeButton(
                    text: Strings.signUp,
                    onPressed: () => Get.to(() => const SignUpScreen()),
                    isOutlined: true,
                  ),
                  WelcomeButton(
                    text: Strings.login,
                    onPressed: () => Get.to(() => const LoginScreen()),
                  ),
                ],
              ),
              SizedBox(height: Sizes.kButtonSpacing),
            ],
          ),
        ),
      ),
    );
  }
  void showLanguageSelectionSheet() {
    MyLocaleController controllerLang = Get.find<MyLocaleController>();

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Get.isDarkMode ? Colors.grey[900] : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Language'.tr,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.language, color: Colors.blue),
              title: const Text('English'),
              onTap: () {
                controllerLang.changeLang('en');
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.language, color: Colors.green),
              title: const Text('العربية'),
              onTap: () {
                controllerLang.changeLang('ar');
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
