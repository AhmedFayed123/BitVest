import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/constant/clases.dart';
import '../../../../trade/presentation/views/coin_details_view.dart';
import '../../controllers/home_controller/home_controller.dart';
import 'crypto_card.dart';

class CryptoCardList extends StatelessWidget {
  const CryptoCardList({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    return SizedBox(
      height: 200.h,
      child: Obx(() {
        if (homeController.isLoading.value) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Skeletonizer(
                  enabled: true,
                  child: CryptoCard(
                    name: "Loading...",
                    symbol: "XXX",
                    price: "\$0.00",
                    change: "0.00 USDT",
                    percent: "0.00%",
                    chartData: generateDummyChartData(2),
                    isNegative: false,
                    imageUrl: "",
                    onTap: () {},
                  ),
                ),
              );
            },
          );
        }

        final popularCoins = homeController.popularCoins.value?.coins ?? [];

        if (popularCoins.isEmpty) {
          return Center(
            child: Text(
              "No Most Popular Coins Available".tr,
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: popularCoins.length,
          itemBuilder: (context, index) {
            final coin = popularCoins[index];

            return CryptoCard(
              name: coin.name ?? '',
              symbol: coin.symbol?.toUpperCase() ?? '',
              price: "\$${coin.price?.toStringAsFixed(2) ?? ''}",
              change: "${coin.changeRateUsdt?.toStringAsFixed(2) ?? ""} USDT",
              percent: "${coin.changeRatePercentage?.toStringAsFixed(2) ?? ""}%",
              chartData: generateDummyChartData(coin.changeRatePercentage ?? 2),
              isNegative: (coin.changeRatePercentage ?? 0) < 0,
              imageUrl: coin.icon ?? "",
              onTap: () => Get.to(() => CoinDetailsView(coinId: coin.id ?? "")),
            );
          },
        );
      }),
    );
  }
}