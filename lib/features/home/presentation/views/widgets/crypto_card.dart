import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/styles.dart';
import 'card_line_chart.dart';

class CryptoCard extends StatelessWidget {
  const CryptoCard(
      {super.key,
      required this.name,
      required this.symbol,
      required this.price,
      required this.change,
      required this.percent});

  final String name, symbol, price, change, percent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0.w),
      child: Container(
        width: 150.w,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: kCardBackgroundColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.monetization_on, color: Colors.amber),
                SizedBox(width: 8.w,),
                Text(
                  name,
                  style: AppStyles.textStyle20regular,
                ),
              ],
            ),
            Text(
              symbol,
              style: AppStyles.textStyle18semiBold,

            ),
            SizedBox(height: 65.h, child: CardLineChart()),

            Text(
              "\$$price",
              style: AppStyles.textStyle16regular,

            ),
            Text("$change | $percent",
                style: TextStyle(color: Colors.green, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
