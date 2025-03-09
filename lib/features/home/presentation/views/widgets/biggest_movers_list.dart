import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/components/widgets/custom_crypto_list_item.dart';
import '../../../../../core/constant/clases.dart';
import '../../../../trade/presentation/views/coin_details_view.dart';
import '../../controllers/home_controller/home_controller.dart';

class BiggestMoversList extends StatelessWidget {
  const BiggestMoversList({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    return SizedBox(
      child: Obx(() {
        if (homeController.isLoading.value) {
          return Skeletonizer(
            enabled: true,
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return CustomCryptoListItem(
                  name: "Loading...",
                  symbol: "----",
                  price: "---",
                  change: "---",
                  percent: "---%",
                  isNegative: false,
                  chartData: [],
                  img: '',
                  onTap: () {}, id: '',
                );
              },
            ),
          );
        }

        final highestVolumeCoins = homeController.highestVolume.value?.coins ?? [];

        if (highestVolumeCoins.isEmpty) {
          return Center(
            child: Text(
              "No Hot Coins Available",
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        return ListView.builder(
          itemCount: highestVolumeCoins.length,
          itemBuilder: (context, index) {
            final coin = highestVolumeCoins[index];

            return CustomCryptoListItem(
              name: coin.name ?? "Unknown",
              symbol: coin.symbol.toUpperCase() ?? "N/A",
              price: "\$${coin.price.toStringAsFixed(2) ?? "0.00"}",
              change: "${coin.changeRateUsdt.toStringAsFixed(2) ?? "0.00"} USDT",
              percent: "${coin.changeRatePercentage.toStringAsFixed(2) ?? "0.00"}%",
              isNegative: (coin.changeRatePercentage ?? 0) < 0,
              chartData: generateDummyChartData(coin.changeRatePercentage ?? 0),
              img: coin.icon ?? '',
              onTap: () => Get.to(() => CoinDetailsView(coinId: coin.id)), id: coin.id,
            );
          },
        );
      }),
    );
  }
}
