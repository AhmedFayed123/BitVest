import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Locale/Locale_Controller.dart';
import '../../../features/onboarding/presentation/views/widgets/welcome_button.dart';

void showLanguageSelectionSheet() {
  MyLocaleController controllerLang = Get.find<MyLocaleController>();

  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          SizedBox(height: 10.h),
          WelcomeButton(
            text: 'English',
            onPressed: () {
              controllerLang.changeLang('en');
              Get.back();              },
          ),
          SizedBox(height: 10.h),
          WelcomeButton(
            text: 'العربية',
            onPressed: () {
              controllerLang.changeLang('ar');
              Get.back();           },
          ),
          SizedBox(height: 10.h),
        ],
      ),
    ),
  );
}
