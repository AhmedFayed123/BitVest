import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../../../../../core/components/widgets/custom_button.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/sizes.dart';
import '../../../../../core/constant/strings.dart';
import '../../../../../core/constant/styles.dart';
import '../../../../../core/resources/images.dart';
import '../controller/sign_up_controller.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    final SignUpController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // iconTheme: const IconThemeData(color: kWhiteColor),
        title: const Text(Strings.verifyCode,
            style: TextStyle(color: kWhiteColor)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.paddingLarge),
          child: Column(
            children: [
              Image.asset(
                Images.appLogo, // Ensure the path is correct
                height: Sizes.iconAuthLarge,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    Images.appLogo, // Path to your logo image
                    width: Sizes.iconSizeLarge, // Set the width of the logo
                    height: Sizes.iconSizeLarge, // Set the height of the logo
                  ),
                  Center(
                    child: Text(
                      Strings.appName,
                      style: AppStyles.regularTextStyle.copyWith(
                        color: kWhiteColor, // Override color for error text
                        fontWeight: FontWeight.bold, // Bold the message
                        fontSize:
                            Sizes.fontSizeLarge, // Use the correct font size
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Sizes.spaceMedium,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
                child: Text(
                  email,
                  style: AppStyles.textStyle14regular,
                ),
              ),
              // OTP Text Field
              OtpTextField(
                numberOfFields: 6,
                borderColor: kBorderColor,
                focusedBorderColor: kAmberColor,
                textStyle: const TextStyle(color: kWhiteColor),
                showFieldAsBox: true,
                fieldWidth: 45.0.w,
                onSubmit: (String verificationCode) {
                  // You can use the verification code here
                  controller.verificationCodeController.text = verificationCode;
                  controller.verifyCode();
                },
              ),
              SizedBox(height: Sizes.spaceLarge),
              // Button to verify the code
              CustomButton(
                text: Strings.verify,
                onPressed: controller.verifyCode,
                isLoading: controller.isLoading.value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
