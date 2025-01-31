import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'crypto_card.dart';

class CryptoCardList extends StatelessWidget {
  const CryptoCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: SizedBox(
        height: 200.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return CryptoCard(
              name: 'Bitcoin',
              symbol: 'BTC',
              price: '27,6642.01',
              change: '+268.12',
              percent: '+0.97%',
            );
          },
        ),
      ),
    );
  }
}
