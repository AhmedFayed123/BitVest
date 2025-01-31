import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/components/widgets/custom_button.dart';
import '../../../../../core/components/widgets/custom_text_form_field.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/sizes.dart';
import '../../../../../core/constant/strings.dart';
import '../controllers/reset_password_controller.dart';


class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ResetPasswordController controller =
    Get.put(ResetPasswordController());

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
                CustomTextFormField(
                  hintText: Strings.newPassword,
                  controller: controller.newPasswordController,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return Strings.kPasswordValidation;
                    }
                    if (value.length < Strings.kMinPasswordLength) {
                      return Strings.kPasswordTooShort;
                    }
                    return null;
                  },
                ),
                SizedBox(height: Sizes.spaceLarge),
                CustomTextFormField(
                  hintText: Strings.confirmPassword,
                  controller: controller.confirmPasswordController,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return Strings.kConfirmPasswordValidation;
                    }
                    if (value != controller.newPasswordController.text) {
                      return Strings.kPasswordsDoNotMatch;
                    }
                    return null;
                  },
                ),
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
