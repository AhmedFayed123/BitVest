import 'package:bitvest/features/wallet/presentation/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/components/widgets/custom_crypto_list_item.dart';
import '../../../../../core/constant/clases.dart';
import '../../../../trade/presentation/views/coin_details_view.dart';

class MyAssetsList extends StatelessWidget {
  const MyAssetsList({super.key});

  @override
  Widget build(BuildContext context) {
    final WalletController controller = Get.find<WalletController>();

    return SizedBox(
      child: Obx(() {
        if (controller.isLoading.value) {
          return Skeletonizer(
            enabled: true,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 5,
              itemBuilder: (context, index) {
                return CustomCryptoListItem(
                  name: "Loading...",
                  symbol: "---",
                  price: "\$0.00",
                  change: "0.00 USDT",
                  percent: "0.00%",
                  isNegative: false,
                  chartData: generateDummyChartData(0),
                  img: '',
                  onTap: () {}, id: '',
                );
              },
            ),
          );
        }

        final walletsCoins = controller.wallets.value.data;

        if (walletsCoins == null || walletsCoins.isEmpty) {
          return const Center(
            child: Text(
              "No wallets coins available",
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: walletsCoins.length,
          itemBuilder: (context, index) {
            final coin = walletsCoins[index];

            return CustomCryptoListItem(
              name: coin.name ?? "Unknown",
              symbol: coin.symbol!.toUpperCase() ?? "N/A",
              price: "\$${coin.price!.toStringAsFixed(2) ?? "0.00"}",
              change:
                  "${coin.changeRateUsdt!.toStringAsFixed(2) ?? "0.00"} USDT",
              percent:
                  "${coin.changeRatePercentage!.toStringAsFixed(2) ?? "0.00"}%",
              isNegative: (coin.changeRatePercentage ?? 0) < 0,
              chartData: generateDummyChartData(coin.changeRatePercentage ?? 0),
              img: coin.icon ?? '',
              onTap: () => Get.to(() => CoinDetailsView(coinId: coin.id ?? '')),
              id: coin.id ?? '',
            );
          },
        );
      }),
    );
  }
}
