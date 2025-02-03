import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/styles.dart';

class ActionButton extends StatelessWidget {
  const ActionButton(
      {super.key,
      required this.title,
      required this.onPressed,
      required this.icon});

  final String title;
  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 38.h,
        width: 140.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          color: kHintTextColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: kPrimaryTextColor,
              size: 22.sp,
            ),
            Text(
              title,
              style: AppStyles.textStyle14w500,
            )
          ],
        ),
      ),
    );
  }
}
