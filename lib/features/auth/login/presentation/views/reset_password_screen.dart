import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/components/widgets/custom_button.dart';
import '../../../../../core/components/widgets/custom_text_form_field.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/sizes.dart';
import '../../../../../core/constant/strings.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});

  final String email;
  @override
  Widget build(BuildContext context) {
    final ResetPasswordController controller =
        Get.put(ResetPasswordController(email: email));

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kWhiteColor),
        title: const Text(
          Strings.resetPassword,
          style: TextStyle(color: kWhiteColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.paddingLarge),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Obx(() => CustomTextFormField(
                      hintText: Strings.newPassword,
                      controller: controller.newPasswordController,
                      isPassword: true,
                      isPasswordVisible: controller.isPasswordVisible.value,
                      togglePasswordVisibility:
                          controller.togglePasswordVisibility,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return Strings.kPasswordValidation;
                        }
                        if (value.length < Strings.kMinPasswordLength) {
                          return Strings.kPasswordTooShort;
                        }
                        return null;
                      },
                    )),
                SizedBox(height: Sizes.spaceLarge),
                Obx(() => CustomTextFormField(
                      hintText: Strings.confirmPassword,
                      controller: controller.confirmPasswordController,
                      isPassword: true,
                      isPasswordVisible: controller.isPasswordVisible.value,
                      togglePasswordVisibility:
                          controller.togglePasswordVisibility,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return Strings.kConfirmPasswordValidation;
                        }
                        if (value != controller.newPasswordController.text) {
                          return Strings.kPasswordsDoNotMatch;
                        }
                        return null;
                      },
                    )),
                SizedBox(height: Sizes.spaceLarge),
                Obx(() => CustomButton(
                      text: Strings.resetPassword,
                      onPressed: controller.isLoading.value
                          ? () {}
                          : controller.resetPassword,
                      isLoading: controller.isLoading.value,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
