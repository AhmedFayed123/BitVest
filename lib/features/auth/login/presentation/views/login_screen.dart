import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/components/widgets/custom_button.dart';
import '../../../../../core/components/widgets/custom_social_button.dart';
import '../../../../../core/components/widgets/custom_text_form_field.dart';
import '../../../../../core/components/widgets/or_line_widget.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/sizes.dart';
import '../../../../../core/constant/strings.dart';
import '../../../../../core/constant/styles.dart';
import '../../../../../core/resources/images.dart';
import '../../../../../generated/assets.dart';
import '../../../register/presentation/views/sign_up_screen.dart';
import '../controllers/login_controller.dart';
import 'forget_password_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kWhiteColor),
        title: Text(
          Strings.login.tr,
          style: TextStyle(color: kWhiteColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(Sizes.paddingLarge),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    Images.appLogo, // Ensure the path is correct
                    height: Sizes.iconAuthLarge,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        Images.appLogo, // Path to your logo image
                        width: Sizes.iconSizeLarge, // Set the width of the logo
                        height:
                            Sizes.iconSizeLarge, // Set the height of the logo
                      ),
                      Center(
                        child: Text(
                          Strings.appName,
                          style: AppStyles.regularTextStyle.copyWith(
                            color: kWhiteColor, // Override color for error text
                            fontWeight: FontWeight.bold, // Bold the message
                            fontSize: Sizes
                                .fontSizeLarge, // Use the correct font size
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Sizes.spaceLarger,
                  ),
                  CustomTextFormField(
                    hintText: Strings.Email.tr,
                    // Use the existing Strings reference
                    controller: controller.emailController,
                    keyboardType: TextInputType.text,
                    // Accept both text and numbers
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return Strings
                            .kEmailValidation.tr; // Add this string in your index.dart
                      }
                      if (!(GetUtils.isEmail(value))) {
                        return Strings.kInvalidEmail.tr; // Add this string as well
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: Sizes.spaceLarge),
                  // حقل كلمة المرور
                  Obx(() => CustomTextFormField(
                        hintText: Strings.password.tr,
                        controller: controller.passwordController,
                        isPassword: true,
                        isPasswordVisible: controller.isPasswordVisible.value,
                        togglePasswordVisibility:
                            controller.togglePasswordVisibility,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return Strings.kPasswordValidation.tr;
                          }
                          if (value.length < Strings.kMinPasswordLength) {
                            return Strings.kPasswordTooShort.tr;
                          }
                          return null;
                        },
                      )),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        // هنا تضيف الوظيفة الخاصة بك لفتح شاشة استعادة كلمة المرور
                        Get.to(() =>
                            ForgetPasswordScreen()); // الانتقال إلى الشاشة الجديدة
                      },
                      child: Text(
                        Strings.forgotPassword.tr, // نص "نسيت كلمة المرور؟"
                        style: TextStyle(
                          color: kAmberColor,
                          fontSize: Sizes.kFontSizeSmall,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Sizes.spaceLarge),

                  // زر تسجيل الدخول
                  Obx(() => CustomButton(
                        text: Strings.login.tr,
                        onPressed: controller.login,
                        isLoading: controller.isLoading.value,
                      )),
                  OrLineWidget(),
                  CustomSocialButton(
                    title: 'continue_with_google'.tr,
                    icon: Assets.imagesGoogle,
                    buttonColor: kBackgroundColor,
                    textColor: kPrimaryTextColor,
                    borderColor: kPrimaryTextColor,
                    onPressed: () {
                      print("Google Login Clicked");
                    },
                  ),

                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Strings.dontHaveAccount.tr, // نص "ليس لديك حساب؟"
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.kFontSizeSmall,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // هنا تضيف الوظيفة الخاصة بك لفتح صفحة التسجيل
                          Get.off(() =>
                              const SignUpScreen()); // مثال لتوجيه المستخدم إلى صفحة التسجيل
                        },
                        child: Text(
                          Strings.createAccount.tr, // نص "قم بإنشاء حساب"
                          style: TextStyle(
                            color: kAmberColor,
                            fontSize: Sizes.kFontSizeSmall,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
