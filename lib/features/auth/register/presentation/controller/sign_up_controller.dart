import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/components/functons/show_bottom_dialog.dart';
import '../views/set_password_screen.dart';
import '../views/verification_screen.dart';

class SignUpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailOrPhoneController = TextEditingController();
  final TextEditingController verificationCodeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;
  var isChecked = false.obs;

  final RxBool isLoading = false.obs;

  void validateAndProceed() {
    if (!isChecked.value) {
      Get.snackbar(
        'Error',
        'You must accept the Terms of Use and Privacy Policy to continue.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      // Proceed with registration logic
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void sendVerificationCode() {
    if (formKey.currentState?.validate() ?? false) {
      isLoading.value = true;
      Future.delayed(const Duration(seconds: 2), () {
        isLoading.value = false;
        Get.to(() => const VerificationScreen());
      });
    }
  }

  void verifyCode() {
    // Add your OTP verification logic here
    String verificationCode = verificationCodeController.text;

    if (verificationCode.isEmpty || verificationCode.length < 6) {
      Get.snackbar(
        'Error',
        'Please enter a valid verification code.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Proceed to set password screen after successful verification
    Get.to(() => const SetPasswordScreen());
  }

  void signUp(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      if (passwordController.text != confirmPasswordController.text) {
        Get.snackbar('Error', 'Passwords do not match.');
        return;
      }
      isLoading.value = true;
      Future.delayed(const Duration(seconds: 2), () {
        isLoading.value = false;
        showSuccessBottomDialog(context);
      });
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailOrPhoneController.dispose();
    verificationCodeController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
