import 'package:bitvest/core/components/widgets/circle_loading.dart';
import 'package:bitvest/core/constant/icons.dart';

import 'package:bitvest/features/trade/presentation/views/widgets/buy_screen.dart';
import 'package:bitvest/features/trade/presentation/views/widgets/sell_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../core/constant/clases.dart';
import '../../controller/chart_controller.dart';
import '../../controller/coin_details_controller.dart';
import '../../controller/trade_controller.dart';

class CoinDetailsViewBody extends StatelessWidget {
  const CoinDetailsViewBody({super.key, required this.coinId});

  final String coinId;

  @override
  Widget build(BuildContext context) {
    final CoinDetailsController controller = Get.put(CoinDetailsController());
    controller.changeCoin(coinId);

    final ChartController chartController = Get.put(ChartController());
    final TradeController tradeController = Get.put(TradeController());

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircleLoading());
      }

      final coin = controller.coinData.value?.original;
      if (coin == null) {
        return Scaffold(
          appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
          body: RefreshIndicator(
            color: Colors.amberAccent,
            backgroundColor: Colors.black,
            strokeWidth: 2,
            onRefresh: controller.refreshData,
            child: Center(
              child: Text("No Data Available",
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        );
      }

      final List<ChartSampleData> chartData =
      (controller.selectedChartData?.isNotEmpty ?? false)
          ? controller.selectedChartData!.map<ChartSampleData>((e) {
        if (e.length >= 2) {
          double price = (e[1] as num).toDouble();
          return ChartSampleData(
            x: DateTime.fromMillisecondsSinceEpoch(e[0]),
            open: price,
            high: price,
            low: price,
            close: price,
          );
        } else {
          throw Exception(
              "Invalid data format in selectedChartData: $e");
        }
      }).toList()
          : [];

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Trade",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          leading:
            IconButton(
              onPressed: () => Get.back(),
              icon: Icon(AppIcons.back_arrow,),
            ),
        ),

        body: RefreshIndicator(
          onRefresh: controller.refreshData,
          color: Colors.amberAccent,
          backgroundColor: Colors.black,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16.r,
                          backgroundColor: Colors.white10,
                          child: Icon(Icons.currency_bitcoin,
                              color: Colors.amber, size: 20.sp),
                        ),
                        SizedBox(width: 8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${coin.name}",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "/USDT",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.white60,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Text(
                                  "\$${coin.currentPrice?.toString() ?? "0.00"}",
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Container(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    color: (coin.priceChange24h ?? 0) < 0
                                        ? Colors.red.withOpacity(0.2)
                                        : Colors.green.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    "${coin.priceChange24h?.toStringAsFixed(2) ?? "0.00"}\$ (${coin.priceChangePercentage24h?.toStringAsFixed(2)}%)",
                                    style: TextStyle(
                                      color: (coin.priceChange24h ?? 0) < 0
                                          ? Colors.red
                                          : Colors.green,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Obx(() => Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            tradeController.isFavourite(coin.name ?? '')
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amberAccent,
                            size: 24.sp,
                          ),
                          onPressed: () =>
                              tradeController.toggleFavourite(coin.id ?? ''),
                        ),
                      ],
                    )),
                  ],
                ),
                SizedBox(height: 24.h),
                Text("Performance",
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 180.h,
                        child: SfCartesianChart(
                          plotAreaBorderWidth: 0,
                          zoomPanBehavior:
                          ZoomPanBehavior(enablePinching: true),
                          tooltipBehavior: TooltipBehavior(enable: true),
                          primaryXAxis: DateTimeAxis(
                            labelStyle: TextStyle(color: Colors.white70),
                            axisLine: AxisLine(color: Colors.grey),
                            majorGridLines: MajorGridLines(width: 0),
                          ),
                          primaryYAxis: NumericAxis(isVisible: false),
                          series: [
                            SplineSeries<ChartSampleData, DateTime>(
                              dataSource: chartData,
                              xValueMapper: (e, _) => e.x,
                              yValueMapper: (e, _) => e.close,
                              color: Colors.amberAccent,
                              width: 2.5,
                              markerSettings: MarkerSettings(isVisible: false),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: ['7D', '30D', '90D'].map((period) {
                          final isSelected =
                              controller.selectedPeriod.value == period;
                          return ChoiceChip(
                            label: Text(period),
                            selected: isSelected,
                            onSelected: (_) =>
                                controller.changePeriod(period),
                            selectedColor: Colors.amber,
                            labelStyle: TextStyle(
                              color:
                              isSelected ? Colors.black : Colors.white,
                            ),
                            backgroundColor: Colors.grey.shade800,
                          );
                        }).toList(),
                      )),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                Text("Coin Overview",
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: _buildInfoList(coin),
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Get.to(BuyScreen(
                          cryptoName: coin.name ?? '',
                          marketPrice: coin.currentPrice ?? 0.0,
                          cryptoId: coin.id ?? '',
                        )),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text("Buy",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Get.to(SellScreen(
                          cryptoName: coin.name ?? '',
                          marketPrice: coin.currentPrice ?? 0.0,
                          cryptoId: coin.id ?? '',
                        )),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text("Sell",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      );
    });
  }

  List<Widget> _buildInfoList(var coin) {
    final Map<String, dynamic> info = {
      "Current Price": "\$${coin.currentPrice}",
      "High 24h": "\$${coin.high24h}",
      "Low 24h": "\$${coin.low24h}",
      "Market Volume": "${coin.totalVolume}",
      "Market Cap": "${coin.marketCap}",
      "Change (24h)": "${coin.priceChangePercentage24h}%",
      "Circulating Supply": "${coin.circulatingSupply}",
      "Total Supply": "${coin.totalSupply}",
      "Max Supply": "${coin.maxSupply}",
      "ATH": "\$${coin.ath}",
      "ATH Change %": "${coin.athChangePercentage}%",
      "ATL": "\$${coin.atl}",
      "ATL Change %": "${coin.atlChangePercentage}%",
    };

    return info.entries
        .map(
          (e) => Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(e.key,
                style: TextStyle(color: Colors.white70, fontSize: 14.sp)),
            Text(e.value,
                style: TextStyle(color: Colors.white, fontSize: 14.sp)),
          ],
        ),
      ),
    )
        .toList();
  }
}