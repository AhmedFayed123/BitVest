import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constant/strings.dart';

import '../../../register/data/models/register_models.dart';
import '../../../register/data/repos/signup_repo/signup_repo.dart';
import '../views/reset_password_screen.dart';

class OtpController extends GetxController {
  final SignupRepo signupRepo;
  final String email;
  OtpController({required this.signupRepo,required this.email});

  var otpCode = ''.obs;
  var isLoading = false.obs;
  final TextEditingController otpController = TextEditingController();

  void updateOtp(String code) {
    otpCode.value = code;
  }

  Future<void> verifyOtp() async {
    String verificationCode = otpCode.value.trim();

    if (verificationCode.isEmpty || verificationCode.length < 6) {

      Get.snackbar(
        'Error',
        Strings.kOtpValidation,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;

    final result = await signupRepo.verifyOtp(VerifyOtpRequest(
      email: email,
      otp: verificationCode,
    ));

    isLoading.value = false;

    result.fold(
          (failure) {
        Get.snackbar(
          'Error',
          failure.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
          (response) {
        if (response['message'] == "Email verified. Set your password now.") {
          Get.off(() => ResetPasswordScreen(email: email,));
        } else {
          Get.snackbar(
            'Error',
            'Invalid OTP.',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      },
    );
  }
}
