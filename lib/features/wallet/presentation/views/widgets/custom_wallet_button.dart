import 'package:bitvest/core/constant/colors.dart';
import 'package:bitvest/core/constant/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomWalletButton extends StatelessWidget {
  const CustomWalletButton(
      {super.key,
      required this.icon,
      required this.onPressed,
      required this.title});

  final IconData icon;
  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: kBorderColor, width: .5.w),
              color: kPrimaryColor,
            ),
            child: Icon(
              icon,
              color: kPrimaryTextColor,
              size: 38,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            title,
            style:
                AppStyles.textStyle14regular.copyWith(color: kPrimaryTextColor),
          )
        ],
      ),
    );
  }
}
