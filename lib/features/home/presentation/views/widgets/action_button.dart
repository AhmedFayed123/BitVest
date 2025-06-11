import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/styles.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.icon,
    this.backgroundColor = Colors.grey,
    this.iconColor = Colors.black,
    this.textColor = Colors.black,
  });

  final String title;
  final VoidCallback onPressed;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: backgroundColor.withOpacity(0.6),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 22.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              title,
              style: AppStyles.textStyle16bold.copyWith(
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
