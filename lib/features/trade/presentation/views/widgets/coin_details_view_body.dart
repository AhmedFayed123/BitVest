import 'package:bitvest/core/components/widgets/circle_loading.dart';
import 'package:bitvest/core/components/widgets/custom_tab_bar.dart';
import 'package:bitvest/core/constant/styles.dart';
import 'package:bitvest/features/trade/presentation/views/widgets/buy_screen.dart';
import 'package:bitvest/features/trade/presentation/views/widgets/sell_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../core/constant/clases.dart';
import '../../../../../core/constant/colors.dart';
import '../../controller/chart_controller.dart';
import '../../controller/coin_details_controller.dart';
import '../../controller/trade_controller.dart';

class CoinDetailsViewBody extends StatelessWidget {
  const CoinDetailsViewBody({super.key, required this.coinId});

  final String coinId;

  @override
  Widget build(BuildContext context) {
    final CoinDetailsController controller =
        Get.put(CoinDetailsController());
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
          appBar: AppBar(),
          body: RefreshIndicator(
            color: kAmberColor,
            backgroundColor: kBlackColor,
            strokeWidth: 3,
            onRefresh: controller.refreshData,
            child: Container(
              height: 500,
              child: Center(
                child: Text("No Data Available",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        );
      }

      final List<ChartSampleData> chartData = (controller
                  .selectedChartData?.isNotEmpty ??
              false)
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
                throw Exception("Invalid data format in selectedChartData: $e");
              }
            }).toList()
          : [];

      return RefreshIndicator(
        color: kAmberColor,
        backgroundColor: kBlackColor,
        strokeWidth: 3,
        onRefresh: controller.refreshData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Get.back(),
                      ),
                      Text(
                        "${coin.name}/USDT",
                        style: AppStyles.textStyle16regular,
                      ),
                      GestureDetector(
                        onTap: () => tradeController.toggleFavourite(
                          coin.id ?? '',
                        ),
                        child: Obx(() {
                          return Icon(
                            tradeController.isFavourite(coin.name??'')
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.white,
                            size: 22.sp,
                          );
                        }),
                      ),                ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Row(
                    children: [
                      Text(
                        "\$${coin.currentPrice?.toString() ?? "0.00"}",
                        style: AppStyles.textStyle24regular,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "${coin.priceChange24h?.toStringAsFixed(2) ?? "0.00"}\$ (${coin.priceChangePercentage24h?.toStringAsFixed(2)}%)",
                        style: TextStyle(
                          color: (coin.priceChange24h ?? 0) < 0
                              ? Colors.red
                              : Colors.green,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                CustomTabBar(
                  tabBarViewHeight: 420,
                  tabs: [
                    Tab(text: 'Chart'),
                    Tab(text: 'Market'),
                    Tab(text: 'More Info'),
                    Tab(text: 'Statistics'),
                  ],
                  tabBarViewChildren: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20.0.h),
                          child: Obx(() {
                            return SfCartesianChart(
                              plotAreaBorderWidth: 0,
                              zoomPanBehavior: ZoomPanBehavior(
                                enablePinching: true,
                                enablePanning: true,
                                enableSelectionZooming: true,
                                enableDoubleTapZooming: true,
                              ),
                              tooltipBehavior: TooltipBehavior(
                                enable: true,
                                color: Colors.black,
                                textStyle: TextStyle(color: Colors.white),
                              ),
                              primaryXAxis: DateTimeAxis(
                                isVisible: true,
                                axisLine: AxisLine(
                                  color: Colors.grey,
                                  width: .5,
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                majorGridLines: MajorGridLines(width: 0.0),
                              ),
                              primaryYAxis: NumericAxis(isVisible: false),
                              series: <CartesianSeries>[
                                SplineSeries<ChartSampleData, DateTime>(
                                  dataSource: chartData,
                                  xValueMapper: (ChartSampleData data, _) => data.x,
                                  yValueMapper: (ChartSampleData data, _) => data.close,
                                  color: chartController.lineColor.value,
                                  width: chartController.lineWidth.value,
                                  animationDuration: 1000,
                                  enableTooltip: true,
                                  markerSettings: MarkerSettings(
                                    isVisible: chartController.showMarkers.value,
                                    shape: DataMarkerType.circle,
                                    color: chartController.markerColor.value,
                                    borderWidth: 1.5,
                                    borderColor: Colors.white,
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: ['7D', '30D', '90D'].map((period) {
                              return Obx(() => TextButton(
                                onPressed: () {
                                  controller.changePeriod(period);
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                  controller.selectedPeriod.value == period
                                      ? Colors.green.withOpacity(0.2)
                                      : Colors.transparent,
                                  foregroundColor:
                                  controller.selectedPeriod.value == period
                                      ? Colors.green
                                      : Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 10.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                    side: BorderSide(
                                      color: controller.selectedPeriod.value == period
                                          ? Colors.green
                                          : Colors.grey.shade400,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  period,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ));
                            }).toList(),
                          ),
                        ),

                      ],
                    ),

                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Market Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.lightBlueAccent)),
                          SizedBox(height: 10),
                          Text('Current Price: \$${coin.currentPrice}', style: TextStyle(fontSize: 16, color: Colors.white70)),
                          Text('Highest 24h Price: \$${coin.high24h}', style: TextStyle(fontSize: 16, color: Colors.white70)),
                          Text('Lowest 24h Price: \$${coin.low24h}', style: TextStyle(fontSize: 16, color: Colors.white70)),
                          Text('Last Update: ${coin.lastUpdated}', style: TextStyle(fontSize: 16, color: Colors.white70)),

                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('More Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.lightBlueAccent)),
                          SizedBox(height: 10),
                          Text('Market Volume: ${coin.totalVolume}', style: TextStyle(fontSize: 16, color: Colors.white70)),
                          Text('Market Cap: ${coin.marketCap}', style: TextStyle(fontSize: 16, color: Colors.white70)),
                          Text('Change (24h): ${coin.priceChangePercentage24h}%', style: TextStyle(fontSize: 16, color: Colors.white70)),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Statistics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.lightBlueAccent)),
                          SizedBox(height: 10),
                          Text('Circulating Supply: ${coin.circulatingSupply}', style: TextStyle(fontSize: 16, color: Colors.white70)),
                          Text('Total Supply: ${coin.totalSupply}', style: TextStyle(fontSize: 16, color: Colors.white70)),
                          Text('Max Supply: ${coin.maxSupply}', style: TextStyle(fontSize: 16, color: Colors.white70)),
                          Text('All Time High: \$${coin.ath}', style: TextStyle(fontSize: 16, color: Colors.white70)),
                          Text('ATH Change %: ${coin.athChangePercentage}%', style: TextStyle(fontSize: 16, color: Colors.white70)),
                          Text('All Time Low: \$${coin.atl}', style: TextStyle(fontSize: 16, color: Colors.white70)),
                          Text('ATL Change %: ${coin.atlChangePercentage}%', style: TextStyle(fontSize: 16, color: Colors.white70)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(BuyScreen(cryptoName: coin.name??'', marketPrice: coin.currentPrice??0.0, cryptoId: coin.id??'',));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            "Buy",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(SellScreen(cryptoName: coin.name??'', marketPrice: coin.currentPrice??0.0, cryptoId: coin.id??'',));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            "Sell",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      );
    });
  }
}
