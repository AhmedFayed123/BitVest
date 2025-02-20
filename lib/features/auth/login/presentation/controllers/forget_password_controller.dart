import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constant/strings.dart';
import '../../../../../core/services/service_locator.dart';
import '../../data/repos/login_repo/login_repo.dart';

class ForgotPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailOrPhoneController = TextEditingController();
  var isLoading = false.obs;

  void sendResetLink() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      final result =
      await sl<LoginRepo>().forgetPassword(emailOrPhoneController.text);

      result.fold(
            (failure) => Get.snackbar('Error', failure.message, snackPosition: SnackPosition.BOTTOM),
            (message) {
          Get.snackbar('Success', Strings.verificationSent, snackPosition: SnackPosition.BOTTOM);
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
