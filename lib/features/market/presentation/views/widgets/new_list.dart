import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/components/widgets/custom_crypto_list_item.dart';
import '../../../../../core/constant/clases.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../trade/presentation/views/coin_details_view.dart';
import '../../controller/market_controller.dart';

class NewList extends StatelessWidget {
  const NewList({super.key});

  @override
  Widget build(BuildContext context) {
    final MarketController controller = Get.put(MarketController());

    return Obx(() {
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
      if (controller.newData.isEmpty) {
        return RefreshIndicator(
          color: kAmberColor,
          backgroundColor: kBlackColor,
          strokeWidth: 3,
          onRefresh: controller.refreshData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              height: 500.h,
              child: Center(
                child: Text(
                  "No New Coins Available",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        );
      }
      return RefreshIndicator(
        color: kAmberColor,
        backgroundColor: kBlackColor,
        strokeWidth: 3,
        onRefresh: controller.refreshData,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: controller.newData.length,
          itemBuilder: (context, index) {
            final market = controller.newData[index];

            return CustomCryptoListItem(
              onTap: () => Get.to(() => CoinDetailsView(coinId: market.id!)),
              name: market.name ?? "Unknown",
              symbol: market.symbol ?? "--",
              price: market.price?.toStringAsFixed(2) ?? "0.00",
              change: market.changeRateUsdt?.toStringAsFixed(2) ?? "0.00",
              percent:
                  "${market.changeRatePercentage?.toStringAsFixed(2) ?? "0.00"}%",
              isNegative: (market.changeRatePercentage ?? 0) < 0,
              chartData:
                  generateDummyChartData(market.changeRatePercentage ?? 0),
              img: market.icon ?? '', id: market.id??'',
            );
          },
        ),
      );
    });
  }
}
