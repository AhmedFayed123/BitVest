import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constant/strings.dart';
import '../views/Otp_screen.dart';

class ForgotPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailOrPhoneController = TextEditingController();
  var isLoading = false.obs;

  void sendResetLink() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      // Call API to send reset link or OTP
      await Future.delayed(const Duration(seconds: 2)); // Simulate API delay
      Get.snackbar('Success', Strings.verificationSent,
          snackPosition: SnackPosition.BOTTOM);
      Get.to(() => const OtpScreen()); // Navigate to OTP Screen
    } catch (e) {
      Get.snackbar('Error', Strings.failedToSend,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailOrPhoneController.dispose();
    super.onClose();
  }
}
