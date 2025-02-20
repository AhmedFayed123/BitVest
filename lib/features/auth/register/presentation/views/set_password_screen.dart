import 'package:bitvest/features/auth/register/presentation/views/terms_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../../core/components/widgets/custom_button.dart';
import '../../../../../core/components/widgets/custom_text_form_field.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/sizes.dart';
import '../../../../../core/constant/strings.dart';
import '../../../../../core/constant/styles.dart';
import '../../../../../core/resources/images.dart';
import '../controller/sign_up_controller.dart';

class SetPasswordScreen extends StatelessWidget {
  const SetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController controller = Get.find();

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        automaticallyImplyLeading: false,
        // iconTheme: const IconThemeData(color: kWhiteColor),
        title: const Text(Strings.setPassword, style: TextStyle(color: kWhiteColor)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.paddingLarge),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Image.asset(
                  Images.appLogo,
                  height: Sizes.iconAuthLarge,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      Images.appLogo,
                      width: Sizes.iconSizeLarge,
                      height: Sizes.iconSizeLarge,
                    ),
                    Center(
                      child: Text(
                        Strings.appName,
                        style: AppStyles.regularTextStyle.copyWith(
                          color: kWhiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: Sizes.fontSizeLarge,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Sizes.spaceLarger),
                Obx(() {
                  return CustomTextFormField(
                    hintText: Strings.password,
                    controller: controller.passwordController,
                    isPassword: true,
                    isPasswordVisible: controller.isPasswordVisible.value,
                    togglePasswordVisibility: controller.togglePasswordVisibility,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return Strings.kPasswordValidation;
                      }
                      if (value.length < 6) {
                        return "Password must be at least 6 characters long.";
                      }
                      return null;
                    },
                  );
                }),
                SizedBox(height: Sizes.spaceLarge),
                Obx(() {
                  return CustomTextFormField(
                    hintText: Strings.confirmPassword,
                    controller: controller.confirmPasswordController,
                    isPassword: true,
                    isPasswordVisible: controller.isConfirmPasswordVisible.value,
                    togglePasswordVisibility: controller.toggleConfirmPasswordVisibility,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return Strings.kConfirmPasswordValidation;
                      }
                      if (value != controller.passwordController.text) {
                        return Strings.kPasswordsDoNotMatch;
                      }
                      return null;
                    },
                  );
                }),
                const TermsCheckbox(),
                SizedBox(height: Sizes.spaceLarge),
                CustomButton(
                  text: Strings.signUp,
                  onPressed: controller.setPassword,
                  isLoading: controller.isLoading.value,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}