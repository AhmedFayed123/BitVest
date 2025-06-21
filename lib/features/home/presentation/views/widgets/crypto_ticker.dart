import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../market/presentation/controller/market_controller.dart';

class CryptoTicker extends StatelessWidget {
  const CryptoTicker({super.key});

  @override
  Widget build(BuildContext context) {
    final MarketController controller = Get.put(MarketController());

    return Container(
      height: 32.h,
      width: double.infinity,
      color: const Color(0xFF1A1A1A),
      child: Obx(() {
        if (controller.isLoading.value) {
          return Skeletonizer(
            enabled: true,
            child: Marquee(
              text: "Loading market data...   •   Please wait...   •   Loading...",
              style: TextStyle(fontSize: 13.sp, color: Colors.white),
              blankSpace: 60.w,
              velocity: 30.0,
              pauseAfterRound: const Duration(seconds: 1),
              startPadding: 10.0,
            ),
          );
        }

        final marketData = controller.marketData;
        if (marketData.isEmpty) return const SizedBox();

        // نص واحد بـ لون موحّد، لكن نحط العملات باللون الأبيض ونسبة التغيير بالألوان
        final tickerText = marketData.map((coin) {
          final priceChange = coin.changeRatePercentage ?? 0.0;
          final isNegative = priceChange < 0;
          final arrow = isNegative ? "↓" : "↑";
          final colorCode = isNegative ? "🔻" : "🟢↑"; // ✅ هنستخدمه
          final symbol = coin.symbol?.toUpperCase() ?? "";
          return "$colorCode $symbol $arrow ${priceChange.abs().toStringAsFixed(2)}%";
        }).join("   •   ");


        return Marquee(
          text: tickerText,
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          blankSpace: 60.w,
          velocity: 30.0,
          pauseAfterRound: const Duration(seconds: 1),
          startPadding: 10.0,
          accelerationDuration: const Duration(milliseconds: 800),
          accelerationCurve: Curves.easeIn,
          decelerationDuration: const Duration(milliseconds: 500),
          decelerationCurve: Curves.easeOut,
        );
      }),
    );
  }
}
