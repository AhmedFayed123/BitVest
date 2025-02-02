import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/colors.dart';
import '../../constant/icons.dart';
import '../../constant/strings.dart';
import '../../constant/styles.dart';

class CustomSeeAllRow extends StatelessWidget {
  const CustomSeeAllRow({super.key, required this.title, required this.onPressed, required this.isSeeAll});

  final String title;
  final VoidCallback onPressed;
  final bool isSeeAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppStyles.textStyle14semiBold,
          ),
          GestureDetector(
            onTap: onPressed,
            child: Row(
              children: [
                Text(
                  isSeeAll?Strings.seeAll:'',
                  style: AppStyles.textStyle12regular,
                ),
                Icon(
                  isSeeAll?AppIcons.arrow_forward:null,
                  color: kPrimaryTextColor,
                  size: 12,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
