import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/components/widgets/custom_button.dart';
import '../../../../../core/components/widgets/custom_text_form_field.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/sizes.dart';
import '../../../../../core/constant/strings.dart';
import '../../../../../core/constant/styles.dart';
import '../controllers/forget_password_controller.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final ForgotPasswordController controller = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kWhiteColor),
        title: const Text(
          Strings.forgotPassword,
          style: TextStyle(color: kWhiteColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.paddingLarge),
          child: Form(
            key: controller.formKey, // استخدم formKey من الـ Controller
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  Strings.resetPasswordInstructions,
                  textAlign: TextAlign.center,
                  style: AppStyles.regularTextStyle.copyWith(
                    color: kWhiteColor,
                    fontSize: Sizes.fontSizeMedium,
                  ),
                ),
                SizedBox(height: Sizes.spaceLarge),
                CustomTextFormField(
                  hintText: Strings.email,
                  controller: controller.emailOrPhoneController, // استخدم الـ Controller هنا
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return Strings.kEmailValidation;
                    }
                    if (!GetUtils.isEmail(value)) {
                      return Strings.kInvalidEmail;
                    }
                    return null;
                  },
                ),
                SizedBox(height: Sizes.spaceLarge),
                Obx(() => CustomButton(
                  text: Strings.resetPassword,
                  onPressed: controller.isLoading.value
                      ? () {} // تمرير دالة فارغة إذا كان الزر معطل
                      : controller.sendResetLink, // تمرير الدالة الحقيقية إذا كان الزر نشطًا
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
