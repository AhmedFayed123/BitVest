import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constant/strings.dart';
import '../../../../../core/services/service_locator.dart';
import '../../data/models/login_model/reset_password_request.dart';
import '../../data/repos/login_repo/login_repo.dart';
import '../views/login_screen.dart';

class ResetPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;
  String? email;
  String? token;

  @override
  void onInit() {
    super.onInit();
    email = Get.parameters['email'];
    token = Get.parameters['token'];
  }

  void resetPassword() async {
    if (!formKey.currentState!.validate()) return;
    if (email == null || token == null) {
      Get.snackbar('Error', 'Invalid reset link',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;
    try {
      final request = ResetPasswordRequest(
        email: email!,
        password: newPasswordController.text,
        passwordConfirmation: confirmPasswordController.text,
        token: token!,
      );
      final result = await sl<LoginRepo>().resetPassword(request);
      result.fold(
        (failure) => Get.snackbar('Error', failure.message,
            snackPosition: SnackPosition.BOTTOM),
        (message) {
          Get.snackbar('Success', Strings.passwordResetSuccess,
              snackPosition: SnackPosition.BOTTOM);
          Get.offAll(() => const LoginScreen());
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
