import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constant/strings.dart';
import '../views/login_screen.dart';

class ResetPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  var isLoading = false.obs;

  void resetPassword() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      // Call API to reset the password
      await Future.delayed(const Duration(seconds: 2)); // Simulate API delay
      Get.snackbar('Success', Strings.passwordResetSuccess, snackPosition: SnackPosition.BOTTOM);
      Get.offAll(() => const LoginScreen()); // Navigate back to Login Screen
    } catch (e) {
      Get.snackbar('Error', Strings.failedToResetPassword, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
