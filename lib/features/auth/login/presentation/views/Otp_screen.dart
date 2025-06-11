import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/components/widgets/custom_button.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/sizes.dart';
import '../../../../../core/constant/strings.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../register/data/repos/signup_repo/signup_repo.dart';
import '../controllers/Otp_controller.dart';


class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    final OtpController controller = Get.put(OtpController(signupRepo: sl<SignupRepo>(), email: email));

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kWhiteColor),
        title: Text(
          Strings.otpVerification.tr,
          style: TextStyle(color: kWhiteColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.paddingLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                Strings.enterOtpCode.tr,
                style: TextStyle(color: kWhiteColor, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Sizes.spaceLarge),
              OtpTextField(
                numberOfFields: 6,
                borderColor: kBorderColor,
                focusedBorderColor: kAmberColor,
                textStyle: const TextStyle(color: kWhiteColor),
                showFieldAsBox: true,
                fieldWidth: 45.0.w,
                onCodeChanged: (String code) {
                  controller.updateOtp(code);
                },
                onSubmit: (String verificationCode) {
                  controller.updateOtp(verificationCode);
                  print('✅ OTP Submitted: $verificationCode');
                  controller.verifyOtp();
                },
              ),


              SizedBox(height: Sizes.spaceLarge),
              Obx(() => CustomButton(
                text: Strings.verify.tr,
                onPressed: controller.isLoading.value
                    ? (){}
                    : controller.verifyOtp,
                isLoading: controller.isLoading.value,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
