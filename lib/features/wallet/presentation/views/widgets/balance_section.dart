import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/styles.dart';

class BalanceSection extends StatelessWidget {
  const BalanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 22.h),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Balance',
              style: AppStyles.textStyle12regular,
            ),
            SizedBox(
              height: 4.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$5,000',
                  style: AppStyles.textStyle24regular,
                ),
                SizedBox(width: 3.w,),
                Text(
                  'usd',
                  style: AppStyles.textStyle12regular,
                ),
              ],
            ),
            Text(
              'Todayy\'s PNL +\$0,00(+0.00%)',
              style: AppStyles.textStyle12regular,
            ),
          ],
        ),
      ),
    );
  }
}
