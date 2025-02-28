import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/components/widgets/circle_loading.dart';
import '../../../../../core/components/widgets/custom_crypto_list_item.dart';
import '../../../../../core/constant/clases.dart';
import '../../../../trade/presentation/views/coin_details_view.dart';
import '../../controllers/home_controller/home_controller.dart';

class HighestLossList extends StatelessWidget {
  const HighestLossList({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    return SizedBox(
      child: Obx(() {
        if (homeController.isLoading.value) {
          return const CircleLoading();
        }


        final highestVolumeCoins = homeController.highestChangeDown.value?.coins ?? [];

        if (highestVolumeCoins.isEmpty) {
          return const Center(
            child: Text("No highest volume coins available", style: TextStyle(color: Colors.white)),
          );
        }

        return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 5,
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
              onTap: () => Get.to(() => CoinDetailsView(coinId: coin.id)),

            );
          },
        );
      }),
    );
  }
}
