import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../login/presentation/views/login_screen.dart';
import '../../data/models/register_models.dart';
import '../../data/repos/signup_repo/signup_repo.dart';
import '../views/set_password_screen.dart';
import '../views/verification_screen.dart';

class SignUpController extends GetxController {
  final SignupRepo signupRepo = sl<SignupRepo>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController verificationCodeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;
  var isChecked = false.obs;
  final RxBool isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void validateAndProceed() {
    if (!isChecked.value) {
      Get.snackbar(
        'Error',
        'You must accept the Terms of Use and Privacy Policy to continue.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
  }

  bool checkValidation() {
    if (!(formKey.currentState?.validate() ?? false)) {
      return false;
    }
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar('Error', 'Passwords do not match.', backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
    return true;
  }

  Future<void> verifyCode() async {
    String verificationCode = verificationCodeController.text.trim();
    if (verificationCode.isEmpty || verificationCode.length < 6) {
      Get.snackbar(
        'Error',
        'Please enter a valid verification code.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;
    final result = await signupRepo.verifyOtp(VerifyOtpRequest(
      email: emailController.text.trim(),
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
        );
      },
          (response) {
        if (response['message'] != null && response['message'] == "Email verified. Set your password now.") {
          Get.to(() => SetPasswordScreen());
        } else {
          Get.snackbar(
            'Error',
            'Invalid OTP.',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      },
    );
  }

  Future<void> setPassword() async {
    if (!isChecked.value) {
      Get.snackbar(
        'Error',
        'You must accept the Terms of Use and Privacy Policy to continue.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (!checkValidation()) return;

    isLoading.value = true;
    final result = await signupRepo.setPassword(SetPasswordRequest(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      password_confirmation: confirmPasswordController.text.trim(),
    ));
    isLoading.value = false;

    result.fold(
          (failure) {
        Get.snackbar(
          'Error',
          failure.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      },
          (response) {
        if (response['message'] != null && response['message'] == "Password set successfully. You can now log in.") {
          Get.snackbar(
            'Success',
            'Password set successfully! You can now log in.',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.offAll(() => LoginScreen());
        } else {
          Get.snackbar(
            'Error',
            'Something went wrong. Please try again.',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      },
    );
  }

  Future<void> signUp(BuildContext context) async {
    if (!checkValidation()) return;

    isLoading.value = true;
    final signupRequest = SignupRequest(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
    );

    final result = await signupRepo.signup(signupRequest);
    isLoading.value = false;

    result.fold(
          (failure) {
        Get.snackbar(
          'Error',
          failure.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      },
          (signupModel) {
        if (signupModel.message != null) {
          if (signupModel.message!.contains('OTP sent')) {
            Get.to(() => VerificationScreen(email: signupModel.email ?? ""));
          } else if (signupModel.message!.contains('New OTP sent')) {
            Get.to(() => VerificationScreen(email: signupModel.email ?? ""));
            Get.snackbar(
              'Success',
              'A new OTP has been sent to your email.',
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
          } else if (signupModel.message!.contains('OTP already sent')) {
            Get.to(() => VerificationScreen(email: signupModel.email ?? ""));

            Get.snackbar(
              'Info',
              'OTP already sent. Please wait or check your email.',
              backgroundColor: Colors.orange,
              colorText: Colors.white,
            );
          } else if (signupModel.message!.contains('User already verified')) {
            Get.snackbar(
              'Info',
              'User already verified.',
              backgroundColor: Colors.blue,
              colorText: Colors.white,
            );
          } else {
            Get.snackbar(
              'Error',
              'An unexpected error occurred.',
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        }
      },
    );
  }  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    verificationCodeController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
