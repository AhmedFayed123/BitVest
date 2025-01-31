import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../features/auth/login/presentation/views/login_screen.dart';
import '../../constant/colors.dart';
import '../../constant/strings.dart';
import '../../constant/styles.dart';
import '../widgets/custom_button.dart';

void showSuccessBottomDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0.r),
        topRight: Radius.circular(20.0.r),
      ),
    ),
    backgroundColor: kBackgroundColor,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.all(30.0.w),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle_outline_rounded,
              color: kAmberColor,
              size: 80,
            ),
            SizedBox(height: 10.h),
            Text(
              Strings.successSignUp,
              textAlign: TextAlign.center,
              style: AppStyles.headingStyle.copyWith(color: kPrimaryTextColor),
            ),
            SizedBox(height: 26.h),
            CustomButton(
              text: Strings.login,
              onPressed: () => Get.offAll(() => const LoginScreen()),
            ),
          ],
        ),
      );
    },
  );
}
