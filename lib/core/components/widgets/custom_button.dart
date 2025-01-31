import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../constant/colors.dart';
import '../../constant/sizes.dart';
import '../../settings/theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // يجعل الزر يأخذ العرض الكامل
      height: Sizes.buttonHeightMedium, // تحديد ارتفاع الزر
      child: isOutlined
          ? OutlinedButton(
              onPressed: isLoading ? null : onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: backgroundColor ?? kButtonPrimaryColor),
                padding: EdgeInsets.symmetric(vertical: Sizes.kButtonPadding),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(kBorderRadius), // تعديل الزوايا
                ),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(
                      color: kButtonPrimaryColor,
                    )
                  : Text(
                      text,
                      style: TextStyle(
                        color: textColor ?? kButtonPrimaryColor,
                        fontSize: Sizes.kFontSize, // تكبير الخط
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            )
          : ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor ?? kButtonPrimaryColor,
                padding: EdgeInsets.symmetric(vertical: Sizes.kButtonPadding),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(kBorderRadius), // تعديل الزوايا
                ),
                shadowColor: kButtonTextColor,
                // إضافة ظل للزر
                elevation: 5, // زيادة تأثير الرفع
              ),
              child: isLoading
                  ? const SpinKitFadingCircle(
                      color: kAmberColor, // لون الذهب
                      size: 30.0, // يمكنك تعديل الحجم كما تشاء
                    )
                  : Text(
                      text,
                      style: TextStyle(
                        color: textColor ?? kBlackColor,
                        fontSize: Sizes.kFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
    );
  }
}
