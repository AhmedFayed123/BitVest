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
      padding: EdgeInsets.symmetric(vertical: 16.0.h,horizontal: 16),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h,horizontal: 24.w),
          height: 151.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            color: kCardBackgroundColor,
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
                        style: AppStyles.textStyle19regular,
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        '\$5,000',
                        style: AppStyles.textStyle24regular,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '+\$2,987',
                        style: AppStyles.textStyle20regular,
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        '+130.7%',
                        style: AppStyles.textStyle18regular,
                      )
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(child: ActionButton(title: 'Withdraw', onPressed: () {  }, icon: AppIcons.arrow_circle_down,)),
                  SizedBox(width: 5.w,),
                  Expanded(child: ActionButton(title: 'Deposit', onPressed: () {  }, icon: AppIcons.arrow_circle_upward,))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
