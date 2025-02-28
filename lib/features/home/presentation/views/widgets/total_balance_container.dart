import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/icons.dart';
import '../../../../../core/constant/styles.dart';
import 'action_button.dart';

class TotalBalanceContainer extends StatelessWidget {
  const TotalBalanceContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 16.w),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 4),
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                kSecondaryTextColor.withOpacity(0.3),
                kCardBackgroundColor.withOpacity(0.9),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Balance',
                        style: AppStyles.textStyle19regular.copyWith(
                          color: kPrimaryTextColor.withOpacity(0.8),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '\$5,000',
                        style: AppStyles.textStyle24regular.copyWith(
                          color: kPrimaryTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '+\$2,987',
                        style: AppStyles.textStyle20regular.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '+130.7%',
                        style: AppStyles.textStyle18regular.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ActionButton(
                      title: 'Withdraw',
                      onPressed: () {},
                      icon: AppIcons.arrow_circle_down,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: ActionButton(
                      title: 'Deposit',
                      onPressed: () {},
                      icon: AppIcons.arrow_circle_upward,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}