import 'package:bitvest/features/onboarding/presentation/views/widgets/welcome_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../Locale/Locale_Controller.dart';
import '../../../../core/components/functons/show_language_selection_sheet.dart';
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
      body: Padding(
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
                  text: Strings.signUp.tr,
                  onPressed: () => Get.to(() => const SignUpScreen()),
                  isOutlined: true,
                ),
                WelcomeButton(
                  text: Strings.login.tr,
                  onPressed: () => Get.to(() => const LoginScreen()),
                ),
              ],
            ),
            SizedBox(height: Sizes.kButtonSpacing),
          ],
        ),
      ),
    );
  }
}
