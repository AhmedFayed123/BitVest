import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/sizes.dart';

class WelcomeButton extends StatelessWidget {
  const WelcomeButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
  });

  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160.w, // Fixed width
      height: 50.h, // Reduced height
      child: isOutlined
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                side:
                    const BorderSide(color: kAmberColor), // Amber border
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.borderRadiusSimi), // Rounded corners
                ),
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: kAmberColor, // Amber text
                  fontSize: 16, // Adjusted font size
                  fontWeight: FontWeight.w600, // Semi-bold
                ),
              ),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: kAmberColor, // Amber background
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.borderRadiusSimi), // Rounded corners
                ),
                elevation: 4, // Subtle shadow
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: kBlackColor, // Black text
                  fontSize: 16, // Adjusted font size
                  fontWeight: FontWeight.w600, // Semi-bold
                ),
              ),
            ),
    );
  }
}
