import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constant/strings.dart';
import '../../../../home/presentation/views/home_view.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;

  final TextEditingController emailOrPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void login() async {
    if (!formKey.currentState!.validate()) {
      return; // لا تكمل إذا لم تكن الحقول صحيحة
    }

    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;

    // التحقق من بيانات تسجيل الدخول (كمثال بسيط)
    if ((emailOrPhoneController.text == "admin@gmail.com" || emailOrPhoneController.text == "1234567890") &&
        passwordController.text == "123456") {
      Get.snackbar('Success', Strings.loginSuccess, backgroundColor: Colors.green);
      // يمكنك الانتقال إلى الشاشة التالية
      Get.to(HomeView());
    } else {
      Get.snackbar('Error', Strings.errorMessage, backgroundColor: Colors.red);
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}
