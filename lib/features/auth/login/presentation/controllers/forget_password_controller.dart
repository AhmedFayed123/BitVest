import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/services/service_locator.dart';
import '../../data/repos/login_repo/login_repo.dart';
import '../views/Otp_screen.dart';

class ForgotPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailOrPhoneController = TextEditingController();
  var isLoading = false.obs;

  void sendResetLink() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      final result = await sl<LoginRepo>().forgetPassword(emailOrPhoneController.text);

      result.fold(
            (failure) {
          Get.snackbar('Error', failure.message, snackPosition: SnackPosition.BOTTOM);
        },
            (message) {
          Get.snackbar('Success', 'OTP sent successfully!', snackPosition: SnackPosition.BOTTOM);

          Get.to(() => OtpScreen(email: emailOrPhoneController.text,));
        },
      );
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
