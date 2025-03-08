import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../market/presentation/controller/market_controller.dart';

class CryptoTicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MarketController controller = Get.put(MarketController());

    return Container(
      height: 30.h,
      width: double.infinity,
      color: Colors.black,
      child: Obx(() {
        if (controller.isLoading.value) {
          return Skeletonizer(
            enabled: true,
            child: Marquee(
              text: "Loading...   •   Loading...   •   Loading...",
              style: TextStyle(fontSize: 16.sp, color: Colors.white),
              scrollAxis: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              blankSpace: 50.0.w,
              velocity: 30.0,
              pauseAfterRound: Duration(seconds: 1),
              startPadding: 10.0,
              accelerationDuration: Duration(seconds: 1),
              accelerationCurve: Curves.linear,
              decelerationDuration: Duration(milliseconds: 500),
              decelerationCurve: Curves.easeOut,
            ),
          );
        }

        final marketData = controller.marketData;
        if (marketData.isEmpty) {
          return Center(
            child: Text(
              "No market data available",
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        return Marquee(
          text: marketData.map((coin) {
            final priceChange = coin.changeRatePercentage ?? 0.0;
            final isNegative = priceChange < 0;
            final changeColor = isNegative ? "🔴" : "🟢";

            return "#${coin.marketCapRank} ${coin.symbol!.toUpperCase()} "
                "$changeColor ${priceChange.toStringAsFixed(2)}% ";
          }).join("  •  "),
          style: TextStyle(fontSize: 16.sp, color: Colors.white),
          scrollAxis: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.center,
          blankSpace: 50.0.w,
          velocity: 30.0,
          pauseAfterRound: Duration(seconds: 1),
          startPadding: 10.0,
          accelerationDuration: Duration(seconds: 1),
          accelerationCurve: Curves.linear,
          decelerationDuration: Duration(milliseconds: 500),
          decelerationCurve: Curves.easeOut,
        );
      }),
    );
  }
}
