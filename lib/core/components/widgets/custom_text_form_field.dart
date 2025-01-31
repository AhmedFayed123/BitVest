import 'package:flutter/material.dart';

import '../../constant/colors.dart';
import '../../constant/icons.dart';
import '../../constant/sizes.dart';
import '../../settings/theme.dart';


class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final bool isPasswordVisible;
  final VoidCallback? togglePasswordVisibility;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.togglePasswordVisibility,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: TextStyle(color: Colors.white70, fontSize: Sizes.kFontSizeSmall),
        ),
        SizedBox(height: Sizes.spaceLarge),
        TextFormField(
          controller: controller,
          obscureText: isPassword && !isPasswordVisible,
          keyboardType: keyboardType,
          style: const TextStyle(color: kWhiteColor),
          validator: validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade900,
            hintText: 'Enter Your $hintText',
            hintStyle: const TextStyle(color: kGreyColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kBorderRadius),
              borderSide: const BorderSide(color: kGreyColor), // لون الإطار في حالة عدم التركيز
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kBorderRadius),
              borderSide: const BorderSide(color: kAmberColor), // اللون الذهبي عند التركيز
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kBorderRadius),
              borderSide: const BorderSide(color: kGreyColor), // لون الإطار عندما يكون غير مركّز
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kBorderRadius),
              borderSide: const BorderSide(color: kErrorTextColor), // الإطار عند وجود خطأ سيكون باللون الأحمر
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kBorderRadius),
              borderSide: const BorderSide(color: kErrorTextColor), // الإطار عند التركيز مع خطأ سيكون باللون الأحمر
            ),
            suffixIcon: isPassword
                ? IconButton(
              icon: Icon(
                isPasswordVisible ? AppIcons.visibility : AppIcons.visibility_off,
                color: kGreyColor, // أيقونة كلمة المرور باللون الذهبي
              ),
              onPressed: togglePasswordVisibility,
            )
                : null,
          ),
        ),
      ],
    );
  }
}
