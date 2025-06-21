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
import '../../../login/presentation/views/login_screen.dart';
import '../controller/sign_up_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController controller = Get.put(SignUpController());

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kWhiteColor),
        title: Text(
          Strings.createAccount.tr,
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: Sizes.spaceLarge),
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
                  SizedBox(height: Sizes.spaceLarge),
                  CustomTextFormField(
                    hintText: Strings.name.tr,
                    controller: controller.nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return Strings.kNameValidation.tr;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: Sizes.spaceLarge),
                  CustomTextFormField(
                    hintText: Strings.Email.tr,
                    controller: controller.emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return Strings.kEmailValidation.tr;
                      }
                      if (!(GetUtils.isEmail(value) || GetUtils.isPhoneNumber(value))) {
                        return Strings.kInvalidEmail.tr;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: Sizes.buttonHeightSmall),
                  Obx(() => CustomButton(
                    text: Strings.next.tr,
                    onPressed: () {
                      controller.signUp(context);
                    },
                    isLoading: controller.isLoading.value,
                  )),
                  SizedBox(height: 40.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Strings.alreadyHaveAnAccount.tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.kFontSizeSmall,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.off(const LoginScreen());
                        },
                        child: Text(
                          Strings.login.tr,
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